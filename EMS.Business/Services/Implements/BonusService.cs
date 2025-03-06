using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using EMS.Business.Dtos;
using EMS.Data.Entities;
using EMS.Data.Repositories;

namespace EMS.Business.Services.Implements
{
    public class BonusService : IBonusService
    {
        private readonly IBonusRepository _bonusRepository;
        private readonly IMapper _mapper;

        public BonusService(IBonusRepository bonusRepository, IMapper mapper)
        {
            _bonusRepository = bonusRepository;
            _mapper = mapper;
        }

        public async Task<BonusDto> CreateBonusAsync(BonusDto bonusDto)
        {
            var bonus = _mapper.Map<Bonus>(bonusDto);
            bonus = await _bonusRepository.CreateBonusAsync(bonus);
            return _mapper.Map<BonusDto>(bonus);
        }

        public async Task<BonusDto> GetBonusByIdAsync(long id)
        {
            var bonus = await _bonusRepository.GetBonusByIdAsync(id);
            return _mapper.Map<BonusDto>(bonus);
        }

        public async Task<BonusDto> UpdateBonusAsync(BonusDto bonusDto)
        {
            var bonus = _mapper.Map<Bonus>(bonusDto);
            bonus = await _bonusRepository.UpdateBonusAsync(bonus);
            return _mapper.Map<BonusDto>(bonus);
        }

        public async Task<BonusDto> DeleteBonusAsync(long value, long? deletedBy)
        {
            if (!deletedBy.HasValue)
            {
                throw new ArgumentNullException(nameof(deletedBy));
            }
            var bonus = await _bonusRepository.DeleteBonusByIdAsync(value, deletedBy);
            return _mapper.Map<BonusDto>(bonus);
        }
    }
}
