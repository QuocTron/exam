using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ExamManagement.Businesses.Infrastructures;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Data.Repositories;
using ExamManagement.Entities;
using ExamManagement.Services.Exceptions;
using ExamManagement.Services.PSO;

namespace ExamManagement.Businesses
{
    public interface IMatrixBusiness : IBusinessBase<Matrix>
    {
        /// <summary>
        /// Clean details of matrix
        /// </summary>
        /// <param name="id">Matrix id</param>
        /// <returns></returns>
        void CleanDetails(int id);

        /// <summary>
        /// Get details of matrix
        /// </summary>
        /// <param name="id">Matrix id</param>
        /// <returns>MatrixDetail List</returns>
        IEnumerable<MatrixDetail> GetDetails(int shiftsubjectId);

        /// <summary>
        /// Get matices
        /// </summary>
        /// <param name="id">Exam id</param>
        /// <returns>Matrix List</returns>
        IEnumerable<Matrix> GetMatricesByExamId(int examId);

        void GenerateQuestionSheet(Matrix matrix);
    }
    public class MatrixBusiness : BusinessBase<Matrix>, IMatrixBusiness
    {
        private readonly IMatrixRepository _repository;
        private readonly IShiftSubjectRepository _shiftSubjectRepository;
        private readonly IQuestionRepository _questionRepository;
        private readonly IQuestionSheetRepository _questionSheetRepository;
        private readonly IQuestionSheetDetailRepository _questionSheetDetailRepository;
        private readonly IChapterRepository _chapterRepository;

        public MatrixBusiness(IMatrixRepository repository, IShiftSubjectRepository shiftSubjectRepository,
            IUnitOfWork unitOfWork,
            IQuestionRepository questionRepository,
            IQuestionSheetRepository questionSheetRepository,
            IQuestionSheetDetailRepository questionSheetDetailRepository,
            IChapterRepository chapterRepository) : base(repository, unitOfWork)
        {
            _repository = repository;
            _shiftSubjectRepository = shiftSubjectRepository;
            _questionRepository = questionRepository;
            _questionSheetRepository = questionSheetRepository;
            _questionSheetDetailRepository = questionSheetDetailRepository;
            _chapterRepository = chapterRepository;
        }

        public void CleanDetails(int id)
        {
            _repository.DeleteDetails(id);
        }

        private void InsertGeneratedQuestionSheet(PSO pso, List<ShiftSubjectStudent> shiftSubjectStudents)
        {
            for (var i = 0; i < shiftSubjectStudents.Count; i++)
            {
                var questionSheetPSO = pso.Dans[i].GetCaTheTotNhat();

                var newQuestionSheet = new QuestionSheet
                {
                    Name = shiftSubjectStudents[i].Student.Code,
                    StudentId = shiftSubjectStudents[i].Student.Id,
                    ShiftId = shiftSubjectStudents[i].ShiftSubject.ShiftId,
                    ShiftSubjectId = shiftSubjectStudents[i].ShiftSubjectId,
                    CreateDate = DateTime.Now,
                    Approved = true,
                    ExtraTime = 5,
                    Total = Convert.ToInt16(questionSheetPSO.CauHois.Count)
                };
                _questionSheetRepository.Create(newQuestionSheet);
                shiftSubjectStudents[i].QuestionSheet = newQuestionSheet;

                for (short j = 0; j < questionSheetPSO.CauHois.Count; j++)
                {
                    var questionSheetDetail = new QuestionSheetDetail
                    {
                        QuestionSheet = newQuestionSheet,
                        QuestionId = questionSheetPSO.CauHois[j].MaCauHoi,
                        Order = (short)(j + 1),
                        CreateDate = DateTime.Now,
                        UpdateDate = DateTime.Now
                    };
                    _questionSheetDetailRepository.Create(questionSheetDetail);
                }
            }
        }

        private void GenerateQuestionSheet(ShiftSubject shiftSubject, MaTranDe maTranDe,
            Dictionary<long, Dictionary<long, CauHoi>> database)
        {
            var shiftSubjectStudents = shiftSubject.ShiftSubjectStudents.ToList();

            var requiredDifficulty = 0.5M;

            var pso = new PSO(maTranDe, database, shiftSubjectStudents.Count, requiredDifficulty);

            pso.Start();

            InsertGeneratedQuestionSheet(pso, shiftSubjectStudents);

            shiftSubject.Shift.QuestionSheetCreated = true;
        }

        public void GenerateQuestionSheet(Matrix matrix)
        {
            var subjects = matrix.ShiftSubjects.Where(ss => ss.Shift.Deleted == false &&
                                                            ss.Subject.Deleted == false).ToList();
            var maTranDe = new MaTranDe(matrix.MatrixDetails);
            var database = new Dictionary<long, Dictionary<long, CauHoi>>();
            var strEx = new StringBuilder();

            foreach (var phan in maTranDe.Phans)
            {
                var maPhan = phan.MaPhan;

                database[maPhan] = _questionRepository.GetMulti(q => q.ChapterId == maPhan && q.Deleted == false)
                    .ToDictionary(q => q.Id, q => new CauHoi(q.Id, q.ChapterId, q.ObjectiveDifficulty, q.ParentId, q.Interchange, q.ManagementOrder != null ? q.ManagementOrder.Value : 0));

                if(database[maPhan].Values.Count < phan.SoCauPhan)
                {
                    var chapter = _chapterRepository.GetSingleById(phan.MaPhan);
                    strEx.AppendFormat("Ma trận {0}: Phần {1} của môn {2} chỉ có {3}/{4} câu hỏi.", matrix.Name, phan.MaPhan,
                        chapter.Subject.Name, database[maPhan].Values.Count, phan.SoCauPhan);
                }
            }

            var countCauHoi = database.Sum(c => c.Value.Count);
            if (strEx.Length != 0)
            {
                throw new GenerateQuestionSheetException(strEx.ToString());
            }

            foreach (var shiftSubject in subjects)
            {
                GenerateQuestionSheet(shiftSubject, maTranDe, database);
            }
        }

        /// <summary>
        /// get Details of for shift and subject
        /// </summary>
        /// <param name="shiftId">Shift id</param>
        /// <param name="subjectId">Subject id</param>
        /// <returns></returns>
        public IEnumerable<MatrixDetail> GetDetails(int shiftsubjectId)
        {
            var shiftSubject = _shiftSubjectRepository.GetSingleById(shiftsubjectId);
            return _repository.GetDetails(shiftSubject.MatrixId ?? 0);
        }

        public IEnumerable<Matrix> GetMatricesByExamId(int examId)
        {
            var matrices = _repository.GetMulti(c => c.ExamId == examId, new string[] { "MatrixDetails", "ShiftSubjects" });
            return matrices;
        }

        public override void Update(Matrix entity)
        {
            throw new NotImplementedException();
        }
    }
}
