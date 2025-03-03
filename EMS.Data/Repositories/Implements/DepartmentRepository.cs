using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Contexts;
using EMS.Data.Entities;
using Microsoft.EntityFrameworkCore;

namespace EMS.Data.Repositories.Implements
{
    public class DepartmentRepository : IDepartmentRepository
    {
        private readonly SqlServerContext _context;

        public DepartmentRepository(SqlServerContext context)
        {
            _context = context;
        }

        public async Task<ICollection<Department>> GetDepartmentsAsync()
        {
            return await _context.Departments.ToListAsync();
        }

        public async Task<Department> CreateDepartmentAsync(Department department)
        {
            _context.Departments.Add(department);
            await _context.SaveChangesAsync();
            return department;
        }

        public async Task<bool> IsExistDepartmentName(string name)
        {
            return await _context.Departments.AnyAsync(x => x.Name == name);
        }

        public async Task<Department> GetDepartmentByIdAsync(int id)
        {
            return await _context.Departments
                .Include(d => d.Users)
                .FirstOrDefaultAsync(x => x.Id == id);
        }
    }
}
