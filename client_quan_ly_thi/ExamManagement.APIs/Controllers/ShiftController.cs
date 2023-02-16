using AutoMapper;
using ExamManagement.APIs.ViewModels;
using ExamManagement.Businesses;
using ExamManagement.Entities;
using ExamManagement.Services.Exceptions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace ExamManagement.APIs.Controllers
{
    [Authorize]
    [RoutePrefix("api/shift")]
    public class ShiftController : ApiController
    {
        private readonly IShiftBusiness _shiftBusiness;
        private readonly IQuestionSheetBusiness _questionSheetBusiness;
        private readonly IShiftSubjectBusiness _shiftSubjectBusiness;
        private readonly IStudentBusiness _studentBusiness;
        private readonly IShiftSubjectStudentBusiness _shiftSubjectStudentBusiness;
        private readonly IMatrixBusiness _matrixBusiness;

        public ShiftController(IShiftBusiness shiftBusiness, IQuestionSheetBusiness questionSheetBusiness,
            IShiftSubjectBusiness shiftSubjectBusiness, IStudentBusiness studentBusiness,
            IShiftSubjectStudentBusiness shiftSubjectStudentBusiness,
            IMatrixBusiness matrixBusiness)
        {
            _shiftBusiness = shiftBusiness;
            _questionSheetBusiness = questionSheetBusiness;
            _shiftSubjectBusiness = shiftSubjectBusiness;
            _studentBusiness = studentBusiness;
            _shiftSubjectStudentBusiness = shiftSubjectStudentBusiness;
            _matrixBusiness = matrixBusiness;
        }

        /// <summary>
        /// Get one instance of shift by id.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns>Shift</returns>
        [HttpGet]
        [Route("getShiftResult/{id:int}")]
        public IHttpActionResult GetShiftResult(int id)
        {
            var jsonResult = _shiftBusiness.ExportResult(id);
            return Ok(jsonResult);
        }
        /// <summary>
        /// Get one instance of shift by id.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns>Shift</returns>
        [HttpGet]
        [Route("getShift/{id:int}")]
        public IHttpActionResult GetShift(int id)
        {
            try
            {
                var shift = _shiftBusiness.GetSingleById(id);
                var shiftVm = Mapper.Map<Shift, ShiftViewModel>(shift);
                IEnumerable<ShiftSubject> shiftSubjects = _shiftSubjectBusiness.GetShiftSubjectsByShiftId(id).ToList();
                shiftVm.QuantitySubject = shift.ShiftSubjects.Count();
                shiftVm.QuantityActivedNotYet = shift.ShiftSubjects.Count(ss => ss.StateActivate == 1 || ss.StateActivate == null);
                shiftVm.QuantityActived = shift.ShiftSubjects.Count(ss => ss.StateActivate == 2);
                shiftVm.QuantityPaused = shift.ShiftSubjects.Count(ss => ss.StateActivate == 3);
                shiftVm.QuantityEnded = shift.ShiftSubjects.Count(ss => ss.StateActivate == 4);
                //shiftVm.Activated = shiftSubjects.Count() != 0 ? shiftSubjects.Where(ss => ss.StateActivate == 2).Count() == shiftSubjects.Count() : false;
                //shiftVm.Ended = shiftSubjects.Count() != 0 ? shiftSubjects.Count(ss => ss.StateActivate == 4) == shiftSubjects.Count() : false;

                //shiftVm.QuestionSheetCreated = shift.ShiftSubjects.Count(s => s.CreatedQuestionSheet) == shift.ShiftSubjects.Count();
                //shiftVm.Activated = shiftSubjects.Count(ss => ss.Activated) == shiftSubjects.Count();
                //shiftVm.Ended = shiftSubjects.Count(ss => ss.Ended != null && ss.Ended.Value == true) == shiftSubjects.Count();

                //var count = shift.ShiftSubjects.Count;
                //if (shift.ShiftSubjects.Count(n => n.Ended == true) == count)
                //{
                //    shiftVm.RemainTime = 0;
                //}
                //else if (shift.ShiftSubjects.Count(n => n.Activated == true) == count)
                //{
                //    shiftVm.RemainTime = _shiftBusiness.CalculateRemainTime(shift);

                //    if (shiftVm.RemainTime == 0)
                //    {
                //        _shiftBusiness.TerminateShift(shift);
                //        _shiftBusiness.Save();
                //    }
                //}

                return Ok(shiftVm);
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Get shift list by exam id. 
        /// </summary>
        /// <param name="id">Exam id</param>
        /// <returns>Shift list</returns>
        [HttpGet]
        [Route("getShiftListByExamId/{examId}")]
        public IHttpActionResult GetShiftListByExamId(int examId)
        {
            if (examId <= 0)
            {
                return BadRequest();
            }

            try
            {
                var shifts = _shiftBusiness.GetShiftsByExamId(examId).OrderByDescending(s => s.Name)
                    .ToList();

                return Ok(Mapper.Map<IEnumerable<Shift>, IEnumerable<ShiftViewModel>>(shifts));
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Create new shift.
        /// </summary>
        /// <param name="shiftVm">Shift view model containing new shift data</param>
        /// <returns>New shift</returns>
        [HttpPost]
        [Route("createShift")]
        public IHttpActionResult CreateShift(ShiftViewModel shiftVm)
        {
            try
            {
                var shift = Mapper.Map<ShiftViewModel, Shift>(shiftVm);
                _shiftBusiness.Create(shift);
                _shiftBusiness.Save();

                return Ok(shift);
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Generate question sheet.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns></returns>
        [HttpPost]
        [Route("generateQuestionSheet/{id}")]
        public IHttpActionResult GenerateShift(int id)
        {
            try
            {
                var shift = _shiftBusiness.GetSingleById(id);
                var matrices = _matrixBusiness.GetMatricesByExamId(shift.ExamId.Value).Select(m => m.Id).ToList();
                var shiftIds = new List<int> { id };

                if (matrices.Count == 0)
                {
                    throw new GenerateQuestionSheetException("Lỗi xảy ra: Không tìm thấy ma trận đề.");
                }

                foreach (var matrix in matrices)
                {
                    _questionSheetBusiness.GenerateQuestionSheetByMatrixId(matrix, shiftIds);
                }
                _questionSheetBusiness.Save();
                return Ok();
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Pause subjects in shift
        /// </summary>
        /// <param name="id">shift id</param>
        /// <returns></returns>
        [HttpPost]
        [Route("pauseShift/{id:int}")]
        public IHttpActionResult PauseShift(int id)
        {
            var shiftSubjects = _shiftSubjectBusiness.GetShiftSubjectsByShiftId(id);
            foreach (var shiftSubject in shiftSubjects)
            {
                _shiftSubjectBusiness.PauseShiftSubject(shiftSubject);
            }
            _shiftSubjectBusiness.Save();

            return Ok();
        }

        /// <summary>
        /// Activate shift.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns>Remain time</returns>
        [HttpPost]
        [Route("activateShift/{id}")]
        public IHttpActionResult ActivateShift(int id)
        {
            try
            {
                var shiftSubjects = _shiftSubjectBusiness.GetShiftSubjectsByShiftId(id);
                foreach (var shiftSubject in shiftSubjects)
                {
                    _shiftSubjectBusiness.ActiveShiftSubject(shiftSubject);
                }
                //var shift = _shiftBusiness.GetSingleById(id);
                //int remainTime = 0;
                //foreach(var shiftSubject in shift.ShiftSubjects)
                //{
                //    foreach (var shiftSubjectStudent in shiftSubject.ShiftSubjectStudents)
                //    {
                //        remainTime = _shiftSubjectBusiness.CalculateRemainTime(shiftSubject.Id, shiftSubjectStudent.StudentId);

                //        if (remainTime == 0)
                //        {
                //            _shiftSubjectBusiness.TerminateShiftSubject(id);
                //        }
                //    }
                //}

                _shiftSubjectBusiness.Save();

                return Ok();
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Terminate shift.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns></returns>
        [HttpPost]
        [Route("terminateShift/{id}")]
        public IHttpActionResult TerminateShift(int id)
        {
            try
            {
                var shiftSubjects = _shiftSubjectBusiness.GetShiftSubjectsByShiftId(id);
                foreach (var shiftSubject in shiftSubjects)
                {
                    _shiftSubjectBusiness.TerminateShiftSubject(shiftSubject);
                }

                _shiftSubjectBusiness.Save();

                return Ok();
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }
        /// <summary>
        /// Delete shift.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns></returns>
        [AcceptVerbs("DELETE")]
        [Route("deleteShift/{id}")]
        public IHttpActionResult DeleteShift(int id)
        {
            try
            {
                var result = _shiftBusiness.DeleteShift(id);

                if (result)
                {
                    _shiftBusiness.Save();
                    return Ok(new { result = "Ok" });
                }
                else
                {
                    return Ok(new { result = "Fail" });
                }

            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Add extra time
        /// </summary>
        /// <param name="StudentAddExtraTimeVM">StudentAddExtraTime view model containing new time data</param>
        /// <returns>ExtraTime</returns>
        [HttpPost]
        [Route("addExtraTime")]
        public IHttpActionResult AddExtraTime(StudentAddExtraTimeVM extraTimeVM)
        {
            try
            {
                foreach (var shiftSubjectId in extraTimeVM.ShiftSubjectIds)
                {
                    _questionSheetBusiness.AddExtraTimeByShiftSubjectId(shiftSubjectId,
                        extraTimeVM.Time, extraTimeVM.Reason);
                }
                _questionSheetBusiness.Save();

                return Ok(extraTimeVM.Time);
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
            if (searchViewModel.ShiftId != null)
            {
                List<StudentInfoViewModel> studentInfos = new List<StudentInfoViewModel>();
                var students = _shiftSubjectStudentBusiness.GetSSSListByCodeAndShiftId(searchViewModel.StudentCode, searchViewModel.ShiftId.Value);

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
                        ShiftSubjectId = student.ShiftSubjectId,
                        Code = student.Student.Code,
                        QuestionSheetId = student.QuestionSheetId,
                        LastName = student.Student.LastName,
                        FirstName = student.Student.FirstName,
                        ClassName = student.Student.ClassName,
                        StateExam = student.StateExam,
                        ExtraTime = student.QuestionSheetId != null ? student.QuestionSheet.ExtraTime : (short)0,
                        CreatedQuestionSheet = student.ShiftSubject.CreatedQuestionSheet,
                        SubjectName = student.ShiftSubject.SubjectName,
                        Score = student.QuestionSheetId != null ? student.QuestionSheet.Mark : null
                    }); ;
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
