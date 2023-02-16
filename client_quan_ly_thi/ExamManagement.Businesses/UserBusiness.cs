using ExamManagement.Businesses.Infrastructures;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Data.Repositories;
using ExamManagement.Entities;

namespace ExamManagement.Businesses
{
    public interface IUserBusiness : IBusinessBase<User>
    {
    }

    public class UserBusiness : BusinessBase<User>, IUserBusiness
    {
        public UserBusiness(IUserRepository userRepository, IUnitOfWork unitOfWork)
            : base(userRepository, unitOfWork)
        {
        }

        public override void Update(User entity)
        {
            throw new System.NotImplementedException();
        }
    }
}
