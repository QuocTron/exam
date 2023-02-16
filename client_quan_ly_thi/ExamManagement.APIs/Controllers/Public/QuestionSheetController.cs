using ExamManagement.Businesses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

namespace ExamManagement.APIs.Controllers.Public
{
    [EnableCors("*", "*", "*")]
    [RoutePrefix("api/public/questionSheet")]
    public class QuestionSheetController : ApiController
    {
        private readonly IQuestionSheetBusiness _questionSheetBusiness;
        public QuestionSheetController(IQuestionSheetBusiness questionSheetBusiness)
        {
            _questionSheetBusiness = questionSheetBusiness;
        }

        [HttpGet]
        [Route("generateQuestionSheet/{difficulty}/{matrixId}")]
        public IHttpActionResult GenerateQuestionSheet(decimal difficulty, int matrixId)
        {
            try
            {
                var questionSheet = _questionSheetBusiness.GenerateQuestionSheet(matrixId, difficulty);
                _questionSheetBusiness.Save();

                if (questionSheet == null)
                {
                    return InternalServerError();
                }

                return Ok(questionSheet.Id);
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }
    }
}
