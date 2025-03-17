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
    public class SalaryPaymentRepository : ISalaryPaymentRepository
    {
        private readonly SqlServerContext _context;

        public SalaryPaymentRepository(SqlServerContext context)
        {
            _context = context;
        }

        public async Task<List<SalaryPayment>> GetSalaryPaymentsByThisMonth(DateTime selectedTime)
        {
            return await _context.SalaryPayments
                .Where(x => x.CreatedAt.Value.Month == selectedTime.Month && x.CreatedAt.Value.Year == selectedTime.Year)
                .Include(x => x.User)
                .ToListAsync();
        }

        public async Task<List<SalaryPayment>> CreateAsync(List<SalaryPayment> salaryPayments)
        {
            await _context.SalaryPayments.AddRangeAsync(salaryPayments);
            await _context.SaveChangesAsync();
            return salaryPayments;
        }
    }
}
