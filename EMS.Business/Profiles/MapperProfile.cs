using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Business.Dtos;
using EMS.Data.Entities;

namespace EMS.Business.Profiles
{
    public class MapperProfile : Profile
    {
        public MapperProfile()
        {
            CreateMap<User, UserDto>();
            CreateMap<UserDto, User>();
            CreateMap<Department, DepartmentDto>();
            CreateMap<DepartmentDto, Department>();
            CreateMap<Salary, SalaryDto>();
            CreateMap<SalaryDto, Salary>();
            CreateMap<Bonus, BonusDto>();
            CreateMap<BonusDto, Bonus>();
            CreateMap<SalaryPayment, SalaryPaymentDto>();
            CreateMap<SalaryPaymentDto, SalaryPayment>();
            CreateMap<Attendance, AttendanceDto>();
            CreateMap<AttendanceDto, Attendance>();
            CreateMap<LeaveBalance, LeaveBalanceDto>();
            CreateMap<LeaveBalanceDto, LeaveBalance>();
            CreateMap<LeaveRequest, LeaveRequestDto>();
            CreateMap<LeaveRequestDto, LeaveRequest>()
                .AfterMap((src, dest) => dest.UpdateTotalDays());
        }
    }
}
