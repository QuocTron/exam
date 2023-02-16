using ExamManagement.Data.Infrastructures;
using ExamManagement.Entities;
using System.Data.Entity;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Data.Repositories
{
    public interface IUserRepository : IRepository<User>
    {
        Task<User> FindUserAsync(string username, string password);
        User FindUser(string username, string password);
    }

    public class UserRepository : RepositoryBase<User>, IUserRepository
    {
        public UserRepository(IDbFactory dbFactory)
            : base(dbFactory)
        {
        }

        public async Task<User> FindUserAsync(string username, string password)
        {
            var hash = MD5Hash(password);
            var rs = await DbContext.Users
                .FirstOrDefaultAsync(n => n.Username.Equals(username) && n.Password.Equals(hash));
            return rs;
        }

        public User FindUser(string username, string password)
        {
            var user = DbContext.Users
            .FirstOrDefault(n => n.Username.Equals(username) && n.Password.Equals(MD5Hash(password)));

            return user;
        }
        public string MD5Hash(string text)
        {
            MD5 md5 = new MD5CryptoServiceProvider();

            //compute hash from the bytes of text  
            md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(text));

            //get hash result after compute it  
            byte[] result = md5.Hash;

            StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < result.Length; i++)
            {
                //change it into 2 hexadecimal digits  
                //for each byte  
                strBuilder.Append(result[i].ToString("X2"));
            }

            return strBuilder.ToString();
        }
    }
}
