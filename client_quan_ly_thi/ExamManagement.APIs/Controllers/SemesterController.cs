using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;
using ExamManagement.Businesses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using AutoMapper;
using ExamManagement.APIs.ViewModels;

namespace ExamManagement.APIs.Controllers
{
    [Authorize]
    [RoutePrefix("api/semester")]
    public class SemesterController : ApiController
    {
        private readonly ISemesterBusiness _semesterBusiness;

        public SemesterController(ISemesterBusiness semesterBusiness)
        {
            _semesterBusiness = semesterBusiness;
        }

        /// <summary>
        /// Get all semesters
        /// </summary>
        /// <returns>Semester List</returns>
        [HttpGet]
        [Route("getSemesters")]
        public IHttpActionResult GetAllSemesters()
        {
            try
            {
                var semesters = _semesterBusiness.GetAllSemesters();

                return Ok(Mapper.Map<IEnumerable<Semester>, IEnumerable<SemesterViewModel>>(semesters));
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        [HttpPost]
        [Route("createSemester")]
        public IHttpActionResult CreateSemester(SemesterViewModel semesterVM)
        {
            var semester = new Semester {
                Deleted = false,
                Comment = "",
                Name = semesterVM.Name
            };
            _semesterBusiness.Create(semester);
            _semesterBusiness.Save();
            return Ok(semesterVM);
        }

        [HttpPut]
        [Route("updateSemester")]
        public IHttpActionResult UpdateSemester(SemesterViewModel semesterVM)
        {
            var semester = _semesterBusiness.GetSingleById(semesterVM.Id);
            semester.Name = semesterVM.Name;
            _semesterBusiness.Save();
            return Ok();
        }

        [AcceptVerbs("DELETE")]
        [Route("deleteSemester/{id}")]
        public IHttpActionResult DeleteSemester(long id)
        {
            var semester = _semesterBusiness.GetSingleById(id);
            semester.Deleted = true;
            _semesterBusiness.Save();
            return Ok();
        }
    }
}