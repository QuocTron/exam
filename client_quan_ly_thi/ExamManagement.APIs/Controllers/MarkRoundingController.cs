using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Net;
using ExamManagement.Businesses;
using ExamManagement.Entities;
using System;

namespace ExamManagement.APIs.Controllers
{
    [Authorize]
    [RoutePrefix("api/markrounding")]
    public class MarkRoundingController : ApiController
    {
        private readonly IMarkRoundingBusiness _markRoundingBusiness;

        public MarkRoundingController(IMarkRoundingBusiness markRoundingBusiness)
        {
            _markRoundingBusiness = markRoundingBusiness;
        }

        [Route("getAll")]
        public IHttpActionResult GetAll()
        {
            List<MarkRounding> markRoundings = _markRoundingBusiness.GetAll().ToList();
            return Ok(markRoundings);
        }

        [HttpPut]
        [Route("selectMarkRounding/{id}")]
        public IHttpActionResult SelectMarkRounding(long id)
        {
            _markRoundingBusiness.SelectMarkRounding(id);
            _markRoundingBusiness.Save();
            return Ok();
        }
    }
}