using System.Threading.RateLimiting;
using EMS.Business.Clouds;
using EMS.Business.Profiles;
using EMS.Business.Services;
using EMS.Business.Services.Implements;
using EMS.Data.Contexts;
using EMS.Data.Repositories;
using EMS.Data.Repositories.Implements;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;

namespace EMS
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            builder.Services.AddControllersWithViews();

            var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
            builder.Services.AddDbContext<SqlServerContext>(options => 
                options.UseSqlServer(connectionString));

            //DI 
            builder.Services.AddScoped<IUserAuthRepository, UserAuthRepository>();
            builder.Services.AddScoped<IUserRepository, UserRepository>();
            builder.Services.AddScoped<IUserService, UserService>();
            builder.Services.AddScoped<IUserAuthService, UserAuthService>();
            builder.Services.AddScoped<IDepartmentRepository, DepartmentRepository>();
            builder.Services.AddScoped<IDepartmentService, DepartmentService>();
            builder.Services.AddScoped<IAzureBlobAvatarService, AzureBlobAvatarService>();
            builder.Services.AddScoped<IAzureBlobCheckService, AzureBlobCheckService>();
            builder.Services.AddScoped<ISalaryRepository, SalaryRepository>();
            builder.Services.AddScoped<ISalaryService, SalaryService>();
            builder.Services.AddScoped<ISalaryPaymentRepository, SalaryPaymentRepository>();
            builder.Services.AddScoped<ISalaryPaymentService, SalaryPaymentService>();
            builder.Services.AddScoped<IBonusRepository, BonusRepository>();
            builder.Services.AddScoped<IBonusService, BonusService>();
            builder.Services.AddScoped<IAttendanceRepository, AttendanceRepository>();
            builder.Services.AddScoped<IAttendanceService, AttendanceService>();
            builder.Services.AddScoped<ILeaveRequestRepository, LeaveRequestRepository>();
            builder.Services.AddScoped<ILeaveRequestService, LeaveRequestService>();
            builder.Services.AddScoped<ILeaveBalanceRepository, LeaveBalanceRepository>();
            builder.Services.AddScoped<ILeaveBalanceService, LeaveBalanceService>();
            builder.Services.AddScoped<IReportService, ReportService>();

            builder.Services.AddAutoMapper(typeof(MapperProfile));

            builder.Services.AddSignalR();

            builder.Services.AddHttpContextAccessor();

            builder.Services.AddSingleton<AzureBlobAvatarService>();
            builder.Services.AddSingleton<AzureBlobCheckService>();

            //builder.Services.AddRateLimiter(options =>
            //{
            //    options.GlobalLimiter = PartitionedRateLimiter.Create<HttpContext, string>(context =>
            //        RateLimitPartition.GetFixedWindowLimiter(
            //            context.Connection.RemoteIpAddress?.ToString() ?? "unknown",
            //            key => new FixedWindowRateLimiterOptions
            //            {
            //                PermitLimit = 2,
            //                Window = TimeSpan.FromMinutes(1)
            //            }));
            //});

            builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
                .AddCookie(options =>
                {
                    options.LoginPath = "/Auth/Login";
                    options.LogoutPath = "/Auth/Logout";
                    options.AccessDeniedPath = "/Auth/AccessDenied";
                    options.SlidingExpiration = true;
                    options.ExpireTimeSpan = TimeSpan.FromMinutes(5);
                });

            builder.Services.AddAuthorization();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (!app.Environment.IsDevelopment())
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                //app.UseHsts();
            }

            //app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthentication();

            app.UseAuthorization();

            //app.UseRateLimiter();

            //app.MapGet("/", () => Results.Ok($"Hello world")).RequireRateLimiting("fixed");

            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=Index}/{id?}");
            app.Run();
        }
    }
}
