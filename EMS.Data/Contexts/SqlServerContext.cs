using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Entities;
using Microsoft.EntityFrameworkCore;

namespace EMS.Data.Contexts
{
    public partial class SqlServerContext : DbContext
    {
        public SqlServerContext(DbContextOptions<SqlServerContext> options) : base(options)
        {
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
    }
}
