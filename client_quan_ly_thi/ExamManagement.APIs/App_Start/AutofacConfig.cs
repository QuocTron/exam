using Autofac;
using Autofac.Integration.WebApi;
using ExamManagement.Businesses;
using ExamManagement.Data;
using ExamManagement.Data.Infrastructures;
using ExamManagement.Data.Repositories;
using System.Reflection;
using System.Web.Http;

namespace ExamManagement.APIs
{
    public class AutofacConfig
    {
        public static IContainer Container;
        public static void Initialize(HttpConfiguration config)
        {
            Initialize(config, RegisterServices(new ContainerBuilder()));
        }

        public static void Initialize(HttpConfiguration config, IContainer container)
        {
            config.DependencyResolver = new AutofacWebApiDependencyResolver(container);
        }

        private static IContainer RegisterServices(ContainerBuilder builder)
        {
            builder.RegisterApiControllers(Assembly.GetExecutingAssembly());

            builder.RegisterType<ExamManagementContext>()
                   .AsSelf()
                   .InstancePerRequest();

            builder.RegisterType<DbFactory>()
                .As<IDbFactory>()
                .InstancePerRequest();

            builder.RegisterType<UnitOfWork>()
                .As<IUnitOfWork>()
                .InstancePerRequest();

            // Repositories
            builder.RegisterAssemblyTypes(typeof(ShiftRepository).Assembly)
                .Where(t => t.Name.EndsWith("Repository"))
                .AsImplementedInterfaces().InstancePerRequest();

            // Business
            builder.RegisterAssemblyTypes(typeof(ShiftBusiness).Assembly)
                .Where(t => t.Name.EndsWith("Business"))
                .AsImplementedInterfaces().InstancePerRequest();

            Container = builder.Build();

            return Container;
        }
    }
}