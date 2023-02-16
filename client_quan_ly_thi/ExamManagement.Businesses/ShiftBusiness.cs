using ExamManagement.Businesses.Infrastructures;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Data.Repositories;
using ExamManagement.Entities;
using ExamManagement.Services.Exceptions;
using ExamManagement.Services.PSO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ExamManagement.Businesses
{
    public interface IShiftBusiness : IBusinessBase<Shift>
    {
        /// <summary>
        /// Get shift list by exam id.
        /// </summary>
        /// <param name="id">Exam id</param>
        /// <returns>Shift list</returns>
        IEnumerable<Shift> GetShiftsByExamId(int id);

        /// <summary>
        /// Get shift include exam.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns>Shift</returns>
        Shift GetSingleIncludeExam(int id);

        /// <summary>
        /// Generate question sheet for shift.
        /// </summary>
        /// <param name="id">Shift id</param>
        void GenerateQuestionSheet(int id);

        /// <summary>
        /// Get remain time of shift when activated.
        /// </summary>
        /// <param name="shift">Shift to be calculate</param>
        /// <returns>Remain time</returns>
        //int CalculateRemainTime(Shift shift);

        /// <summary>
        /// Get remain time of shift when activated.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns>Remain time</returns>
        //int CalculateRemainTime(int id);

        /// <summary>
        /// Terminate shift.
        /// </summary>
        /// <param name="shift">Shift to be terminated</param>
        //void TerminateShift(Shift shift);

        /// <summary>
        /// Terminate shift.
        /// </summary>
        /// <param name="id">Shift id</param>
        //void TerminateShift(int id);

        /// <summary>
        /// Activate shift.
        /// </summary>
        /// <param name="id">Shift id</param>
        void ActivateShift(int id);

        /// <summary>
        /// Delete shift.
        /// </summary>
        /// <param name="id">Shift id</param>
        bool DeleteShift(int id);

        /// <summary>
        /// Export shift result.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns type="string">Result</returns>
        string ExportResult(int shiftId);
    }

    public class ShiftBusiness : BusinessBase<Shift>, IShiftBusiness
    {
        private readonly IShiftRepository _shiftRepository;
        private readonly ISubjectRepository _subjectRepository;
        private readonly IShiftSubjectRepository _shiftSubjectRepository;
        private readonly IMatrixDetailRepository _matrixDetailRepository;
        private readonly IQuestionRepository _questionRepository;
        private readonly IShiftSubjectStudentRepository _shiftSubjectStudentRepository;
        private readonly IQuestionSheetRepository _questionSheetRepository;
        private readonly IQuestionSheetDetailRepository _questionSheetDetailRepository;

        public ShiftBusiness(
            IShiftRepository shiftRepository,
            ISubjectRepository subjectRepository,
            IShiftSubjectRepository shiftSubjectRepository,
            IMatrixDetailRepository matrixDetailRepository,
            IQuestionRepository questionRepository,
            IShiftSubjectStudentRepository shiftSubjectStudentRepository,
            IQuestionSheetRepository questionSheetRepository,
            IQuestionSheetDetailRepository questionSheetDetailRepository,
            IUnitOfWork unitOfWork)
            : base(shiftRepository, unitOfWork)
        {
            _shiftRepository = shiftRepository;
            _subjectRepository = subjectRepository;
            _shiftSubjectRepository = shiftSubjectRepository;
            _matrixDetailRepository = matrixDetailRepository;
            _questionRepository = questionRepository;
            _shiftSubjectStudentRepository = shiftSubjectStudentRepository;
            _questionSheetRepository = questionSheetRepository;
            _questionSheetDetailRepository = questionSheetDetailRepository;
        }

        /// <summary>
        /// Get shift include exam.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns>Shift</returns>
        public Shift GetSingleIncludeExam(int id)
        {
            return _shiftRepository
                .GetMulti(s => s.Id == id && s.Deleted == false, new string[] { "Exam" })
                .FirstOrDefault();
        }

        /// <summary>
        /// Get exam list which deleted is false.
        /// </summary>
        /// <returns>Exam list</returns>
        public override IEnumerable<Shift> GetAll()
        {
            return _shiftRepository.GetMulti(s => s.Deleted == false);
        }

        /// <summary>
        /// Get shift list by exam id.
        /// </summary>
        /// <param name="id">Exam id</param>
        /// <returns>Shift list</returns>
        public IEnumerable<Shift> GetShiftsByExamId(int id)
        {
            var shifts = _shiftRepository.GetMulti(s => s.ExamId == id && s.Deleted == false);
            return shifts;
        }

        /// <summary>
        /// Generate question sheet for shift.
        /// </summary>
        /// <param name="id">Shift id</param>
        public void GenerateQuestionSheet(int id)
        {
            var shift = _shiftRepository.GetSingleById(id);
            var shiftSubjects = _shiftSubjectRepository.GetMulti(s => s.ShiftId == id && s.Subject.Deleted == false
                                && s.CreatedQuestionSheet == false).ToList();
            StringBuilder strEx = new StringBuilder();
            try
            {
                foreach (var shiftSubject in shiftSubjects)
                {
                    var matrixDetails = _matrixDetailRepository.GetMulti(m => m.MatrixId == shiftSubject.MatrixId);
                    var maTranDe = new MaTranDe(matrixDetails);

                    var database = new Dictionary<long, Dictionary<long, CauHoi>>();
                    // Load database.
                    foreach (var phan in maTranDe.Phans)
                    {
                        var maPhan = phan.MaPhan;

                        database[maPhan] = _questionRepository.GetMulti(q => q.ChapterId == maPhan && q.Deleted == false)
                            .ToDictionary(q => q.Id, q => new CauHoi(q.Id, q.ChapterId, q.ObjectiveDifficulty, q.ParentId, q.Interchange, q.ManagementOrder != null ? q.ManagementOrder.Value : 0));

                        if(database[maPhan].Count == 0)
                        {
                            strEx.Append("Chưa có phần " + maPhan + " của ca nhóm " + shiftSubject.GroupCode + " tổ " 
                                + shiftSubject.SubGroupCode + " trong ca thi " + shift.Name + ". ");
                        }
                    }

                    //var countCauHoi = database.Sum(c => c.Value.Count);
                    if (strEx.Length == 0)
                    {
                        // Get list of ShiftSubjectStudent include Student object.
                        var shiftSubjectStudents = _shiftSubjectStudentRepository
                            .GetMulti(s => s.ShiftSubjectId == shiftSubject.Id, new string[] { "Student", "ShiftSubject" })
                            .ToList();

                        var requiredDifficulty = 0.5M;

                        var pso = new PSO(maTranDe, database, shiftSubjectStudents.Count, requiredDifficulty);

                        pso.Start();

                        InsertGeneratedQuestionSheet(pso, shiftSubjectStudents);
                        shiftSubject.CreatedQuestionSheet = true;
                    }
                    
                }

                if(strEx.Length != 0)
                {
                    throw new Exception(strEx.ToString().Trim());
                } else
                {
                    shift.QuestionSheetCreated = true;
                }
            }
            catch (Exception e)
            {
                throw new GenerateQuestionSheetException("Không thể tạo đề thi.", e);
            }
        }

        /// <summary>
        /// Insert generated question sheet by PSO into database.
        /// </summary>
        /// <param name="pso">PSO object that contain generated question sheet</param>
        /// <param name="shiftSubjectStudents">ShiftSubjectStudent list to be bound</param>
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

        public override void Update(Shift entity)
        {
            throw new System.NotImplementedException();
        }

        /// <summary>
        /// Get remain time of shift when activated.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns>Remain time</returns>
        //public int CalculateRemainTime(int id)
        //{
        //    var shift = _shiftRepository.GetSingleById(id);

        //    return CalculateRemainTime(shift);
        //}

        /// <summary>
        /// Get remain time of shift when activated.
        /// </summary>
        /// <param name="shift">Shift to be calculate</param>
        /// <returns>Remain time</returns>
        //public int CalculateRemainTime(Shift shift)
        //{
        //    var maxExtraTime = _shiftRepository.GetMaxExtraTime(shift.Id);
        //    var remainTime = (int)(shift.EndTime - DateTime.Now).TotalSeconds + (maxExtraTime * 60);

        //    return (remainTime > 0) ? remainTime : 0;
        //}

        /// <summary>
        /// Terminate shift.
        /// </summary>
        /// <param name="id">Shift to be terminated</param>
        //public void TerminateShift(Shift shift)
        //{
        //    foreach(var shiftSubject in shift.ShiftSubjects)
        //    {
        //        shiftSubject.Ended = true;
        //    }
        //}

        /// <summary>
        /// Terminate shift.
        /// </summary>
        /// <param name="id">Shift id</param>
        //public void TerminateShift(int id)
        //{
        //    var shift = _shiftRepository.GetSingleById(id);
        //    TerminateShift(shift);
        //}

        /// <summary>
        /// Activate shift.
        /// </summary>
        /// <param name="id">Shift id</param>
        public void ActivateShift(int id)
        {
            var shiftSubjects = _shiftSubjectRepository.GetMulti(ss => ss.ShiftId == id);
            foreach(var shiftSubject in shiftSubjects)
            {
                shiftSubject.StateActivate = 2;
                shiftSubject.ActivateTime = DateTime.Now;
                shiftSubject.EndTime = DateTime.Now.AddMinutes((double)shiftSubject.Duration + 5);//Bonus 5 minute
            }
        }

        /// <summary>
        /// Delete shift.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns type="bool">Deleted of result</returns>
        public bool DeleteShift(int id)
        {
            var canDelete = true;
            var shiftSubjects = _shiftSubjectRepository.GetMulti(sss => sss.ShiftId == id);
            foreach(var shiftSubject in shiftSubjects)
            {
                if(shiftSubject.StateActivate == 2 || shiftSubject.StateActivate == 3)
                {
                    canDelete = false;
                    break;
                }
            }

            if(canDelete)
            {
                var shift = _shiftRepository.GetSingleById(id);
                shift.Deleted = true;
            }

            return canDelete;
        }

        /// <summary>
        /// Export shift result.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns type="string">Result</returns>
        public string ExportResult(int shiftId)
        {
            return _shiftRepository.GetResultById(shiftId);
        }
    }
}
