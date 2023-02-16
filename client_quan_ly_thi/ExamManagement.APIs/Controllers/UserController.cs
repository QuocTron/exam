using ExamManagement.Businesses;
using System.Web.Http;

namespace ExamManagement.APIs.Controllers
{
    public class UserController : ApiController
    {
        private IUserBusiness _userBusiness;

        public UserController(IUserBusiness userBusiness)
        {
            _userBusiness = userBusiness;
        }
    }
}
