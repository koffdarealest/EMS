using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Contexts;

namespace EMS.Data.Repositories.Implements
{
    public class SalaryPaymentRepository : ISalaryPaymentRepository
    {
        private readonly SqlServerContext _context;

        public SalaryPaymentRepository(SqlServerContext context)
        {
            _context = context;
        }
    }
}
