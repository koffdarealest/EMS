using EMS.Data.Entities;
using EMS.Data.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Commons;

namespace EMS.Business.Dtos
{
    public class SalaryPaymentDto : BaseDto<long>
    {
        public decimal TotalSalary { get; set; }
        public decimal TotalBonus { get; set; }
        public decimal TotalPaid { get; set; }
        public DateTime PaidAt { get; set; }
        public PaymentStatus Status { get; set; }
        public long? UserId { get; set; }
        public UserDto? User { get; set; }
    }
}
