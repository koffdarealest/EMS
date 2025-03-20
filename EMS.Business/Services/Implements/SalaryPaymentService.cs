using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Business.Dtos;
using EMS.Business.Exceptions;
using EMS.Data.Entities;
using EMS.Data.Enums;
using EMS.Data.Repositories;

namespace EMS.Business.Services.Implements
{
    public class SalaryPaymentService : ISalaryPaymentService
    {
        private readonly ISalaryPaymentRepository _salaryPaymentRepository;
        private readonly IMapper _mapper;
        private readonly IUserRepository _userRepository;

        public SalaryPaymentService(ISalaryPaymentRepository salaryPaymentRepository, IMapper mapper, IUserRepository userRepository)
        {
            _salaryPaymentRepository = salaryPaymentRepository;
            _mapper = mapper;
            _userRepository = userRepository;
        }

        public async Task<List<SalaryPaymentDto>> CreatePaymentsByListUserIdAsync(List<long> selectedUsers)
        {
            var users = await _userRepository.GetUsersByIds(selectedUsers);
            //Dictionary<long, decimal> dicSalary = new Dictionary<long, decimal>();
            //Dictionary<long, decimal> dicBonus = new Dictionary<long, decimal>();
            List<SalaryPaymentDto> salaryPayments = new List<SalaryPaymentDto>();

            foreach (var u in users)
            {
                if (u.SalaryPayments.Any(s => s.CreatedAt.Value.Month == DateTime.Today.Month && s.CreatedAt.Value.Year == DateTime.Today.Year))
                {
                    continue;
                }

                var activeSalary = u.Salaries
                    .Where(s => s.EffectiveAt <= DateTime.Today && s.IsDeleted == false)
                    .OrderByDescending(s => s.EffectiveAt)
                    .FirstOrDefault();

                if (activeSalary == null)
                {
                    continue;
                }

                var workedDays = u.Attendances
                    .Where(a => 
                        a.CheckIn.Value.Month == DateTime.Today.Month && 
                        a.CheckIn.Value.Year == DateTime.Today.Year && 
                        (a.Status == AttendanceStatus.Present || a.Status == AttendanceStatus.Leave))
                    .Count();
                var totalSalary = activeSalary.Basic * workedDays + activeSalary.Allowance;
                //dicSalary.Add(u.Id, salary);

                var bonuses = u.Bonuses
                    .Where(b => b.IsDeleted && b.CreatedAt.Value.Month == DateTime.Today.Month &&
                                b.CreatedAt.Value.Year == DateTime.Today.Year)
                    .ToList();
                decimal totalBonus = 0;
                decimal totalPenalty = 0;
                decimal totalPaid;
                if (bonuses.Any())
                {
                    foreach (var b in bonuses)
                    {
                        if (!b.IsPenalty)
                        {
                            totalBonus += b.Amount;
                        }
                        else
                        {
                            totalPenalty += b.Amount;
                        }
                    }
                    //dicBonus.Add(u.Id, totalBonus);
                }

                if (totalSalary - totalPenalty + totalBonus > 0)
                {
                    totalPaid = totalSalary - totalPenalty + totalBonus;
                }
                else
                {
                    totalPaid = 0;
                }

                var salaryPayment = new SalaryPaymentDto
                {
                    TotalSalary = totalSalary,
                    TotalBonus = totalBonus,
                    TotalPenalty = totalPenalty,
                    TotalPaid = totalPaid,
                    UserId = u.Id,
                    Status = PaymentStatus.Pending,
                };
                salaryPayments.Add(salaryPayment);
            }
            var salaryPaymentsCreated = await _salaryPaymentRepository.CreateAsync(_mapper.Map<List<SalaryPayment>>(salaryPayments));
            return _mapper.Map<List<SalaryPaymentDto>>(salaryPaymentsCreated);
        }

        public async Task<List<SalaryPaymentDto>> GetSalaryPaymentsByThisMonthAsync(DateTime selectedTime)
        {
            var salaryPayments = await _salaryPaymentRepository.GetSalaryPaymentsByThisMonth(selectedTime);
            return _mapper.Map<List<SalaryPaymentDto>>(salaryPayments);
        }

        public async Task<SalaryPaymentDto> UpdateStatusAsync(long id, string status)
        {
            var salaryPayment = await _salaryPaymentRepository.UpdateAsync(id, status);
            return _mapper.Map<SalaryPaymentDto>(salaryPayment);
        }
    }
}
