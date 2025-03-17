using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Contexts;
using EMS.Data.Entities;
using Microsoft.EntityFrameworkCore;

namespace EMS.Data.Repositories.Implements
{
    public class SalaryRepository : ISalaryRepository
    {
        private readonly SqlServerContext _context;

        public SalaryRepository(SqlServerContext context)
        {
            _context = context;
        }

        public async Task<ICollection<Salary>> GetSalariesAsync()
        {
            return await _context.Salaries
                .Include(s => s.User)
                .Where(s => s.IsDeleted == false)
                .ToListAsync();
        }

        public async Task<Salary> CreateSalaryAsync(Salary salary)
        {
            _context.Salaries.Add(salary);
            await _context.SaveChangesAsync();
            return salary;
        }

        public async Task<Salary> GetSalaryByIdAsync(long id, Expression<Func<Salary, object>>[] includes)
        {
            var query = _context.Salaries
                .Where(s => s.Id == id && s.IsDeleted == false);
            foreach (var include in includes)
            {
                query = query.Include(include);
            }

            return await query.FirstOrDefaultAsync(s => s.Id == id);
        }

        public async Task<Salary> UpdateSalaryAsync(Salary salary)
        {
            var salaryEntity = await _context.Salaries.FindAsync(salary.Id);
            if (salaryEntity == null)
            {
                return null;
            }

            _context.Entry(salaryEntity).CurrentValues.SetValues(salary);

            _context.Entry(salaryEntity).Property(s => s.CreatedAt).IsModified = false;
            _context.Entry(salaryEntity).Property(s => s.CreatedBy).IsModified = false;
            _context.Entry(salaryEntity).Property(s => s.DeletedAt).IsModified = false;
            _context.Entry(salaryEntity).Property(s => s.DeletedBy).IsModified = false;
            _context.Entry(salaryEntity).Property(s => s.IsDeleted).IsModified = false;

            await _context.SaveChangesAsync();
            return salaryEntity;
        }

        public async Task<Salary> DeleteSalaryAsync(long value, long? deletedBy)
        {
            var salary = await _context.Salaries.FindAsync(value);
            if (salary == null)
            {
                return null;
            }

            salary.IsDeleted = true;
            salary.DeletedAt = DateTime.Now;
            salary.DeletedBy = deletedBy;
            var salaryUpdated = _context.Salaries.Update(salary);
            await _context.SaveChangesAsync();
            return salaryUpdated.Entity;
        }

        public async Task<List<Salary>> GetSalariesByListUserId(List<long> selectedUsers)
        {
            return await _context.Salaries
                //.Include(s => s.User)
                .Where(s => selectedUsers.Contains(s.UserId) && s.IsDeleted == false)
                .ToListAsync();
        }
    }
}
