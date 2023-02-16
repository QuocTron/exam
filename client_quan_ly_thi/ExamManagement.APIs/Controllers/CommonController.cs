using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using ExamManagement.Businesses;
using ExamManagement.Entities;
using AutoMapper;
using ExamManagement.APIs.ViewModels;
using System.Linq;

namespace ExamManagement.APIs.Controllers
{
    [Authorize]
    [RoutePrefix("api/common")]
    public class CommonController : ApiController
    {
        private readonly IQuestionSheetBusiness _questionSheetBusiness;
        private readonly IStudentBusiness _studentBusiness;
        private readonly IShiftSubjectBusiness _shiftSubjectBusiness;
        private readonly IQuestionSheetDetailBusiness _questionSheetDetailBusiness;

        public CommonController
        (
            IQuestionSheetBusiness questionSheetBusiness,
            IStudentBusiness studentBusiness,
            IShiftSubjectBusiness shiftSubjectBusiness,
            IQuestionSheetDetailBusiness questionSheetDetailBusiness
        )
        {
            _questionSheetBusiness = questionSheetBusiness;
            _studentBusiness = studentBusiness;
            _shiftSubjectBusiness = shiftSubjectBusiness;
            _questionSheetDetailBusiness = questionSheetDetailBusiness;
        }

        /// <summary>
        /// Rview question sheet of result of a student
        /// </summary>
        /// <param name="questionSheetId">question sheet of id</param>
        [HttpGet]
        [Route("reviewQuestionSheet/{questionSheetId}")]
        public IHttpActionResult reviewResultQuestionSheet(long questionSheetId)
        {
            var questionSheet = _questionSheetBusiness.GetSingleById(questionSheetId);
            var student = _studentBusiness.GetSingleById(questionSheet.StudentId);
            var shiftSubject = _shiftSubjectBusiness.GetSingleById(questionSheet.ShiftSubjectId);
            var questionSheetDetails = _questionSheetDetailBusiness.GetQuestionSheetDetailListByQuestionSheetId(questionSheetId).Select(qsd => new { Correct = qsd.Correct, Order = qsd.Order, AnswerId = qsd.AnswerId, Deleted = qsd.Deleted }).ToArray();

            return Ok(new {
                id = questionSheet.Id,
                subjectName = shiftSubject.SubjectName,
                score = questionSheet.Mark,
                studentName = student.Name,
                studentCode = student.Code,
                startTime = shiftSubject.StartTime,
                duration = shiftSubject.Duration,
                questions = questionSheetDetails
            });
        }
    }
}