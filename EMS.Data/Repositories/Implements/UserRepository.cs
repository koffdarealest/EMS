using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Contexts;
using EMS.Data.Entities;
using EMS.Data.Enums;
using EMS.Data.Pagination;
using Microsoft.EntityFrameworkCore;

namespace EMS.Data.Repositories.Implements
{
    public class UserRepository : IUserRepository
    {
        private readonly SqlServerContext _context;

        public UserRepository(SqlServerContext context)
        {
            _context = context;
        }

        public async Task<PaginatedList<User>> GetUsersAsync(string searchTerm, int? departmentId, int? gender, DateOnly? joinDate, int pageIndex, int pageSize)
        {
            IQueryable<User> query = _context.Users
                .Include(u => u.Department)
                .Where(u => u.IsDeleted == false && u.Role != Role.Admin)
                .OrderBy(u => u.Fullname)
                .AsNoTracking();

            if (!string.IsNullOrEmpty(searchTerm))
            {
                query = query.Where(u => 
                    u.Fullname.Contains(searchTerm) ||
                    u.Department.Name.Contains(searchTerm)
                    );
            }

            if (departmentId.HasValue)
            {
                query = query.Where(u => u.DepartmentId == departmentId);
            }

            if (gender.HasValue)
            {
                query = query.Where(u => u.Gender == (Gender) gender.Value);
            }

            if (joinDate.HasValue)
            {
                query = query.Where(u => u.JoinedAt >= joinDate.Value);
            }

            return await PaginatedList<User>.CreateAsync(query, pageIndex, pageSize);
        }

        public async Task<User> CreateUserAsync(User user)
        {
            var userCreated = await _context.Users.AddAsync(user);
            await _context.SaveChangesAsync();
            return userCreated.Entity;

        }

        public async Task<User> UpdateUserAsync(User user)
        {
            var userExist = await _context.Users.FindAsync(user.Id);
            if (userExist == null)
            {
                return null;
            }
            _context.Entry(userExist).CurrentValues.SetValues(user);

            _context.Entry(userExist).Property(x => x.CreatedAt).IsModified = false;
            _context.Entry(userExist).Property(x => x.CreatedBy).IsModified = false;
            _context.Entry(userExist).Property(x => x.DeletedAt).IsModified = false;
            _context.Entry(userExist).Property(x => x.DeletedBy).IsModified = false;
            _context.Entry(userExist).Property(x => x.IsDeleted).IsModified = false;
            //var userUpdated = _context.Users.Update(user);
            await _context.SaveChangesAsync();
            return userExist;
        }

        public async Task<User> DeleteUserAsync(long userId)
        {
            var user = await _context.Users.FindAsync(userId);
            if (user == null)
            {
                return null;
            }
            else
            {
                user.IsDeleted = true;
                user.DeletedAt = DateTime.Now;
                var userUpdated = _context.Users.Update(user);
                await _context.SaveChangesAsync();
                return userUpdated.Entity;
            }
        }

        public async Task<User> DeleteUserAsync(long userId, long deletedBy)
        {
            var user = await _context.Users.FindAsync(userId);
            if (user == null)
            {
                return null;
            }
            else
            {
                user.IsDeleted = true;
                user.DeletedAt = DateTime.Now;
                user.DeletedBy = deletedBy;
                var userUpdated = _context.Users.Update(user);
                await _context.SaveChangesAsync();
                return userUpdated.Entity;
            }
        }

        public async Task<ICollection<User>> GetEmployeesAsync(params Expression<Func<User, object>>[] includes)
        {
            IQueryable<User> queryable = _context.Users
                .Where(u => u.IsDeleted == false && u.Role != Role.Admin);

            foreach (var include in includes)
            {
                queryable = queryable.Include(include);
            }
            return await queryable.ToListAsync();
        }

        public async Task<User> GetUserByIdAsync(long userId, params Expression<Func<User, object>>[] includes)
        {
            IQueryable<User> query = _context.Users
                .Where(u => u.Id == userId && u.IsDeleted == false);

            foreach (var include in includes)
            {
                query = query.Include(include);
            }

            return await query.FirstOrDefaultAsync();
        }

        public async Task<ICollection<User>> GetUsersByIds(List<long> selectedUsers)
        {
            return await _context.Users
                .Include(u => u.Salaries)
                .Include(u => u.Bonuses)
                .Include(u => u.Attendances)
                .Include(u => u.SalaryPayments)
                .Where(u => selectedUsers.Contains(u.Id) && u.IsDeleted == false)
                .ToListAsync();
        }

        public async Task<ICollection<User>> GetUsersAsync()
        {
            return await _context.Users
                .Where(u => u.IsDeleted == false)
                .ToListAsync();
        }

        public IQueryable<User> GetQueryableUsers()
        {
            return _context.Users
                .Where(u => u.IsDeleted == false)
                .AsNoTracking();
        }

        public async Task<List<long>> GetUserIdsAsync()
        {
            return await _context.Users
                .Where(u => u.IsDeleted == false && u.Role != Role.Admin)
                .Select(u => u.Id)
                .ToListAsync();
        }

        public async Task<List<long>> GetUserIdsByDepartmentIdAsync(long departmentId)
        {
            return await _context.Users
                .Where(u => u.DepartmentId == departmentId && u.IsDeleted == false && u.Role != Role.Admin)
                .Select(u => u.Id)
                .ToListAsync();
        }
    }
}
