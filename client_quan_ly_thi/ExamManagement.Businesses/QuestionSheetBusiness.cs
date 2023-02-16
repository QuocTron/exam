using System;
using ExamManagement.Businesses.Infrastructures;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Data.Repositories;
using ExamManagement.Entities;
using ExamManagement.Services.Exceptions;
using ExamManagement.Services.PSO;
using ExamManagement.Services;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.IO.MemoryMappedFiles;

namespace ExamManagement.Businesses
{
    public interface IQuestionSheetBusiness : IBusinessBase<QuestionSheet>
    {
        /// <summary>
        /// Generate question sheet for public user
        /// </summary>
        /// <param name="matrixId">Matrix id</param>
        /// <param name="difficulty">Required difficulty</param>
        /// <param name="numberOfSheets">Number of question sheet</param>
        /// <returns>Question sheet id</returns>
        QuestionSheet GenerateQuestionSheet(int matrixId, decimal difficulty = 0.5M, int numberOfSheets = 1);

        /// <summary>
        /// Get QuestionSheet by student id and shift id.
        /// </summary>
        /// <param name="shiftId">Shift id</param>
        /// <param name="shiftSubjectId">Shift Subject id</param>
        /// <returns>QuestionSheet</returns>
        QuestionSheet GetQuestionSheetByShiftStudent(int shiftId, int studentId);

        /// <summary>
        /// Get QuestionSheet by shift id.
        /// </summary>
        /// <param name="shiftId">Shift id</param>
        /// <returns>List QuestionSheet</returns>
        IEnumerable<QuestionSheet> GetQuestionSheetsByShift(int shiftId);

        /// <summary>
        /// Get QuestionSheet by shiftsubject id.
        /// </summary>
        /// <param name="shiftSubjectId">ShiftSubject id</param>
        /// <returns>List QuestionSheet</returns>
        IEnumerable<QuestionSheet> GetQuestionSheetsByShiftSubject(int shiftSubjectId);

        /// <summary>
        /// Generate question sheet by id of matrix and id of shifts
        /// </summary>
        /// <param name="matrixId">id of matrix</param>
        /// <param name="shiftIds">id of shifts</param>
        /// <returns></returns>
        IEnumerable<int> GenerateQuestionSheetByMatrixId(int matrixId, IEnumerable<int> shiftIds);

        /// <summary>
        /// Add extratime by id of shiftsubject.
        /// </summary>
        /// <param name="shiftSubjectId">id of shiftsubject</param>
        /// <param name="time">time</param>
        /// <param name="reason">reson</param>
        void AddExtraTimeByShiftSubjectId(int shiftSubjectId, byte time, string reason);

        /// <summary>
        /// Add extratime by question sheet
        /// </summary>
        /// <param name="questionSheet">Question sheet object</param>
        /// <param name="Time">time</param>
        /// <param name="readson">reason</param>
        void AddExtraTime(QuestionSheet questionSheet, byte Time, string Reason);
    }

    public class QuestionSheetBusiness : BusinessBase<QuestionSheet>, IQuestionSheetBusiness
    {
        private readonly IQuestionRepository _questionRepository;
        private readonly IQuestionSheetRepository _questionSheetRepository;
        private readonly IMatrixDetailRepository _matrixDetailRepository;
        private readonly IQuestionSheetDetailRepository _questionSheetDetailRepository;
        private readonly IChapterRepository _chapterRepository;
        private readonly IMatrixRepository _matrixRepository;
        private readonly IShiftSubjectRepository _shiftSubjectRepository;
        private readonly IStudentRepository _studentRepository;

        public QuestionSheetBusiness(
            IQuestionRepository questionRepository,
            IQuestionSheetRepository questionSheetRepository,
            IMatrixDetailRepository matrixDetailRepository,
            IQuestionSheetDetailRepository questionSheetDetailRepository,
            IChapterRepository chapterRepository,
            IMatrixRepository matrixRepository,
            IShiftSubjectRepository shiftSubjectRepository,
            IStudentRepository studentRepository,
            IUnitOfWork unitOfWork)
            : base(questionSheetRepository, unitOfWork)
        {
            _questionRepository = questionRepository;
            _questionSheetRepository = questionSheetRepository;
            _matrixDetailRepository = matrixDetailRepository;
            _questionSheetDetailRepository = questionSheetDetailRepository;
            _chapterRepository = chapterRepository;
            _matrixRepository = matrixRepository;
            _shiftSubjectRepository = shiftSubjectRepository;
            _studentRepository = studentRepository;
        }


        /// <summary>
        /// Get QuestionSheet by shift id.
        /// </summary>
        /// <param name="shiftId">Shift id</param>
        /// <returns>List QuestionSheet</returns>
        public IEnumerable<QuestionSheet> GetQuestionSheetsByShift(int shiftId)
        {
            return _questionSheetRepository.GetMulti(c => c.ShiftId == shiftId);
        }

        /// <summary>
        /// Get QuestionSheet by shift id.
        /// </summary>
        /// <param name="shiftId">Shift id</param>
        /// <returns>List QuestionSheet</returns>
        public IEnumerable<QuestionSheet> GetQuestionSheetsByShiftSubject(int shiftSubjectId)
        {
            return _questionSheetRepository.GetMulti(c => c.ShiftSubjectId == shiftSubjectId);
        }

        /// <summary>
        /// Get QuestionSheet by student id and shift id.
        /// </summary>
        /// <param name="shiftId">Shift id</param>
        /// <param name="studentId">Student id</param>
        /// <returns>QuestionSheet</returns>
        public QuestionSheet GetQuestionSheetByShiftStudent(int shiftId, int studentId)
        {
            return _questionSheetRepository.GetSingleByCondition(c => c.ShiftId == shiftId && c.StudentId == studentId);
        }

        /// <summary>
        /// Generate question sheet for public user
        /// </summary>
        /// <param name="matrixId">Matrix id</param>
        /// <param name="difficulty">Required difficulty</param>
        /// <returns>Question sheet id</returns>
        public QuestionSheet GenerateQuestionSheet(int matrixId, decimal difficulty, int numberOfSheets)
        {

            try
            {

                QuestionSheet newQuestionSheet = null;

                var matrixDetails = _matrixDetailRepository.GetMulti(m => m.MatrixId == matrixId);
                var maTranDe = new MaTranDe(matrixDetails);

                var database = new Dictionary<long, Dictionary<long, CauHoi>>();

                // Load database.
                foreach (var phan in maTranDe.Phans)
                {
                    var maPhan = phan.MaPhan;

                    database[maPhan] = _questionRepository.GetMulti(q => q.ChapterId == maPhan)
                        .ToDictionary(q => q.Id, q => new CauHoi(q.Id, q.ChapterId, q.ObjectiveDifficulty, q.ParentId, q.Interchange, q.ManagementOrder != null ? q.ManagementOrder.Value : 0));
                }

                if (database.Sum(c => c.Value.Count) == 0)
                {
                    throw new GenerateQuestionSheetException("Không lấy được dữ liệu câu hỏi theo ma trận đã nhập.");
                }

                var pso = new PSO(maTranDe, database, numberOfSheets, difficulty);

                pso.Start();

                for (var i = 0; i < numberOfSheets; i++)
                {
                    var questionSheetPSO = pso.Dans[i].GetCaTheTotNhat();

                    newQuestionSheet = new QuestionSheet
                    {
                        Name = DateTime.Now.ToString("yyyyMMMddHHmm"),
                        CreateDate = DateTime.Now,
                        Approved = true,
                        Total = Convert.ToInt16(questionSheetPSO.CauHois.Count)
                    };
                    _questionSheetRepository.Create(newQuestionSheet);

                    for (short j = 0; j < questionSheetPSO.CauHois.Count; j++)
                    {
                        var questionSheetDetail = new QuestionSheetDetail
                        {
                            QuestionSheet = newQuestionSheet,
                            QuestionId = questionSheetPSO.CauHois[j].MaCauHoi,
                            Order = j++,
                            CreateDate = DateTime.Now,
                            UpdateDate = DateTime.Now
                        };
                        _questionSheetDetailRepository.Create(questionSheetDetail);
                    }
                }

                return newQuestionSheet;
            }
            catch (Exception e)
            {
                throw new GenerateQuestionSheetException("Lỗi xảy ra khi tạo đề thi.", e);
            }
        }

        public override void Update(QuestionSheet entity)
        {
            throw new System.NotImplementedException();
        }

        private void InsertGeneratedQuestionSheet(PSO pso, List<ShiftSubjectStudent> shiftSubjectStudents)
        {
            var studentQuanlity = shiftSubjectStudents.Count;
            var i = 0;
            while (i < studentQuanlity)
            {
                var threadstart = new System.Threading.ParameterizedThreadStart(param =>
                {
                    var data = (ParameterThread)param;
                    ShiftSubjectStudent shiftSubjectStudent = data.shiftSubjectStudent;
                    CaThe caThe = data.CaThe;

                    if (caThe.DoThichNghi < 1) //<=== Thỏa mãn các ràng buộc cứng
                    {
                        var newQuestionSheet = new QuestionSheet
                        {
                            Name = shiftSubjectStudent.Student.Code,
                            StudentId = shiftSubjectStudent.Student.Id,
                            ShiftId = shiftSubjectStudent.ShiftSubject.ShiftId,
                            ShiftSubjectId = shiftSubjectStudent.ShiftSubjectId,
                            CreateDate = DateTime.Now,
                            Approved = true,
                            ExtraTime = 5,
                            Total = Convert.ToInt16(caThe.CauHois.Count),
                            Started = false
                        };

                        shiftSubjectStudent.QuestionSheet = newQuestionSheet;
                        for (short j = 0; j < caThe.CauHois.Count; j++)
                        {
                            CauHoi cauHoi = caThe.CauHois[j];
                            var questionSheetDetail = new QuestionSheetDetail
                            {
                                QuestionId = cauHoi.MaCauHoi,
                                Order = (byte)(j + 1),
                                CreateDate = DateTime.Now,
                                UpdateDate = DateTime.Now
                            };
                            shiftSubjectStudent.QuestionSheet.QuestionSheetDetails.Add(questionSheetDetail);
                        }

                        lock (_questionSheetRepository)
                        {
                            _questionSheetRepository.Create(newQuestionSheet);
                        }
                    }
                });

                var quanlity = Math.Min(4, studentQuanlity - i); // <== Lấy số lượng sinh viên tạo(tối đa 1 lúc tạo đề cho 4 sinh viên)
                var thread = new System.Threading.Thread[quanlity];

                for (var j = 0; j < quanlity; j++)
                {
                    thread[j] = new System.Threading.Thread(threadstart);
                    thread[j].Start(new ParameterThread
                    {
                        CaThe = pso.Dans[i + j].GetCaTheTotNhat(),
                        shiftSubjectStudent = shiftSubjectStudents[i + j]
                    });
                }

                for (var j = 0; j < quanlity; j++)
                {
                    thread[j].Join();
                }
                i += quanlity;
            }
        }

        private void GenerateQuestionSheet(ShiftSubject shiftSubject, MaTranDe maTranDe,
            Dictionary<long, Dictionary<long, CauHoi>> database)
        {
            var strEx = new StringBuilder("(GenerateQuestionSheet) ");
            var shiftSubjectStudents = shiftSubject.ShiftSubjectStudents.Where(sst => sst.QuestionSheetId == null)
                                        .ToList();
            if (shiftSubjectStudents.Count == 0)
            {
                strEx.AppendFormat("Lỗi xảy ra: Không tìm thấy thí sinh trong môn: {0}.", shiftSubject.SubjectName);
                throw new GenerateQuestionSheetException(strEx.ToString());
            }
            foreach (var shiftSubjectStudent in shiftSubjectStudents)
            {
                shiftSubjectStudent.Student = _studentRepository.GetSingleById(shiftSubjectStudent.StudentId);
            }

            var requiredDifficulty = 0.5M;

            var pso = new PSO(maTranDe, database, shiftSubjectStudents.Count, requiredDifficulty);

            pso.Start();

            InsertGeneratedQuestionSheet(pso, shiftSubjectStudents);

            shiftSubject.CreatedQuestionSheet = true;
        }

        /// <summary>
        /// Generate question sheet by id of matrix and id of shifts
        /// </summary>
        /// <param name="matrixId">id of matrix</param>
        /// <param name="shiftIds">id of shifts</param>
        /// <returns></returns>
        public IEnumerable<int> GenerateQuestionSheetByMatrixId(int matrixId, IEnumerable<int> shiftIds)
        {
            var shiftsCreated = new List<int>();
            var strEx = new StringBuilder("(QuestionSheetBusiness) ");
            var matrix = _matrixRepository.GetSingleById(matrixId);
            if (matrix == null)
            {
                strEx.Append("Lỗi xảy ra: Không tìm thấy ma trận đề.");
            }

            var subjects = _shiftSubjectRepository.GetMulti(ss =>
                            ss.ShiftId != null &&
                            ss.MatrixId == matrixId &&
                            ss.Shift.Deleted == false &&
                            ss.Subject.Deleted == false &&
                            ss.CreatedQuestionSheet == false &&
                            shiftIds.Contains(ss.ShiftId.Value),
                            new string[] { "Shift", "Subject", "ShiftSubjectStudents" }).ToList();
            if (subjects.Count == 0)
            {
                strEx.Append("Lỗi xảy ra: Không tìm thấy môn học cần tạo đề.");
            }

            if(matrix == null || subjects.Count == 0)
            {
                throw new GenerateQuestionSheetException(strEx.ToString());
            }

            var maTranDe = new MaTranDe(matrix.MatrixDetails);
            var database = new Dictionary<long, Dictionary<long, CauHoi>>();
            var countChecked = false;

            foreach (var phan in maTranDe.Phans)
            {
                var maPhan = phan.MaPhan;

                database[maPhan] = _questionRepository.GetMulti(q => q.ChapterId == maPhan && q.Deleted == false)
                    .ToDictionary(q => q.Id, q => new CauHoi(q.Id, q.ChapterId, q.ObjectiveDifficulty, q.ParentId, q.Interchange, q.ManagementOrder != null ? q.ManagementOrder.Value : 0));

                if (database[maPhan].Values.Count < phan.SoCauPhan)
                {
                    var chapter = _chapterRepository.GetSingleById(maPhan);
                    if (chapter != null)
                    {
                        strEx.AppendFormat("Ma trận: {0}.<br/> Mã phần NH: {1}.<br/> Mã môn NH: {2}.<br/> Lỗi xảy ra: Không đủ số lượng câu hỏi trong NH. <br/>[Ma trận:{3}] / [NH:{4}]. ", matrix.Name, phan.MaPhan,
                        chapter.SubjectId, phan.SoCauPhan, database[maPhan].Values.Count);
                    }
                    else
                    {
                        strEx.AppendFormat("Không xác định được Mã phần NH: {0}. ", maPhan);
                    }
                    countChecked = true;
                }
            }

            if (matrix == null || subjects.Count == 0 || countChecked)
            {
                throw new GenerateQuestionSheetException(strEx.ToString());
            }

            foreach (var shiftSubject in subjects)
            {
                GenerateQuestionSheet(shiftSubject, maTranDe, database);
                shiftSubject.Shift.QuestionSheetCreated = shiftSubject.Shift.ShiftSubjects.Count(s => s.Shift.Deleted == false && s.CreatedQuestionSheet) == shiftSubject.Shift.ShiftSubjects.Count(s => s.Shift.Deleted == false);
                if (shiftSubject.Shift.QuestionSheetCreated)
                {
                    shiftsCreated.Add(shiftSubject.ShiftId.Value);
                }
            }
            return shiftsCreated;
        }

        /// <summary>
        /// Add extratime by id of shiftsubject.
        /// </summary>
        /// <param name="shiftSubjectId">id of shiftsubject</param>
        /// <param name="time">time</param>
        /// <param name="reason">reson</param>
        public void AddExtraTimeByShiftSubjectId(int shiftSubjectId, byte time, string reason)
        {
            var questionSheets = _questionSheetRepository.GetMulti(questionSheet => questionSheet.ShiftSubjectId == shiftSubjectId).ToList();
            if (questionSheets.Count != 0)
            {
                foreach (var qs in questionSheets)
                {
                    AddExtraTime(qs, time, reason);
                }
            }
        }

        /// <summary>
        /// Add extratime by question sheet
        /// </summary>
        /// <param name="questionSheet">Question sheet object</param>
        /// <param name="Time">time</param>
        /// <param name="readson">reason</param>
        public void AddExtraTime(QuestionSheet questionSheet, byte Time, string Reason)
        {
            questionSheet.ExtraTime += Time;
            questionSheet.ExtraTimeLogs.Add(new ExtraTimeLog
            {
                ExtraTime = Time,
                Reason = Reason
            });
        }
    }
}
