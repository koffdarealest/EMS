using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Data.Commons;
using EMS.Data.Enums;

namespace EMS.Data.Entities
{
    public class SalaryPayment : BaseEntity<long>
    {
        public decimal TotalSalary { get; set; }
        public decimal TotalBonus { get; set; }
        public decimal TotalPenalty { get; set; }
        public decimal TotalPaid { get; set; }
        public DateTime? PaidAt { get; set; }
        public PaymentStatus Status { get; set; }
        public long? UserId { get; set; }
        public virtual User? User { get; set; }
    }
    
}
