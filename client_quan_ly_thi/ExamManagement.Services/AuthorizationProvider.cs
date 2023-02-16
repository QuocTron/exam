using ExamManagement.Data.Repositories;
using Microsoft.Owin.Security.OAuth;
using System.Security.Claims;
using System.Threading.Tasks;

namespace ExamManagement.Services
{
    public class AuthorizationProvider : OAuthAuthorizationServerProvider
    {
        private readonly IUserRepository _userRepository;

        public AuthorizationProvider(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public override async Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            context.Validated();
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {

            context.OwinContext.Response.Headers.Add("Access-Control-Allow-Origin", new[] { "*" });

            var user = await _userRepository.FindUserAsync(context.UserName, context.Password);
            
            if (user == null)
            {
                context.SetError("invalid_grant", "Tên đăng nhập hoặc mật khẩu không đúng.");
                return;
            }
            
            var identity = new ClaimsIdentity(context.Options.AuthenticationType);
            identity.AddClaim(new Claim("sub", context.UserName));
            identity.AddClaim(new Claim("role", "user"));

            context.Validated(identity);
        }
    }
}
