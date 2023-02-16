using ExamManagement.Businesses.Infrastructures;
using ExamManagement.Businesses.Infrastructures.EntityExtensions;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Data.Repositories;
using ExamManagement.Entities;
using ExamManagement.Entities.ExcelModel;
using ExamManagement.Services;
using ExamManagement.Services.Exceptions;
using ExamManagement.Services.ExtensionMethods;
using ExamManagement.Services.MultipartFormData;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Businesses
{
    public interface IExamBusiness : IBusinessBase<Exam>
    {
        /// <summary>
        /// Impord shift, matrix and student list of exam.
        /// </summary>
        /// <param name="content">Contain uploaded files</param>
        /// <param name="folderPath">Folder path to save files</param>
        /// <param name="examId">Exam id</param>
        /// <returns></returns>
        Task<List<string>> ImportDataAsync(HttpContent content, string folderPath, int examId);

        /// <summary>
        /// Import matrix list of exam.
        /// </summary>
        /// <param name="content">Contain uploaded matrix files</param>
        /// <param name="folderPath">Folder path to save matrix files</param>
        /// <param name="examId">Exam id</param>
        /// <returns></returns>
        Task ImportMatrixDataAsync(HttpContent content, string folderPath, int examId);
    }

    public class ExamBusiness : BusinessBase<Exam>, IExamBusiness
    {
        private readonly IExamRepository _examRepository;
        private readonly IShiftRepository _shiftRepository;
        private readonly ISubjectRepository _subjectRepository;
        private readonly IMatrixRepository _matrixRepository;
        private readonly IMatrixDetailRepository _matrixDetailRepository;
        private readonly IShiftSubjectRepository _shiftSubjectRepository;
        private readonly IStudentRepository _studentRepository;
        private readonly IShiftSubjectStudentRepository _shiftSubjectStudentRepository;
        private readonly IChapterRepository _chapterRepository;

        public ExamBusiness(
            IExamRepository examRepository,
            IShiftRepository shiftRepository,
            ISubjectRepository subjectRepository,
            IMatrixRepository matrixRepository,
            IMatrixDetailRepository matrixDetailRepository,
            IShiftSubjectRepository shiftSubjectRepository,
            IStudentRepository studentRepository,
            IShiftSubjectStudentRepository shiftSubjectStudentRepository,
            IChapterRepository chapterRepository,
            IUnitOfWork unitOfWork)
            : base(examRepository, unitOfWork)
        {
            _examRepository = examRepository;
            _shiftRepository = shiftRepository;
            _subjectRepository = subjectRepository;
            _matrixRepository = matrixRepository;
            _matrixDetailRepository = matrixDetailRepository;
            _shiftSubjectRepository = shiftSubjectRepository;
            _studentRepository = studentRepository;
            _shiftSubjectStudentRepository = shiftSubjectStudentRepository;
            _chapterRepository = chapterRepository;
        }

        /// <summary>
        /// Get exam list which deleted is false.
        /// </summary>
        /// <returns>Exam list</returns>
        public override IEnumerable<Exam> GetAll()
        {
            return _examRepository.GetMulti(d => d.Deleted == false);
        }

        /// <summary>
        /// Update exam information.
        /// </summary>
        /// <param name="exam">Exam object</param>
        public override void Update(Exam exam)
        {
            var examDb = _examRepository.GetSingleById(exam.Id);
            if (examDb == null)
            {
                throw new KeyNotFoundException("Mã đợt thi không đúng.");
            }

            examDb.Update(exam);
        }

        /// <summary>
        /// Delete entity by id.
        /// </summary>
        /// <param name="id">Entity id</param>
        public override void Delete(int id)
        {
            var entity = _examRepository.GetSingleById(id);
            entity.Deleted = true;
        }

        /// <summary>
        /// Import shift, matrix and student list of exam.
        /// </summary>
        /// <param name="content">Contain uploaded files</param>
        /// <param name="folderPath">Folder path to save files</param>
        /// <param name="examId">Exam id</param>
        /// <returns></returns>
        public async Task<List<string>> ImportDataAsync(HttpContent content, string folderPath, int examId)
        {
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            var streamProvider = new FormDataStreamProvider(folderPath);
            await content.ReadAsMultipartAsync(streamProvider);

            var fileName = streamProvider.FileData.Select(d => d.LocalFileName).FirstOrDefault();
            var excelSchedules = ReadExcelSchedule(fileName);
            return SaveData(excelSchedules, examId);
        }

        private ExcelSchedule ReadExcelSchedule(string fileName)
        {
            var exams = new List<ExcelExamSchedule>();
            var matrices = new List<ExcelMatrixLink>();
            var dataFile = new FileInfo(fileName);
            try
            {
                using (var excelPackage = new ExcelPackage(dataFile))
                {
                    //Read Students and Shifts
                    var sheet1 = excelPackage.Workbook.Worksheets.First();

                    for (var row = 2; row <= sheet1.Dimension.End.Row; row++)
                    {
                        exams.Add(new ExcelExamSchedule
                        {
                            ExamDate = sheet1.Cell(row, AppSettings.ExamDateHeader).Text,
                            StartTime = sheet1.Cell(row, AppSettings.StartTimeHeader).Text,
                            Duration = sheet1.Cell(row, AppSettings.DurationHeader).Text,
                            SubjectCode = sheet1.Cell(row, AppSettings.SubjectHeader).Text,
                            GroupCode = sheet1.Cell(row, AppSettings.GroupCodeHeader).Text,
                            SubGroupCode = sheet1.Cell(row, AppSettings.SubGroupCodeHeader).Text,
                            StudentCode = sheet1.Cell(row, AppSettings.StudentCodeHeader).Text,
                            StudentLastName = sheet1.Cell(row, AppSettings.StudentLastNameHeader).Text,
                            StudentFirstName = sheet1.Cell(row, AppSettings.StudentFirstNameHeader).Text,
                            StudentClassName = sheet1.Cell(row, AppSettings.StudentClassNameHeader).Text
                        });
                    }

                    //Read Matrices
                    var sheet2 = excelPackage.Workbook.Worksheets[2];

                    for (var row = 2; row <= sheet2.Dimension.End.Row; row++)
                    {
                        matrices.Add(new ExcelMatrixLink
                        {
                            ExamDate = sheet2.Cell(row, AppSettings.ExamDateHeader).Text,
                            StartTime = sheet2.Cell(row, AppSettings.StartTimeHeader).Text,
                            Duration = sheet2.Cell(row, AppSettings.DurationHeader).Text,
                            SubjectCode = sheet2.Cell(row, AppSettings.SubjectHeader).Text,
                            BankSubjectCode = sheet2.Cell(row, AppSettings.BankSubjectHeader).Text,
                            GroupCode = sheet2.Cell(row, AppSettings.GroupCodeHeader).Text,
                            SubGroupCode = sheet2.Cell(row, AppSettings.SubGroupCodeHeader).Text,
                            MatrixCode = sheet2.Cell(row, AppSettings.MatrixCodeHeader).Text
                        });
                    }
                }
            }
            catch (Exception e)
            {
                throw new SaveImportDataException("Lỗi xảy ra khi đọc dữ liệu file excel.", e);
            }

            return new ExcelSchedule { ExcelExamSchedules = exams, ExcelMatrixLinks = matrices };
        }

        private List<string> SaveData(ExcelSchedule excelSchedule, int examId)
        {
            try
            {
                List<string> shiftNames = new List<string>();

                var students = excelSchedule.ExcelExamSchedules
                    .GroupBy(s => new { s.ExamDate, s.StartTime, s.Duration, s.SubjectCode, s.GroupCode, s.SubGroupCode })
                    .SelectMany(c => c);
                var subjects = excelSchedule.ExcelMatrixLinks
                    .GroupBy(s => new { s.ExamDate, s.StartTime, s.Duration, s.SubjectCode, s.GroupCode, s.SubGroupCode })
                    .SelectMany(c=>c);

                var shiftSubjectStudents = subjects.GroupJoin(students, 
                    subjs => new { subjs.ExamDate, subjs.StartTime, subjs.Duration, subjs.SubjectCode, subjs.GroupCode, subjs.SubGroupCode }, 
                    studs => new { studs.ExamDate, studs.StartTime, studs.Duration, studs.SubjectCode, studs.GroupCode, studs.SubGroupCode },
                    (sub, studs) => new { Subject = sub, Students = studs })
                    .GroupBy(c => new { c.Subject.ExamDate, c.Subject.StartTime, c.Subject.Duration });
                //var sh = subjects.Concat(students);

                //BEGIN import shift
                foreach (var shift in shiftSubjectStudents)
                {
                    string[] formats = new string[] { "MM/dd/yyyy HH:mm", "MM/d/yyyy HH:mm", "M/dd/yyyy HH:mm", "M/d/yyyy HH:mm", "dd/MM/yyyy HH:mm", "d/M/yyyy HH:mm", "dd/M/yyyy HH:mm", "d/MM/yyyy HH:mm" };
                    var shiftKey = shift.Key;
                    var startDateTime = DateTime.ParseExact(shiftKey.ExamDate + " " + shiftKey.StartTime, formats, CultureInfo.InvariantCulture, DateTimeStyles.None);
                    //var shiftName = $"{startDateTime.ToString("dd/MM/yyyy")} - {shiftKey.StartTime} - {shiftKey.Duration}";
                    var shiftName = startDateTime.ToString("dd/MM/yyyy - HH:mm") + " - " + shiftKey.Duration;
                    var newShift = _shiftRepository.GetSingleByCondition(s => s.Name == shiftName && s.ExamId == examId && s.Deleted == false);

                    if (newShift == null)
                    {
                        newShift = new Shift
                        {
                            Name = shiftName,
                            ExamId = examId,
                            QuestionSheetCreated = false
                        };
                        _shiftRepository.Create(newShift);
                    }

                    //BEGIN import subjects per shift 
                    foreach (var subjectStudent in shift)
                    {
                        var result = int.TryParse(subjectStudent.Subject.BankSubjectCode, out int subjectDbId);
                        if (!result)
                        {
                            throw new SaveImportDataException("Mã môn phải có định dạng số");
                        }

                        var subjectDb = _subjectRepository.GetSingleById(subjectDbId);//Maybe change to subject code
                        if (subjectDb == null)
                        {
                            throw new SaveImportDataException("Mã môn " + subjectStudent.Subject.BankSubjectCode + " không tồn tại trong hệ thống.");
                        }

                        var matrixDb = _matrixRepository.GetSingleByCondition(c=>c.Name == subjectStudent.Subject.MatrixCode && c.ExamId == examId);
                        if (matrixDb == null)
                        {
                            throw new SaveImportDataException("Ma trận " + subjectStudent.Subject.MatrixCode + " không tồn tại trong hệ thống.");
                        }

                        var shiftSubject = _shiftSubjectRepository
                                .GetSingleByCondition(s => s.ShiftId == newShift.Id 
                                && s.SubjectId == subjectDb.Id 
                                && s.GroupCode == subjectStudent.Subject.GroupCode 
                                && s.SubGroupCode == subjectStudent.Subject.SubGroupCode,
                                new string[] { "Shift" });

                        if (shiftSubject == null)
                        {
                            shiftSubject = new ShiftSubject
                            {
                                Shift = newShift,
                                MatrixId = matrixDb.Id,
                                SubjectId = subjectDb.Id,
                                SubjectName = subjectDb.Name,
                                SubjectCode = subjectStudent.Subject.SubjectCode,
                                GroupCode = subjectStudent.Subject.GroupCode,
                                SubGroupCode = subjectStudent.Subject.SubGroupCode,
                                StartTime = startDateTime,
                                Duration = short.Parse(shiftKey.Duration),
                                StateActivate = 1,
                                ActivateTime = null,
                                EndDate = null,
                                EndTime = null,
                                Ended = false,
                                CreatedQuestionSheet = false,
                            };
                            _shiftSubjectRepository.Create(shiftSubject);
                        }
                        shiftSubject.Shift = newShift;

                        //BEGIN import students per shiftsubject
                        if(shiftSubject.StateActivate != 4)
                        {
                            if(!shiftNames.Contains(shiftSubject.Shift.Name))
                            {
                                shiftNames.Add(shiftSubject.Shift.Name);
                            }

                            foreach (var student in subjectStudent.Students)
                            {
                                var studentDb = _studentRepository.GetByCode(student.StudentCode);
                                if (studentDb == null)
                                {
                                    studentDb = new Student
                                    {
                                        Code = student.StudentCode,
                                        FirstName = student.StudentFirstName.Trim(),
                                        LastName = student.StudentLastName.Trim(),
                                        ClassName = student.StudentClassName,
                                        Name = student.StudentLastName.Trim() + ' ' + student.StudentFirstName.Trim()
                                    };
                                    _studentRepository.Create(studentDb);
                                }

                                studentDb.FirstName = student.StudentFirstName;
                                studentDb.LastName = student.StudentLastName;
                                studentDb.ClassName = student.StudentClassName;

                                ShiftSubjectStudent shiftSubjectStudent = null;
                                shiftSubjectStudent = _shiftSubjectStudentRepository
                                        .GetSingleByCondition(s => s.ShiftSubjectId == shiftSubject.Id && s.StudentId == studentDb.Id);
                                if (shiftSubjectStudent == null)
                                {
                                    shiftSubjectStudent = new ShiftSubjectStudent
                                    {
                                        ShiftSubject = shiftSubject,
                                        Student = studentDb,
                                        StateExam = 1,
                                        LogIn = false,
                                        InsertTime = DateTime.Now
                                    };
                                    shiftSubject.CreatedQuestionSheet = false;
                                    shiftSubject.Shift.QuestionSheetCreated = false;
                                    _shiftSubjectStudentRepository.Create(shiftSubjectStudent);
                                }
                            }
                        }
                        //BEGIN import students per shiftsubject
                    }

                    //END import subjects per shift 
                }

                return shiftNames;
                //END import

                //foreach (var shift in shifts)
                //{
                //    string[] formats = new string[] { "MM/dd/yyyy HH:mm", "MM/d/yyyy HH:mm", "M/dd/yyyy HH:mm", "M/d/yyyy HH:mm" };
                //    var shiftKey = shift.Key;
                //    var startDateTime = DateTime.ParseExact(shiftKey.ExamDate + " " + shiftKey.StartTime, formats, CultureInfo.InvariantCulture, DateTimeStyles.None);
                //    var shiftName = $"{startDateTime.ToString("dd/MM/yyyy")} - {shiftKey.StartTime} - {shiftKey.Duration}";
                //    var newShift = _shiftRepository.GetSingleByCondition(s => s.Name == shiftName && s.ExamId == examId);

                //    if (newShift == null)
                //    {
                //        newShift = new Shift
                //        {
                //            Name = shiftName,
                //            StartTime = startDateTime,
                //            EndTime = startDateTime.AddMinutes(Convert.ToDouble(shiftKey.Duration)),
                //            Duration = Convert.ToInt16(shiftKey.Duration),
                //            ExamId = examId
                //        };
                //        _shiftRepository.Create(newShift);
                //    }

                //    var subjects = shift.GroupBy(s => new { s.SubjectCode, s.GroupCode, s.SubGroupCode });
                //    foreach (var subject in subjects)
                //    {
                //        var subjectDb = _subjectRepository.GetByCode(subject.Key.SubjectCode);
                //        if (subjectDb == null)
                //        {
                //            throw new SaveImportDataException("Môn " + subject.Key + " không tồn tại trong hệ thống.");
                //        }

                //        ShiftSubject shiftSubject = null;
                //        if (newShift.Id > 0)
                //        {
                //            shiftSubject = _shiftSubjectRepository
                //                .GetSingleByCondition(s => s.ShiftId == newShift.Id && s.SubjectId == subjectDb.Id);

                //            //BEGIN Insert new Matrix
                //            //var matrixId = shiftSubject.MatrixId ?? 0;
                //            ////Delete old Matrix
                //            //_matrixRepository.DeleteDetails(matrixId);

                //            //var matrixCode = matrices;
                //            //var matrix = _matrixRepository.GetSingleByCondition(m => m.Name == subject.)

                //            //shiftSubject.Matrix = newMatrix;
                //            //END Insert new Matrix
                //        }
                //        if (shiftSubject == null)
                //        {
                //            //var matrixLink = matrices.SingleOrDefault(c => c.Key.ExamDate == shift.Key.ExamDate
                //            //&& c.Key.StartTime == shift.Key.StartTime
                //            //&& c.Key.Duration == shift.Key.Duration
                //            //&& c.Key.SubjectCode == subject.Key.SubjectCode
                //            //&& c.Key.GroupCode == subject.Key.GroupCode
                //            //&& c.Key.SubjectCode == subject.Key.SubGroupCode
                //            //);
                //            //var matrixLink = matrices.Where(m=> m.SubjectCode.Equals(subject.Key.SubjectCode)
                //            //   && m.GroupCode.Equals(subject.Key.GroupCode)
                //            //   && m.SubjectCode.Equals(subject.Key.SubGroupCode));

                //            //var matrixId = _matrixRepository.GetSingleByCondition(c => c.ExamId == examId && c.Name == "").Id;
                //            shiftSubject = new ShiftSubject
                //            {
                //                Shift = newShift,
                //                SubjectId = subjectDb.Id,
                //                GroupCode = subject.Key.GroupCode,
                //                SubGroupCode = subject.Key.SubGroupCode,
                //                //MatrixId = matrixId
                //                //Matrix = newMatrix //Insert new Matrix
                //            };
                //            _shiftSubjectRepository.Create(shiftSubject);
                //        }

                //        foreach (var row in subject)
                //        {
                //            var student = _studentRepository.GetByCode(row.StudentCode);
                //            if (student == null)
                //            {
                //                student = new Student
                //                {
                //                    Code = row.StudentCode,
                //                    FirstName = row.StudentFirstName,
                //                    LastName = row.StudentLastName,
                //                    ClassName = row.StudentClassName
                //                };
                //                _studentRepository.Create(student);
                //            }

                //            ShiftSubjectStudent shiftSubjectStudent = null;
                //            if (shiftSubject.Id > 0 && student.Id > 0)
                //            {
                //                shiftSubjectStudent = _shiftSubjectStudentRepository
                //                    .GetSingleByCondition(s => s.ShiftSubjectId == shiftSubject.Id && s.StudentId == student.Id);
                //            }

                //            if (shiftSubjectStudent == null)
                //            {
                //                shiftSubjectStudent = new ShiftSubjectStudent
                //                {
                //                    ShiftSubject = shiftSubject,
                //                    Student = student
                //                };
                //                _shiftSubjectStudentRepository.Create(shiftSubjectStudent);
                //            }
                //        }
                //    }
                //}
            }
            catch (Exception e)
            {
                throw new SaveImportDataException("Lỗi xảy ra khi lưu dữ liệu file excel.", e);
            }
        }


        /// <summary>
        /// Import matrix data to exam
        /// </summary>
        /// <param name="content">Contain uploaded files</param>
        /// <param name="folderPath">Folder path to save files</param>
        /// <param name="examId">Exam id</param>
        /// <returns></returns>
        public async Task ImportMatrixDataAsync(HttpContent content, string folderPath, int examId)
        {
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            var streamProvider = new FormDataStreamProvider(folderPath);
            await content.ReadAsMultipartAsync(streamProvider);
            var fileNames = streamProvider.FileData.Select(d => d.LocalFileName);
            var excelSchedules = ReadExcelMaxtrices(fileNames);
            SaveMatricesData(excelSchedules, examId);
        }

        private List<ExcelMatrix> ReadExcelMaxtrices(IEnumerable<string> fileNames)
        {
            var matrices = new List<ExcelMatrix>();
            try
            {
                foreach (var fileName in fileNames)
                {
                    var matrix = new List<ExcelMatrixDetail>();

                    //Load file
                    var dataFile = new FileInfo(fileName);
                    using (var excelPackage = new ExcelPackage(dataFile))
                    {
                        //Read Matrix sheet
                        var sheet1 = excelPackage.Workbook.Worksheets.First();

                        for (var row = 2; row <= sheet1.Dimension.End.Row; row++)
                        {
                            matrix.Add(new ExcelMatrixDetail
                            {
                                ChapterId = sheet1.Cell(row, AppSettings.ChapterIdHeader).Text,
                                Quantity = sheet1.Cell(row, AppSettings.QuantityHeader).Text,
                                ExceptList = sheet1.Cell(row, AppSettings.ExceptListHeader).Text,
                                Factor = sheet1.Cell(row, AppSettings.FactorHeader).Text
                            });
                        }
                    }

                    matrices.Add(new ExcelMatrix
                    {
                        MatrixName = Path.GetFileNameWithoutExtension(fileName),
                        ExcelMatrixDetails = matrix
                    });
                }
            }
            catch (Exception e)
            {
                throw new SaveImportDataException("Lỗi xảy ra khi đọc dữ liệu file excel.", e);
            }

            return matrices;
        }
        private void SaveMatricesData(List<ExcelMatrix> excelMatrices, int examId)
        {
            try
            {
                foreach (var excelMatrix in excelMatrices)
                {
                    var matrix = _matrixRepository.GetSingleByCondition(c => c.Name == excelMatrix.MatrixName && c.ExamId == examId);

                    List<MatrixDetail> newDetails = new List<MatrixDetail>();
                    foreach (var detail in excelMatrix.ExcelMatrixDetails)
                    {
                        newDetails.Add(new MatrixDetail
                        {
                            ChapterId = Convert.ToInt16(detail.ChapterId),
                            Quantity = Convert.ToInt16(detail.Quantity),
                            Excluded = detail.ExceptList,
                            Factor = Convert.ToInt16(detail.Factor)
                        });
                    }

                    if (matrix == null)
                    {
                        matrix = new Matrix
                        {
                            CreateDate = DateTime.Now,
                            Name = excelMatrix.MatrixName,
                            ExamId = examId,
                            MatrixDetails = newDetails
                        };
                        _matrixRepository.Create(matrix);
                    }
                    else
                    {
                        //Delete old Matrix details
                        _matrixRepository.DeleteDetails(matrix.Id);
                        matrix.CreateDate = DateTime.Now;
                        matrix.MatrixDetails = newDetails;
                    }
                    
                }

            }
            catch (Exception e)
            {
                throw new SaveImportDataException("Lỗi xảy ra khi lưu dữ liệu file excel.", e);
            }
        }
        //public void ValidateExcel(ExcelFile excelFile)
        //{
        //    var errorList = new List<string>();

        //    foreach (var shiftRow in excelFile.ShiftSheet.ShiftRows)
        //    {
        //        if (_shiftRepository.GetByName(shiftRow.Name) != null)
        //        {

        //        }
        //    }
        //}

        /// <summary>
        /// Read excel file then save into Excel file object.
        /// </summary>
        /// <param name="fileName">File name</param>
        /// <returns>Excel file object</returns>
        private static ExcelFile ReadExcelFile(string fileName)
        {
            var excelFile = new ExcelFile();
            var fileInfo = new FileInfo(fileName);

            using (var excelPackage = new ExcelPackage(fileInfo))
            {
                // Read shift sheet.
                var shiftSheet = excelPackage.Workbook.Worksheets["CA_THI"];

                for (var row = 2; row <= shiftSheet.Dimension.End.Row; row++)
                {
                    if (shiftSheet.Cells[row, 1].Text.Trim().Equals(""))
                    {
                        continue;
                    }

                    var shiftRow = new ShiftRow
                    {
                        Date = shiftSheet.Cells[row, 1].Text,
                        StartTime = shiftSheet.Cells[row, 2].Text.Replace("h", ":"),
                        Duration = shiftSheet.Cells[row, 3].Text,
                        SubjectCode = shiftSheet.Cells[row, 4].Text,
                        SubjectName = shiftSheet.Cells[row, 5].Text,
                        MatrixSheetName = shiftSheet.Cells[row, 6].Text,
                        StudentSheetName = shiftSheet.Cells[row, 7].Text,
                    };
                    excelFile.ShiftSheet.ShiftRows.Add(shiftRow);
                }

                // Read matrix sheets
                var matrixSheets = excelPackage.Workbook.Worksheets.Where(s => s.Name.StartsWith("YC_"));
                foreach (var sheet in matrixSheets)
                {
                    var matrixSheet = new MatrixSheet { Name = sheet.Name };

                    for (var row = 2; row <= sheet.Dimension.End.Row; row++)
                    {
                        if (sheet.Cells[row, 1].Text.Trim().Equals(""))
                        {
                            continue;
                        }

                        var matrixRow = new MatrixRow()
                        {
                            ChapterId = sheet.Cells[row, 1].Text,
                            Quantity = sheet.Cells[row, 2].Text,
                            Excluded = sheet.Cells[row, 3].Text,
                        };
                        matrixSheet.MatrixRows.Add(matrixRow);
                    }
                    excelFile.MatrixSheets.Add(matrixSheet);
                }

                // Read student sheets
                var studentSheets = excelPackage.Workbook.Worksheets.Where(s => s.Name.StartsWith("SV_"));
                foreach (var sheet in studentSheets)
                {
                    var studentSheet = new StudentSheet
                    {
                        Name = sheet.Name
                    };

                    for (var row = 2; row <= sheet.Dimension.End.Row; row++)
                    {
                        if (sheet.Cells[row, 1].Text.Trim().Equals(""))
                        {
                            continue;
                        }

                        var studentRow = new StudentRow()
                        {
                            StudentCode = sheet.Cells[row, 1].Text,
                            StudentFirstName = sheet.Cells[row, 2].Text,
                            StudentLastName = sheet.Cells[row, 3].Text
                        };
                        studentSheet.StudentRows.Add(studentRow);
                    }
                    excelFile.StudentSheets.Add(studentSheet);
                }

                return excelFile;
            }
        }

        /// <summary>
        /// Save data in excel file object to database.
        /// </summary>
        /// <param name="excelFile">Excel object</param>
        /// <param name="examId">Exam id</param>
        private void SaveDataIntoDatabase(ExcelFile excelFile, int examId)
        {
            try
            {
                var shiftGroups = excelFile.ShiftSheet.ShiftRows
                    .GroupBy(s => new { s.Date, s.StartTime, s.Duration });
                foreach (var group in shiftGroups)
                {
                    var key = group.Key;

                    var newShift = new Shift
                    {
                        Name = $"{key.Date} - {key.StartTime} - {key.Duration}",
                        ExamId = examId
                    };
                    _shiftRepository.Create(newShift);

                    foreach (var shiftRow in group.ToList())
                    {
                        var subjectDb = _subjectRepository.GetByCode(shiftRow.SubjectCode);

                        // Insert matrix.
                        var matrix = _matrixRepository.GetByName(shiftRow.MatrixSheetName);
                        if (matrix == null) // Create new matrix.
                        {
                            matrix = new Matrix
                            {
                                ExamId = examId,
                                CreateDate = DateTime.Now,
                                Name = shiftRow.MatrixSheetName
                            };
                            _matrixRepository.Create(matrix);
                        }
                        else // Update matrix.
                        {
                            matrix.ExamId = examId;
                            _matrixDetailRepository.DeleteMulti(m => m.MatrixId == matrix.Id);
                        }

                        var matrixSheet = excelFile.MatrixSheets.SingleOrDefault(m => m.Name == shiftRow.MatrixSheetName);
                        if (matrixSheet != null)
                        {
                            foreach (var matrixRow in matrixSheet.MatrixRows)
                            {
                                if (matrixRow.ChapterId.Trim().Equals(""))
                                {
                                    continue;
                                }

                                var matrixDetail = new MatrixDetail
                                {
                                    Matrix = matrix,
                                    ChapterId = Convert.ToInt32(matrixRow.ChapterId),
                                    Quantity = Convert.ToInt32(matrixRow.Quantity),
                                    Excluded = matrixRow.Excluded.Trim().Replace(" ", string.Empty)
                                };
                                _matrixDetailRepository.Create(matrixDetail);
                            }
                        }

                        // Create ShiftSubject.
                        var shiftSubject = new ShiftSubject
                        {
                            Shift = newShift,
                            SubjectId = subjectDb.Id,
                            Matrix = matrix
                        };
                        _shiftSubjectRepository.Create(shiftSubject);

                        var studentSheet = excelFile.StudentSheets.SingleOrDefault(m => m.Name == shiftRow.StudentSheetName);
                        if (studentSheet != null)
                        {
                            foreach (var studentRow in studentSheet.StudentRows)
                            {
                                var student = _studentRepository.GetByCode(studentRow.StudentCode);
                                if (student == null)
                                {
                                    student = new Student
                                    {
                                        Code = studentRow.StudentCode,
                                        FirstName = studentRow.StudentFirstName,
                                        LastName = studentRow.StudentLastName
                                    };
                                    _studentRepository.Create(student);
                                }

                                var shiftSubjectStudent = new ShiftSubjectStudent
                                {
                                    ShiftSubject = shiftSubject,
                                    Student = student,
                                };
                                _shiftSubjectStudentRepository.Create(shiftSubjectStudent);
                            }
                        }
                    }
                }
            }
            catch (Exception e)
            {
                throw new SaveImportDataException("Lỗi xảy ra khi lưu dữ liệu file excel.", e);
            }
        }
    }
}
