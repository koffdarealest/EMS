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
    public class BonusRepository : IBonusRepository
    {
        private readonly SqlServerContext _context;

        public BonusRepository(SqlServerContext context)
        {
            _context = context;
        }

        public async Task<Bonus> CreateBonusAsync(Bonus bonus)
        {
            _context.Bonuses.Add(bonus);
            await _context.SaveChangesAsync();
            return bonus;
        }

        public async Task<Bonus> GetBonusByIdAsync(long id)
        {
            return await _context.Bonuses
                .Include(b => b.User)
                .Where(b => b.IsPenalty == false)
                .FirstOrDefaultAsync(b => b.Id == id);
        }

        public async Task<Bonus> UpdateBonusAsync(Bonus bonus)
        {
            var bonusEntity = await _context.Bonuses.FindAsync(bonus.Id);
            if (bonusEntity == null)
            {
                return null;
            }

            _context.Entry(bonusEntity).CurrentValues.SetValues(bonus);

            _context.Entry(bonusEntity).Property(b => b.CreatedAt).IsModified = false;
            _context.Entry(bonusEntity).Property(b => b.CreatedBy).IsModified = false;
            _context.Entry(bonusEntity).Property(b => b.DeletedAt).IsModified = false;
            _context.Entry(bonusEntity).Property(b => b.DeletedBy).IsModified = false;
            _context.Entry(bonusEntity).Property(b => b.IsDeleted).IsModified = false;

            await _context.SaveChangesAsync();
            return bonusEntity;
        }

        public async Task<Bonus> DeleteBonusByIdAsync(long id, long? deletedBy)
        {
            var bonus = await _context.Bonuses.FindAsync(id);
            if (bonus == null)
            {
                return null;
            }

            bonus.IsDeleted = true;
            bonus.DeletedAt = DateTime.Now;
            bonus.DeletedBy = deletedBy;
            var bonusUpdated = _context.Bonuses.Update(bonus);
            await _context.SaveChangesAsync();
            return bonusUpdated.Entity;
        }

        public async Task<List<Bonus>> GetBonusesByListUserId(List<long> selectedUsers)
        {
            return await _context.Bonuses
                //.Include(b => b.User)
                .Where(b => selectedUsers.Contains(b.UserId) && b.IsDeleted == false)
                .ToListAsync();
        }
    }
}
