using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EMS.Business.Dtos;

namespace EMS.Business.Services
{
    public interface IBonusService
    {
        Task<BonusDto> CreateBonusAsync(BonusDto bonusDto);
        Task<BonusDto> DeleteBonusAsync(long value, long? deletedBy);
        Task<BonusDto> GetBonusByIdAsync(long id);
        Task<BonusDto> UpdateBonusAsync(BonusDto bonusDto);
    }
}
