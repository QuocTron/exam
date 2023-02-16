using ExamManagement.Businesses.Infrastructures;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Data.Repositories;
using ExamManagement.Entities;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Diagnostics;

namespace ExamManagement.Businesses
{
    public interface IShiftSubjectBusiness : IBusinessBase<ShiftSubject>
    {
        /// <summary>
        /// Get subject list by shift id.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns>Subject list</returns>
        IEnumerable<ShiftSubject> GetShiftSubjectsByShiftId(int shiftId);

        /// <summary>
        /// Get subject list by exam id.
        /// </summary>
        /// <param name="examId">Exam id</param>
        /// <returns>Subject list</returns>
        IEnumerable<ShiftSubject> GetShiftSubjectsByExamId(long examId);

        /// <summary>
        /// Get shiftSubjectStudent list by Shift Subject id.
        /// </summary>
        /// <param name="shiftSubjectId">Shift Subject id</param>
        /// <returns>shiftSubjectStudent list</returns>
        IEnumerable<ShiftSubjectStudent> GetSSSBySubject(int shiftSubjectId);
        void PopulateData(int chapterId);
        int CalculateRemainTime(ShiftSubjectStudent shiftSubjectStudent);
        int CalculateRemainTime(long shiftsubjectid, long studentid);
        /// <summary>
        /// Terminate shiftsubject.
        /// </summary>
        /// <param name="shift">ShiftSubject to be terminated</param>
        void TerminateShiftSubject(ShiftSubject shiftSubject);

        /// <summary>
        /// Terminate shiftsubject.
        /// </summary>
        /// <param name="id">ShiftSubject id</param>
        void TerminateShiftSubject(long id);

        void TerminateShiftSubjects(long[] ids);

        void ActiveShiftSubject(ShiftSubject shiftSubject);

        void ActiveShiftSubject(long id);

        void ActiveShiftSubjects(long[] ids);

        void PauseShiftSubject(ShiftSubject shiftSubject);

        void PauseShiftSubject(long id);

        void PauseShiftSubjects(long[] ids);
    }

    public class ShiftSubjectBusiness : BusinessBase<ShiftSubject>, IShiftSubjectBusiness
    {
        private readonly IShiftSubjectRepository _shiftSubjectRepository;
        private readonly ISubjectRepository _subjectRepository;
        private IQuestionRepository _questionRepository;
        private IAnswerRepository _answerRepository;
        private readonly IStudentRepository _studentRepository;
        private IShiftSubjectStudentRepository _shiftSubjectStudentRepository;

        public ShiftSubjectBusiness(
            IShiftSubjectRepository shiftSubjectRepository,
            ISubjectRepository subjectRepository,
            IQuestionRepository questionRepository,
            IAnswerRepository answerRepository,
            IShiftSubjectStudentRepository shiftSubjectStudentRepository,
            IUnitOfWork unitOfWork,
            IStudentRepository studentRepository)
            : base(shiftSubjectRepository, unitOfWork)
        {
            _shiftSubjectRepository = shiftSubjectRepository;
            _subjectRepository = subjectRepository;
            _questionRepository = questionRepository;
            _answerRepository = answerRepository;
            _shiftSubjectStudentRepository = shiftSubjectStudentRepository;
            _studentRepository = studentRepository;
        }


        public IEnumerable<ShiftSubject> GetShiftSubjectsByShiftId(int shiftId)
        {
            var shiftsubjects = _shiftSubjectRepository.GetMulti(s => s.ShiftId == shiftId);
            return shiftsubjects;
        }

        public void PopulateData(int chapterId)
        {
            Random rnd = new Random();

            for (int i = 1; i <= 450; i++)
            {
                decimal difficulty = 0M;
                if (i <= 50) difficulty = 0.1M;
                else if (i <= 100) difficulty = 0.2M;
                else if (i <= 150) difficulty = 0.3M;
                else if (i <= 200) difficulty = 0.4M;
                else if (i <= 250) difficulty = 0.5M;
                else if (i <= 300) difficulty = 0.6M;
                else if (i <= 350) difficulty = 0.7M;
                else if (i <= 400) difficulty = 0.8M;
                else if (i <= 450) difficulty = 0.9M;

                var newQuestion = new Question
                {
                    ChapterId = chapterId,
                    Content = Guid.NewGuid().ToString(),
                    ObjectiveDifficulty = difficulty,
                    CreateDate = DateTime.Now
                };
                _questionRepository.Create(newQuestion);

                int answerIndex = rnd.Next(1, 5);
                for (int j = 1; j <= 4; j++)
                {
                    var newAnswer = new Answer
                    {
                        Question = newQuestion,
                        Order = j,
                        Content = Guid.NewGuid().ToString(),
                        Correct = answerIndex == j ? true : false,
                    };
                    _answerRepository.Create(newAnswer);
                }

                Debug.WriteLine($"Chapter: {chapterId} - Question: {i}");
            }
        }


        /// <summary>
        /// Get shiftSubjectStudent list by Shift Subject id.
        /// </summary>
        /// <param name="shiftSubjectId">Shift Subject id</param>
        /// <returns>shiftSubjectStudent list</returns>
        public IEnumerable<ShiftSubjectStudent> GetSSSBySubject(int shiftSubjectId)
        {
            var shiftSubjectStudents = _shiftSubjectStudentRepository.GetMulti(c => c.ShiftSubjectId == shiftSubjectId);

            return shiftSubjectStudents;
        }
        public override void Update(ShiftSubject entity)
        {
            throw new NotImplementedException();
        }

        public int CalculateRemainTime(ShiftSubjectStudent shiftSubjectStudent)
        {
            var ExtraTime = shiftSubjectStudent.QuestionSheet.ExtraTime;
            var shiftSubject = shiftSubjectStudent.ShiftSubject;
            var endTime = shiftSubject.EndTime.Value;
            var questtionSheet = shiftSubjectStudent.QuestionSheet;

            var remainTime = (int)(endTime - DateTime.Now).TotalSeconds + (questtionSheet.ExtraTime * 60);
            return (remainTime > 0) ? remainTime : 0;
        }

        public int CalculateRemainTime(long shiftsubjectid,long studentid)
        {
            var shiftSubjectStudent = _shiftSubjectStudentRepository.GetSingleByCondition(n => 
                                n.ShiftSubjectId == shiftsubjectid && n.StudentId == studentid);

            return CalculateRemainTime(shiftSubjectStudent);
        }

        /// <summary>
        /// Terminate shiftSubject.
        /// </summary>
        /// <param name="shiftSubject">shiftSubject to be terminated</param>
        public void TerminateShiftSubject(ShiftSubject shiftSubject)
        {
            if(shiftSubject.StateActivate != 1)
            {
                shiftSubject.Ended = true;
                shiftSubject.StateActivate = 4;
                shiftSubject.EndTime = DateTime.Now;
                //var shiftSubjectStudents = _shiftSubjectStudentRepository.GetMulti(sss => sss.ShiftSubjectId == shiftSubject.Id, new string[] { "QuestionSheet"});
                //foreach(var student in shiftSubjectStudents)
                //{
                //    if(student.StateExam != 3)
                //    {
                //        student.StateExam = 3;
                //        student.LogIn = false;
                //    }
                //}
            }
        }

        /// <summary>
        /// Terminate shiftSubject.
        /// </summary>
        /// <param name="id">shiftSubject id</param>
        public void TerminateShiftSubject(long id)
        {
            var shiftSubject = _shiftSubjectRepository.GetSingleById(id);
            TerminateShiftSubject(shiftSubject);
        }

        public void TerminateShiftSubjects(long[] ids)
        {
            foreach(var id in ids)
            {
                TerminateShiftSubject(id);
            }
        }

        public void ActiveShiftSubject(ShiftSubject shiftSubject)
        {
            if(shiftSubject.StateActivate == 1 || shiftSubject.StateActivate == 3)
            {
                if(shiftSubject.StateActivate == null ||  shiftSubject.StateActivate == 1)
                {
                    shiftSubject.ActivateTime = DateTime.Now;
                }
                shiftSubject.StateActivate = 2;
            }
        }

        public void ActiveShiftSubject(long id)
        {
            var shiftSubject = _shiftSubjectRepository.GetSingleById(id);
            ActiveShiftSubject(shiftSubject);
        }

        public void ActiveShiftSubjects(long[] ids)
        {
            foreach(var id in ids)
            {
                ActiveShiftSubject(id);
            }
        }

        public void PauseShiftSubject(ShiftSubject shiftSubject)
        {
            if(shiftSubject.StateActivate == 2)
            {
                shiftSubject.StateActivate = 3;
                var ShiftSubjectStudents = _shiftSubjectStudentRepository.GetMulti(sss => sss.ShiftSubjectId == shiftSubject.Id);
                foreach (var student in ShiftSubjectStudents)
                {
                    if(student.StateExam == 2)
                    {
                        student.LogIn = false;
                        student.StateExam = 1;
                    }
                }
            }
        }

        public void PauseShiftSubject(long id)
        {
            var shiftSubject = _shiftSubjectRepository.GetSingleById(id);
            PauseShiftSubject(shiftSubject);
        }

        public void PauseShiftSubjects(long[] ids)
        {
            foreach(var id in ids)
            {
                PauseShiftSubject(id);
            }
        }

        public IEnumerable<ShiftSubject> GetShiftSubjectsByExamId(long examId)
        {
            return _shiftSubjectRepository.GetMulti(ss => ss.Shift.ExamId == examId);
        }
    }
}
