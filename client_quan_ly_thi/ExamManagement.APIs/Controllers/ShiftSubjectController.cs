using AutoMapper;
using ExamManagement.APIs.ViewModels;
using ExamManagement.Businesses;
using ExamManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Globalization;
using System.Web.Http;

namespace ExamManagement.APIs.Controllers
{
    [Authorize]
    [RoutePrefix("api/subject")]
    public class ShiftSubjectController : ApiController
    {
        private readonly IShiftSubjectBusiness _shiftSubjectBusiness;
        private readonly ISubjectBusiness _subjectBusiness;
        private readonly IQuestionSheetBusiness _questionSheetBusiness;
        private readonly IStudentBusiness _studentBusiness;
        private readonly IShiftSubjectStudentBusiness _shiftSubjectStudentBusiness;
        private readonly IShiftBusiness _shiftBusiness;

        public ShiftSubjectController(IShiftSubjectBusiness shiftSubjectBusiness, ISubjectBusiness subjectBusiness,
            IQuestionSheetBusiness questionSheetBusiness, IStudentBusiness studentBusiness,
            IShiftBusiness shiftBusiness, IShiftSubjectStudentBusiness shiftSubjectStudentBusiness)
        {
            _shiftSubjectBusiness = shiftSubjectBusiness;
            _subjectBusiness = subjectBusiness;
            _questionSheetBusiness = questionSheetBusiness;
            _studentBusiness = studentBusiness;
            _shiftSubjectStudentBusiness = shiftSubjectStudentBusiness;
            _shiftBusiness = shiftBusiness;
        }

        /// <summary>
        /// Create new subject.
        /// </summary>
        /// <param name="shiftSubjectVM">ShiftSubject view model containing new ShiftSubject data</param>
        /// <returns>New ShiftSubject</returns>
        [HttpPost]
        [Route("createSubject")]
        public IHttpActionResult CreateShift(ShiftSubjectViewModel shiftSubjectVM)
        {

            try
            {
                string[] formats = new string[] { "MM/dd/yyyy HH:mm", "MM/d/yyyy HH:mm", "M/dd/yyyy HH:mm", "M/d/yyyy HH:mm", "dd/MM/yyyy HH:mm", "d/M/yyyy HH:mm", "dd/M/yyyy HH:mm", "d/MM/yyyy HH:mm" };
                string[] times = shiftSubjectVM.ShiftSubjectTime.Split(':');
                if (times[0].Length == 1) times[0] = '0' + times[0];
                if (times[1].Length == 1) times[1] = '0' + times[1];
                shiftSubjectVM.ShiftSubjectTime = times[0] + ":" + times[1];
                var shiftSubject = Mapper.Map<ShiftSubjectViewModel, ShiftSubject>(shiftSubjectVM);
                var shift = _shiftBusiness.GetSingleById(shiftSubjectVM.ShiftId.Value);
                string[] strings = shift.Name.Split('-');
                shiftSubject.StartTime = DateTime.ParseExact(strings[0] + shiftSubjectVM.ShiftSubjectTime,
                                            formats, CultureInfo.InvariantCulture, DateTimeStyles.None);
                shiftSubjectVM.StartTime = shiftSubject.StartTime;
                shiftSubject.StateActivate = 1;
                shiftSubject.Ended = false;
                _shiftSubjectBusiness.Create(shiftSubject);
                _shiftSubjectBusiness.Save();
                shiftSubjectVM.Id = shiftSubject.Id;

                return Ok(shiftSubjectVM);
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Get all instance of subjects.
        /// </summary>
        /// <returns>Subjects</returns>
        [HttpGet]
        [Route("getAllSubjects")]
        public IHttpActionResult GetAllSubjects()
        {
            try
            {
                var subjects = _subjectBusiness.GetAllSubject();

                return Ok(Mapper.Map<IEnumerable<Subject>, IEnumerable<SubjectViewModel>>(subjects));
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Get one instance of subject by id.
        /// </summary>
        /// <param name="id">Subject id</param>
        /// <returns>Subject</returns>
        [HttpGet]
        [Route("getSubject/{id}")]
        public IHttpActionResult GetSubject(int id)
        {
            try
            {
                var subject = _subjectBusiness.GetSingleById(id);

                return Ok(Mapper.Map<Subject, SubjectViewModel>(subject));
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Get subject list by shift id.
        /// </summary>
        /// <param name="id">Shift id</param>
        /// <returns>Subject list</returns>
        [HttpGet]
        [Route("getSubjectListByShiftId/{shiftId}")]
        public IHttpActionResult GetSubjectListByShiftId(int shiftId)
        {
            if (shiftId <= 0)
            {
                return BadRequest();
            }

            try
            {
                var subjects = _shiftSubjectBusiness.GetShiftSubjectsByShiftId(shiftId)
                    //.OrderBy(s => s.SubjectCode)
                    .ToList();

                return Ok(Mapper.Map<IEnumerable<ShiftSubject>, IEnumerable<ShiftSubjectViewModel>>(subjects));
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Add extra time
        /// </summary>
        /// <param name="StudentAddExtraTimeVM">StudentAddExtraTimeVM view model containing new time data</param>
        /// <returns>ExtraTime</returns>
        [HttpPost]
        [Route("addExtraTime")]
        public IHttpActionResult AddExtraTime(StudentAddExtraTimeVM extraTimeVM)
        {
            try
            {
                foreach(var ssId in extraTimeVM.ShiftSubjectIds)
                {
                    var questionSheets = _questionSheetBusiness.GetQuestionSheetsByShiftSubject(ssId);
                    foreach (var qs in questionSheets)
                    {
                        qs.ExtraTime = (byte)(qs.ExtraTime + extraTimeVM.Time);
                        qs.ExtraTimeLogs.Add(new ExtraTimeLog
                        {
                            ExtraTime = extraTimeVM.Time,
                            Reason = extraTimeVM.Reason
                        });
                    }
                }
                _questionSheetBusiness.Save();

                return Ok(extraTimeVM.Time);
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
                var shiftSubjectStudents = _shiftSubjectBusiness.GetSSSBySubject(resetVM.ShiftSubjectId);
                foreach(var s in shiftSubjectStudents)
                {
                    s.LogIn = false;
                }
                _shiftSubjectBusiness.Save();

                return Ok(true);
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        [HttpGet]
        [Route("populateMockData/{chapterId}")]
        public IHttpActionResult PopulateMockData(int chapterId)
        {
            _shiftSubjectBusiness.PopulateData(chapterId);
            _shiftSubjectBusiness.Save();

            return Ok();
        }

        /// <summary>
        /// Add extra time for questionsheets
        /// </summary>
        /// <param name="extraTimeVMs">List StudentResetVM view model containing student data</param>
        /// <returns></returns>
        [HttpPost]
        [Route("addExtraTimes")]
        public IHttpActionResult addExtraTimes(ExtraTimeSubjectsViewModel extraTimeVMs)
        {
            try
            {
                foreach (var subject in extraTimeVMs.ShiftSubjectIds)
                {
                    var questionSheets = _questionSheetBusiness.GetQuestionSheetsByShiftSubject(subject);
                    foreach (var qs in questionSheets)
                    {
                        qs.ExtraTime = (byte)(qs.ExtraTime + extraTimeVMs.ExtraTime);
                        qs.ExtraTimeReason = extraTimeVMs.Reason;
                    }
                }
                _questionSheetBusiness.Save();
                return Ok(extraTimeVMs.ExtraTime);
            } catch(Exception e)
            {
                return InternalServerError(e);
            }
        }

        [HttpPost]
        [Route("activeSubject")]
        public IHttpActionResult ActiveSubject(EditStateViewModel subjects)
        {
            _shiftSubjectBusiness.ActiveShiftSubjects(subjects.shiftSubjectIds);
            _shiftSubjectBusiness.Save();
            return Ok();
        }

        [HttpPost]
        [Route("pauseSubject")]
        public IHttpActionResult PauseSubject(EditStateViewModel subjects)
        {
            _shiftSubjectBusiness.PauseShiftSubjects(subjects.shiftSubjectIds);
            _shiftSubjectBusiness.Save();
            _shiftSubjectStudentBusiness.Save();
            return Ok();
        }

        [HttpPost]
        [Route("terminateSubject")]
        public IHttpActionResult TerminateSubject(EditStateViewModel subjects)
        {
            _shiftSubjectBusiness.TerminateShiftSubjects(subjects.shiftSubjectIds);
            _shiftSubjectBusiness.Save();
            return Ok();
        }
    }
}
