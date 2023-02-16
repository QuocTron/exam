using ExamManagement.Businesses.Infrastructures;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Data.Repositories;
using ExamManagement.Entities;
using System.Collections.Generic;
using System;
using System.Linq;

namespace ExamManagement.Businesses
{
    public interface IStudentBusiness : IBusinessBase<Student>
    {
        /// <summary>
        /// Get student list in shift by shift id and subject id.
        /// </summary>
        /// <param name="shiftId">Shift id</param>
        /// <param name="subjectId">Subject id</param>
        /// <returns>Student list</returns>
        IEnumerable<Student> GetStudentListByShiftSubject(int shiftId, int subjectId);

        /// <summary>
        /// Get shiftSubjectStudent by Student id and Shift Subject id.
        /// </summary>
        /// <param name="studentId">Student id</param>
        /// <param name="shiftSubjectId">Shift Subject id</param>
        /// <returns>shiftSubjectStudent</returns>
        ShiftSubjectStudent GetSSSByStudentSubject(int studentId, int shiftSubjectId);

        /// <summary>
        /// Create ShiftSubjectStudent.
        /// </summary>
        /// <param name="shiftSubjectStudent">ShiftSubjectStudent</param>
        /// <returns>shiftSubjectStudent</returns>
        ShiftSubjectStudent CreateSSS(ShiftSubjectStudent student);

        /// <summary>
        /// Get Student by code
        /// </summary>
        /// <param name="code">Student code</param>
        /// <returns></returns>
        Student getByCode(string code);
    }

    public class StudentBusiness : BusinessBase<Student>, IStudentBusiness
    {
        private IStudentRepository _studentRepository;
        private IShiftSubjectRepository _shiftSubjectRepository;
        private IShiftSubjectStudentRepository _shiftSubjectStudentRepository;

        public StudentBusiness(
            IStudentRepository studentRepository,
            IShiftSubjectRepository shiftSubjectRepository,
            IShiftSubjectStudentRepository shiftSubjectStudentRepository,
            IUnitOfWork unitOfWork)
            : base(studentRepository, unitOfWork)
        {
            _studentRepository = studentRepository;
            _shiftSubjectRepository = shiftSubjectRepository;
            _shiftSubjectStudentRepository = shiftSubjectStudentRepository;
        }

        /// <summary>
        /// Get student list in shift by shift id and subject id.
        /// </summary>
        /// <param name="shiftId">Shift id</param>
        /// <param name="shiftSubjectId">Shift Subject id</param>
        /// <returns>Student list</returns>
        public IEnumerable<Student> GetStudentListByShiftSubject(int shiftId, int shiftSubjectId)
        {
            var studentIds = _shiftSubjectStudentRepository
                .GetMulti(s => s.ShiftSubjectId == shiftSubjectId)
                .Select(s => s.StudentId);

            return _studentRepository.GetMulti(s => studentIds.Contains(s.Id));
        }

        /// <summary>
        /// Get shiftSubjectStudent by Student id and Shift Subject id.
        /// </summary>
        /// <param name="studentId">Student id</param>
        /// <param name="shiftSubjectId">Shift Subject id</param>
        /// <returns>shiftSubjectStudent</returns>
        public ShiftSubjectStudent GetSSSByStudentSubject(int studentId, int shiftSubjectId)
        {
            var shiftSubjectStudent = _shiftSubjectStudentRepository.GetSingleByCondition(c => c.ShiftSubjectId == shiftSubjectId && c.StudentId == studentId);

            return shiftSubjectStudent;
        }

        /// <summary>
        /// Create ShiftSubjectStudent.
        /// </summary>
        /// <param name="shiftSubjectStudent">ShiftSubjectStudent</param>
        /// <returns>shiftSubjectStudent</returns>
        public ShiftSubjectStudent CreateSSS(ShiftSubjectStudent student)
        {
            _shiftSubjectStudentRepository.Create(student);

            return student;
        }

        public override void Update(Student entity)
        {
            throw new System.NotImplementedException();
        }

        public Student getByCode(string code)
        {
            var student = _studentRepository.GetByCode(code);
            return student;
        }
    }
}