using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Commons;
using EMS.Data.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;

namespace EMS.Data.Contexts
{
    public partial class SqlServerContext : DbContext
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        public SqlServerContext(DbContextOptions<SqlServerContext> options, IHttpContextAccessor httpContextAccessor) : base(options)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public virtual DbSet<ActivityLog> ActivityLogs { get; set; }
        public virtual DbSet<Attendance> Attendances { get; set; }
        public virtual DbSet<Bonus> Bonuses { get; set; }
        public virtual DbSet<Department> Departments { get; set; }
        public virtual DbSet<LeaveBalance> LeaveBalances { get; set; }
        public virtual DbSet<LeaveRequest> LeaveRequests { get; set; }
        public virtual DbSet<Notification> Notifications { get; set; }
        public virtual DbSet<NotificationRecipient> NotificationRecipients { get; set; }
        public virtual DbSet<Salary> Salaries { get; set; }
        public virtual DbSet<SalaryPayment> SalaryPayments { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<UserAuth> UserAuths { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Bonus>(entity =>
            {
                entity.Property(b => b.Amount).HasPrecision(18, 2);
            });

            modelBuilder.Entity<Salary>(entity =>
            {
                entity.Property(s => s.Basic).HasPrecision(18, 2);
                entity.Property(s => s.Allowance).HasPrecision(18, 2);
            });

            modelBuilder.Entity<SalaryPayment>(entity =>
            {
                entity.Property(s => s.TotalBonus).HasPrecision(18, 2);
                entity.Property(s => s.TotalPaid).HasPrecision(18, 2);
                entity.Property(s => s.TotalSalary).HasPrecision(18, 2);

                entity.HasOne(s => s.User)
                    .WithMany(s => s.SalaryPayments)
                    .HasForeignKey(s => s.UserId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            modelBuilder.Entity<UserAuth>(entity =>
            {
                entity.HasOne(ua => ua.User)
                    .WithOne()
                    .HasForeignKey<UserAuth>(ua => ua.UserId)
                    .OnDelete(DeleteBehavior.Cascade);
                entity.Property(ua => ua.Username).IsRequired();
                entity.Property(ua => ua.PasswordHash).IsRequired();
                entity.HasKey(ua => ua.UserId);
            });

            OnModelCreatingPartial(modelBuilder);
        }   

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);


        public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            UpdateAuditFields();
            return await base.SaveChangesAsync(cancellationToken);
        }

        private void UpdateAuditFields()
        {
            ChangeTracker.DetectChanges();
            var userId = long.Parse(_httpContextAccessor.HttpContext?.User?.FindFirst(ClaimTypes.NameIdentifier)?.Value);
            var entries = ChangeTracker.Entries().ToList();

            foreach (var entry in entries)
            {
                dynamic entity = entry.Entity;
                if (entry.State == EntityState.Detached || entry.State == EntityState.Unchanged || !(entity is BaseEntity<long>))
                {
                    continue;
                }

                if (entry.State == EntityState.Added)
                {
                    entity.CreatedAt = DateTime.Now;
                    entity.CreatedBy = userId;
                }
                else if (entry.State == EntityState.Modified)
                {
                    entity.UpdatedAt = DateTime.Now;
                    entity.UpdatedBy = userId;
                } 
                else if (entry.State == EntityState.Deleted)
                {
                    entity.DeletedAt = DateTime.Now;
                    entity.DeletedBy = userId;
                }
            }
        }
    }
}
