using ExamManagement.Businesses.Infrastructures;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Data.Repositories;
using ExamManagement.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Businesses
{
    public interface IShiftSubjectStudentBusiness : IBusinessBase<ShiftSubjectStudent>
    {
        IEnumerable<ShiftSubjectStudent> GetSSSListByCodeAndShiftId(string studentCode, long shiftId);
        IEnumerable<ShiftSubjectStudent> GetSSSListByCodeAndSSId(string studentCode, long shiftSubjectId);
        IEnumerable<ShiftSubjectStudent> GetSSSListByCodeAndExamId(string studentCode, long examId);
        IEnumerable<ShiftSubjectStudent> GetSSSListByShiftSubject(long shiftSubjectId);
    }

    class ShiftSubjectStudentBusiness : BusinessBase<ShiftSubjectStudent>, IShiftSubjectStudentBusiness
    {
        IShiftSubjectStudentRepository _shiftSubjectStudentRepository;

        public ShiftSubjectStudentBusiness(IShiftSubjectStudentRepository shiftSubjectStudentRepository, IUnitOfWork unitOfWork)
            : base(shiftSubjectStudentRepository,unitOfWork)
        {
            _shiftSubjectStudentRepository = shiftSubjectStudentRepository;
        }

        public IEnumerable<ShiftSubjectStudent> GetSSSListByCodeAndExamId(string studentCode, long examId)
        {
            return _shiftSubjectStudentRepository.GetSSSListByCodeAndExamId(studentCode, examId);
        }

        public IEnumerable<ShiftSubjectStudent> GetSSSListByCodeAndShiftId(string studentCode, long shiftId)
        {
            return _shiftSubjectStudentRepository.GetSSSListByCodeAndShiftId(studentCode, shiftId);
        }

        public IEnumerable<ShiftSubjectStudent> GetSSSListByCodeAndSSId(string studentCode, long shiftSubjectId)
        {
            return _shiftSubjectStudentRepository.GetSSSListByCodeAndSSId(studentCode, shiftSubjectId);
        }

        public IEnumerable<ShiftSubjectStudent> GetSSSListByShiftSubject(long shiftSubjectId)
        {
            return _shiftSubjectStudentRepository.GetMulti(sss => sss.ShiftSubjectId == shiftSubjectId).ToList();
        }

        public override void Update(ShiftSubjectStudent entity)
        {
            throw new NotImplementedException();
        }
    }
}
