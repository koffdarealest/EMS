using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Clouds
{
    public interface IAzureBlobService
    {
        Task<string> UploadAvatarAsync(Stream fileStream, string fileName);
    }
}
