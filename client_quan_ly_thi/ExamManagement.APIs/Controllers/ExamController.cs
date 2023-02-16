using AutoMapper;
using ExamManagement.APIs.ViewModels;
using ExamManagement.Businesses;
using ExamManagement.Entities;
using ExamManagement.Services.Exceptions;
using ExamManagement.Services.MultipartFormData;
using ExamManagement.Services.PSO;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using System.Web.Http.Cors;
//using System.Web.Script.Serialization;

namespace ExamManagement.APIs.Controllers
{
    [Authorize]
    [EnableCors("*", "*", "*")]
    [RoutePrefix("api/exam")]
    public class ExamController : ApiController
    {
        private IExamBusiness _examBusiness;
        private readonly IShiftBusiness _shiftBusiness;
        private readonly IMatrixBusiness _matrixBusiness;
        /*private readonly IQuestionBusiness _questionBesiness;*/
        private readonly IShiftSubjectStudentBusiness _shiftSubjectStudentBusiness;
        private readonly IQuestionSheetBusiness _questionSheetBusiness;
        private readonly IStudentBusiness _studentBusiness;
        private readonly IShiftSubjectBusiness _shiftSubjectBusiness;

        public ExamController(IExamBusiness examBusiness, IShiftBusiness shiftBusiness, IMatrixBusiness matrixBusiness,
            IQuestionBusiness questionBesiness, IShiftSubjectStudentBusiness shiftSubjectStudentBusiness,
            IStudentBusiness studentBusiness, IShiftSubjectBusiness shiftSubjectBusiness,
            IQuestionSheetBusiness questionSheetBusiness)
        {
            _examBusiness = examBusiness;
            _shiftBusiness = shiftBusiness;
            _matrixBusiness = matrixBusiness;
            //_questionBesiness = questionBesiness;
            _shiftSubjectStudentBusiness = shiftSubjectStudentBusiness;
            _questionSheetBusiness = questionSheetBusiness;
            _studentBusiness = studentBusiness;
            _shiftSubjectBusiness = shiftSubjectBusiness;
        }

        /// <summary>
        /// Get one instance of exam by id.
        /// </summary>
        /// <param name="id">Exam id</param>
        /// <returns>Exam</returns>
        [HttpGet]
        [Route("getExam/{id:int}")]
        public IHttpActionResult GetExam(int id)
        {
            try
            {
                var exam = _examBusiness.GetSingleById(id);

                return Ok(Mapper.Map<Exam, ExamViewModel>(exam));
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Get list of exam.
        /// </summary>
        /// <returns>Exam list</returns>
        [HttpGet]
        [Route("getExamList")]
        public IHttpActionResult GetExamList()
        {
            try
            {
                var exams = _examBusiness.GetAll().ToList();

                return Ok(Mapper.Map<IEnumerable<Exam>, IEnumerable<ExamViewModel>>(exams));
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Create new exam.
        /// </summary>
        /// <param name="examVm">Exam view model containing new exam data</param>
        /// <returns>New exam</returns>
        [HttpPost]
        [Route("createExam")]
        public IHttpActionResult CreateExam(ExamViewModel examVm)
        {
            try
            {
                var exam = Mapper.Map<ExamViewModel, Exam>(examVm);
                exam.CreateDate = DateTime.Now;
                _examBusiness.Create(exam);
                _examBusiness.Save();

                return Ok(exam);
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Update exam information.
        /// </summary>
        /// <param name="examVm">Exam view model containing update data</param>
        /// <returns></returns>
        [HttpPut]
        [Route("updateExam")]
        public IHttpActionResult UpdateExam(ExamViewModel examVm)
        {
            try
            {
                var exam = Mapper.Map<ExamViewModel, Exam>(examVm);
                _examBusiness.Update(exam);
                _examBusiness.Save();

                return Ok(true);
            }
            catch (KeyNotFoundException e)
            {
                return BadRequest(e.Message);
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        /// <summary>
        /// Delete exam
        /// </summary>
        /// <param name="id">Exam id</param>
        /// <returns></returns>
        [AcceptVerbs("DELETE")]
        [Route("deleteExam/{id:int}")]
        public IHttpActionResult DeleteExam(int id)
        {
            try
            {
                _examBusiness.Delete(id);
                _examBusiness.Save();

                return Ok(true);
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }

        [HttpPost]
        [Route("generateQuestSheets")]
        public IHttpActionResult GenerateQuestionSheets(CreateQuestionSheetFormViewModel form)
        {

            var matrices = _matrixBusiness.GetMatricesByExamId(form.ExamId.Value).Select(m => m.Id).ToList();
            var shiftIds = form.ShiftIds.Where(sId => sId != null).Select(sId => sId.Value).ToList();
            bool flag = false;
            StringBuilder @string = new StringBuilder();
            List<int> Createds = new List<int>();

            foreach(var matrix in matrices)
            {
                try
                {
                    IEnumerable<int> list = _questionSheetBusiness.GenerateQuestionSheetByMatrixId(matrix, shiftIds);
                    Createds.AddRange(list);
                    flag = true;
                }
                catch (Exception ex)
                {
                    @string.Append(ex.Message);
                }
            }

            if(flag)
            {
                _questionSheetBusiness.Save();
                if (@string.Length == 0)
                {
                    return Ok(new { state = "OK", shiftsCreated = Createds });
                }
                else
                {
                    return Ok(new { state = "Warning", message = @string.ToString(), shiftsCreated = Createds });
                }
            }
            else
            {
                return InternalServerError(new Exception(@string.ToString()));
            }
            
        }

        /// <summary>
        /// Import exam data from excel file and generate question sheet.
        /// </summary>
        /// <param name="id">Exam id</param>
        /// <returns></returns>
        [HttpPost]
        [MultipartFormData]
        [Route("importData/{id:int}")]
        public async Task<IHttpActionResult> ImportData(int id)
        {
            try
            {
                var uploadFolderPath = ConfigurationManager.AppSettings["UploadFolderPath"];
                var fullPath = HttpContext.Current.Server.MapPath(uploadFolderPath);
                var result = await _examBusiness.ImportDataAsync(Request.Content, fullPath, id);
                _examBusiness.Save();
                var shifts = _shiftBusiness.GetShiftsByExamId(id)
                    .OrderByDescending(s => s.Name);
                var shiftsVM = Mapper.Map<IEnumerable<Shift>, IEnumerable<ShiftViewModel>>(shifts);
                return Ok(shiftsVM);
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }


        /// <summary>
        /// Import matrix data from excel file.
        /// </summary>
        /// <param name="id">Exam id</param>
        /// <returns></returns>
        [HttpPost]
        [MultipartFormData]
        [Route("importMatrixData/{id:int}")]
        public async Task<IHttpActionResult> ImportMatrixData(int id)
        {
            try
            {
                var uploadFolderPath = ConfigurationManager.AppSettings["UploadFolderPath"];
                var fullPath = HttpContext.Current.Server.MapPath(uploadFolderPath);
                await _examBusiness.ImportMatrixDataAsync(Request.Content, fullPath, id);
                _examBusiness.Save();

                var matrices = _matrixBusiness.GetMatricesByExamId(id).OrderByDescending(c=>c.CreateDate);

                return Ok(Mapper.Map<IEnumerable<Matrix>, IEnumerable<MatrixViewModel>>(matrices));
            }
            catch (Exception e)
            {
                return InternalServerError(e);
            }
        }


        [HttpPost]
        [Route("addExtraTime")]
        public IHttpActionResult AddExtraTime(StudentAddExtraTimeVM extraTimeVM)
        {
            try
            {
                foreach (var shiftId in extraTimeVM.ShiftIds)
                {
                    var questionSheets = _questionSheetBusiness.GetQuestionSheetsByShift(shiftId);
                    foreach (var qs in questionSheets)
                    {
                        _questionSheetBusiness.AddExtraTime(qs, extraTimeVM.Time, extraTimeVM.Reason);
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

        [HttpPost]
        [Route("activeShifts")]
        public IHttpActionResult ActiveShifts(EditStateViewModel editStateView)
        {
            foreach (var shiftId in editStateView.ShiftIds)
            {
                var shift = _shiftBusiness.GetSingleById((int)shiftId);
                foreach (var shiftSubject in shift.ShiftSubjects)
                {
                    _shiftSubjectBusiness.ActiveShiftSubject(shiftSubject);
                }
            }
            return Ok();
        }

        [HttpPost]
        [Route("terminateShifts")]
        public IHttpActionResult TerminateShifts(EditStateViewModel editStateView)
        {
            foreach (var shiftId in editStateView.ShiftIds)
            {
                var shift = _shiftBusiness.GetSingleById((int)shiftId);
                foreach (var shiftSubject in shift.ShiftSubjects)
                {
                    _shiftSubjectBusiness.TerminateShiftSubject(shiftSubject);
                }
            }
            return Ok();
        }

        [HttpPost]
        [Route("pauseShifts")]
        public IHttpActionResult PauseShifts(EditStateViewModel editStateView)
        {
            foreach(var shiftId in editStateView.ShiftIds)
            {
                var shift = _shiftBusiness.GetSingleById((int) shiftId);
                foreach(var shiftSubject in shift.ShiftSubjects)
                {
                    _shiftSubjectBusiness.PauseShiftSubject(shiftSubject);
                }
            }
            return Ok();
        }

        [HttpPost]
        [Route("searchStudent")]
        public IHttpActionResult searchStudent(SearchStudentViewModel searchViewModel)
        {
            if (searchViewModel.ExamId != null)
            {
                List<StudentInfoViewModel> studentInfos = new List<StudentInfoViewModel>();
                var students = _shiftSubjectStudentBusiness.GetSSSListByCodeAndExamId(searchViewModel.StudentCode, searchViewModel.ExamId.Value);

                foreach (var student in students)
                {
                    student.Student = _studentBusiness.GetSingleById(student.StudentId);
                    if(student.QuestionSheetId != null)
                    {
                        student.QuestionSheet = _questionSheetBusiness.GetSingleById((int)student.QuestionSheetId.Value);
                    }
                    student.ShiftSubject = _shiftSubjectBusiness.GetSingleById((int)student.ShiftSubjectId);
                    studentInfos.Add(new StudentInfoViewModel
                    {
                        Id = student.StudentId,
                        ShiftId =  student.ShiftSubject.ShiftId == null ? 0 : student.ShiftSubject.ShiftId.Value,
                        ShiftSubjectId = student.ShiftSubjectId,
                        Code = student.Student.Code,
                        QuestionSheetId = student.QuestionSheetId,
                        LastName = student.Student.LastName,
                        FirstName = student.Student.FirstName,
                        ClassName = student.Student.ClassName,
                        StateExam = student.StateExam,
                        ExtraTime = student.QuestionSheet != null ? student.QuestionSheet.ExtraTime : (short)0,
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
