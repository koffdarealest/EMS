using EMS.Data.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Data.Repositories
{
    public interface IBonusRepository
    {
        Task<Bonus> CreateBonusAsync(Bonus bonus);
        Task<Bonus> DeleteBonusByIdAsync(long value, long? deletedBy);
        Task<Bonus> GetBonusByIdAsync(long id);
        Task<List<Bonus>> GetBonusesByListUserId(List<long> selectedUsers);
        Task<Bonus> UpdateBonusAsync(Bonus bonus);
    }
}
