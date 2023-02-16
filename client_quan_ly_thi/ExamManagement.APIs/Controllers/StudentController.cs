using AutoMapper;
using ExamManagement.APIs.ViewModels;
using ExamManagement.Businesses;
using ExamManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace ExamManagement.APIs.Controllers
{
    [Authorize]
    [RoutePrefix("api/student")]
    public class StudentController : ApiController
    {
        private IStudentBusiness _studentBusiness;
        private IQuestionSheetBusiness _questionSheetBusiness;
        private IShiftSubjectStudentBusiness _shiftSubjectStudentBusiness;
        private IShiftSubjectBusiness _shiftSubjectBusiness;
        private IShiftBusiness _shiftBusiness;
        private readonly IExtraTimeLogBusiness _extraTimeLogBusiness;
        public StudentController(IStudentBusiness studentBusiness, IQuestionSheetBusiness questionSheetBusiness,
            IExtraTimeLogBusiness extraTimeLogBusiness, IShiftSubjectStudentBusiness shiftSubjectStudentBusiness,
            IShiftSubjectBusiness shiftSubjectBusiness, IShiftBusiness shiftBusiness)
        {
            _studentBusiness = studentBusiness;
            _questionSheetBusiness = questionSheetBusiness;
            _extraTimeLogBusiness = extraTimeLogBusiness;
            _shiftSubjectStudentBusiness = shiftSubjectStudentBusiness;
            _shiftSubjectBusiness = shiftSubjectBusiness;
            _shiftBusiness = shiftBusiness;
        }


        /// <summary>
        /// Create new student for subject.
        /// </summary>
        /// <param name="shiftSubjectVM">ShiftSubject view model containing new ShiftSubject data</param>
        /// <returns>New ShiftSubject</returns>
        [HttpPost]
        [Route("createStudent")]
        public IHttpActionResult CreateShift(StudentViewModel studentVM)
        {
            try
            {
                Student student = _studentBusiness.getByCode(studentVM.Code);

                if(student == null)
                {
                    student = Mapper.Map<StudentViewModel, Student>(studentVM);
                    student.Name = student.LastName + " " + student.FirstName;
                    _studentBusiness.Create(student);
                    _studentBusiness.Save();
                }

                ShiftSubjectStudent shiftSubjectStudent = _studentBusiness.GetSSSByStudentSubject(student.Id, studentVM.ShiftSubjectId);
                
                if (shiftSubjectStudent == null)
                {
                    var shiftSubject = _shiftSubjectBusiness.GetSingleById(studentVM.ShiftSubjectId);
                    shiftSubject.Shift = _shiftBusiness.GetSingleById(shiftSubject.ShiftId.Value);
                    shiftSubject.CreatedQuestionSheet = false;
                    shiftSubject.Shift.QuestionSheetCreated = false;
                    shiftSubjectStudent = new ShiftSubjectStudent();
                    shiftSubjectStudent.ShiftSubjectId = studentVM.ShiftSubjectId;
                    shiftSubjectStudent.ShiftSubject = shiftSubject;
                    shiftSubjectStudent.StudentId = student.Id;
                    shiftSubjectStudent.LogIn = false;
                    shiftSubjectStudent.StateExam = 1;
                    shiftSubjectStudent.ShiftSubject.CreatedQuestionSheet = false;
                    shiftSubjectStudent.InsertTime = DateTime.Now;
                    _studentBusiness.CreateSSS(shiftSubjectStudent);
                    _studentBusiness.Save();

                    //Map student before return
                    var studentReturn = Mapper.Map<Student, StudentViewModel>(student);
                    studentReturn.StateExam = shiftSubjectStudent.StateExam;
                    studentReturn.BonusTime = 0;
                    studentReturn.QuestionSheetId = null;
                    return Ok(new { isAdded = true, student = studentReturn});
                }
                return Ok( new {isAdded = false });
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        [HttpGet]
        [Route("getStudentListByShiftSubject/{shiftId}/{shiftSubjectId}")]
        public IHttpActionResult GetStudentListByShiftSubject(int shiftId, int shiftSubjectId)
        {
            var students = _studentBusiness
                .GetStudentListByShiftSubject(shiftId, shiftSubjectId)
                .OrderBy(s => s.FirstName)
                .ToList();
            var studentsViewModel = Mapper.Map<IEnumerable<Student>, IEnumerable<StudentViewModel>>(students);

            for(int i = 0; i < studentsViewModel.Count(); i++)
            {
                var sss = students.ElementAt(i).ShiftSubjectStudents.Single();
                if (sss != null)
                {
                    studentsViewModel.ElementAt(i).StateExam = sss.StateExam;
                    if (students.ElementAt(i).ShiftSubjectStudents.Single().QuestionSheetId != null)
                    {
                        var qsId = (int)students.ElementAt(i).ShiftSubjectStudents.Single().QuestionSheetId.Value;
                        var questionsheet = _questionSheetBusiness.GetSingleById(qsId);
                        if (questionsheet != null)
                        {
                            studentsViewModel.ElementAt(i).QuestionSheetId = questionsheet.Id;
                            studentsViewModel.ElementAt(i).BonusTime = questionsheet.ExtraTime;
                            studentsViewModel.ElementAt(i).CreatedQuestionSheet = true;
                            studentsViewModel.ElementAt(i).Score = questionsheet.Mark;
                        }
                    } else
                    {
                        studentsViewModel.ElementAt(i).CreatedQuestionSheet = false;
                    }
                }
            }
            return Ok(studentsViewModel);
        }

        /// <summary>
        /// Get extra time
        /// </summary>
        /// <param name="StudentAddExtraTimeVM">StudentAddExtraTime view model containing new time data</param>
        /// <returns>ExtraTime</returns>
        [HttpPost]
        [Route("getExtraTime")]
        public IHttpActionResult GetExtraTime(GetExtraStudentForm extraTimeModel)
        {
            try
            {
                var questionSheet = _questionSheetBusiness.GetQuestionSheetByShiftStudent(extraTimeModel.ShiftId, extraTimeModel.StudentId);
                var extraTimeLogs = _extraTimeLogBusiness.GetExtraTimeLogsByQuestionSheetId(questionSheet.Id);
                return Ok(new { extraTime = questionSheet.ExtraTime, extraTimeLogs = Mapper.Map<IEnumerable<ExtraTimeLog>, IEnumerable<ExtraTimeLogViewModel>>(extraTimeLogs) });
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Reset login
        /// </summary>
        /// <param name="StudentResetVM">StudentResetVM view model containing student data</param>
        /// <returns>result</returns>
        [HttpPost]
        [Route("resetLogin")]
        public IHttpActionResult ResetLogin(StudentResetVM resetVM)
        {
            try
            {
                var shiftSubjectStudent = _studentBusiness.GetSSSByStudentSubject(resetVM.StudentId, resetVM.ShiftSubjectId);
                if(shiftSubjectStudent.StateExam != 3)
                {
                    shiftSubjectStudent.StateExam = 1;
                }

                shiftSubjectStudent.LogIn = false;
                _studentBusiness.Save();

                return Ok(true);
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        [HttpPost]
        [Route("addExtraTime")]
        public IHttpActionResult AddExtraTime(GetExtraStudentForm extraTimeModel)
        {
            var questionSheet = _questionSheetBusiness.GetQuestionSheetByShiftStudent(extraTimeModel.ShiftId, extraTimeModel.StudentId);
            if (questionSheet.Mark == null)
            {
                questionSheet.ExtraTime += (byte)extraTimeModel.ExtraTime;
                questionSheet.ExtraTimeLogs.Add(new ExtraTimeLog
                {
                    ExtraTime = (byte)extraTimeModel.ExtraTime,
                    Reason = extraTimeModel.Reason,
                    QuestionSheetId = questionSheet.Id
                });

                _questionSheetBusiness.Save();
                return Ok(new  { result = "Ok" });
            }

            return Ok(new { result = "Fail" });
        }

        [HttpPost]
        [Route("addExtraTimeStudents")]
        public IHttpActionResult addExtraTimeStudents(ExtraTimeStudentsViewModel extraTimeStudentsViewModel)
        {
            try
            {
                var shiftId = extraTimeStudentsViewModel.ShiftId;

                foreach(var studentid in extraTimeStudentsViewModel.StudentIds)
                {
                    var questionsheet = _questionSheetBusiness.GetQuestionSheetByShiftStudent(shiftId,studentid);
                    questionsheet.ExtraTime = (byte)(questionsheet.ExtraTime + extraTimeStudentsViewModel.ExtraTime);
                    questionsheet.ExtraTimeLogs.Add(new ExtraTimeLog {
                        Reason = extraTimeStudentsViewModel.Reason,
                        ExtraTime = extraTimeStudentsViewModel.ExtraTime,
                        QuestionSheetId = questionsheet.Id,
                        QuestionSheet = questionsheet
                    });
                }
                _questionSheetBusiness.Save();

                return Ok(extraTimeStudentsViewModel.ExtraTime);
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        [HttpPost]
        [Route("searchStudent")]
        public IHttpActionResult searchStudent(SearchStudentViewModel searchViewModel)
        {
            if (searchViewModel.ShiftSubjectId != null)
            {
                List<StudentInfoViewModel> studentInfos = new List<StudentInfoViewModel>();
                var students = _shiftSubjectStudentBusiness.GetSSSListByCodeAndSSId(searchViewModel.StudentCode, searchViewModel.ShiftSubjectId.Value);

                foreach (var student in students)
                {
                    student.Student = _studentBusiness.GetSingleById(student.StudentId);
                    if (student.QuestionSheetId != null)
                    {
                        student.QuestionSheet = _questionSheetBusiness.GetSingleById((int)student.QuestionSheetId.Value);
                    }
                    student.ShiftSubject = _shiftSubjectBusiness.GetSingleById((int)student.ShiftSubjectId);

                    studentInfos.Add(new StudentInfoViewModel
                    {
                        Id = student.StudentId,
                        ShiftId = student.ShiftSubject.ShiftId == null ? 0 : student.ShiftSubject.ShiftId.Value,
                        QuestionSheetId = student.QuestionSheetId,
                        Code = student.Student.Code,
                        LastName = student.Student.LastName,
                        FirstName = student.Student.FirstName,
                        ClassName = student.Student.ClassName,
                        StateExam = student.StateExam,
                        ExtraTime = student.QuestionSheetId != null ? student.QuestionSheet.ExtraTime : (short)0,
                        CreatedQuestionSheet = student.ShiftSubject.CreatedQuestionSheet,
                        SubjectName = student.ShiftSubject.SubjectName,
                        Score = student.QuestionSheetId != null ? student.QuestionSheet.Mark : null
                    });
                }

                return Ok(studentInfos);
            }
            else
            {
                return InternalServerError(new Exception("Không thể tìm sinh viên."));
            }
        }
    }
}
