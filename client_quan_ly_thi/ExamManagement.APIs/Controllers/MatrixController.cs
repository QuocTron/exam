using AutoMapper;
using ExamManagement.APIs.ViewModels;
using ExamManagement.Businesses;
using ExamManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace ExamManagement.APIs.Controllers
{
    [Authorize]
    [RoutePrefix("api/matrix")]
    public class MatrixController : ApiController
    {
        private readonly IMatrixBusiness _matrixBusiness;

        public MatrixController(IMatrixBusiness matrixBusiness)
        {
            _matrixBusiness = matrixBusiness;
        }

        /// <summary>
        /// Get Matrix Details
        /// </summary>
        /// <returns>Matrix Details List</returns>
        [HttpGet]
        [Route("getDetails/{shiftsubjectId}")]
        public IHttpActionResult GetDetails(int shiftsubjectId)
        {
            try
            {
                var details = _matrixBusiness.GetDetails(shiftsubjectId);

                return Ok(Mapper.Map<IEnumerable<MatrixDetail>, IEnumerable<MatrixDetailViewModel>>(details));
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Get Matrix By ExamId
        /// </summary>
        /// <returns>Matrix List</returns>
        [HttpGet]
        [Route("getMatrices/{examId}")]
        public IHttpActionResult GetMatrices(int examId)
        {
            try
            {
                var matrices = _matrixBusiness.GetMatricesByExamId(examId);

                return Ok(Mapper.Map<IEnumerable<Matrix>, IEnumerable<MatrixViewModel>>(matrices));
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }
    }
}