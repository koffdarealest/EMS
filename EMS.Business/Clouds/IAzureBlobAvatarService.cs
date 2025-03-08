using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Clouds
{
    public interface IAzureBlobAvatarService
    {
        Task<string> UploadAvatarAsync(Stream fileStream, string fileName);
    }
}
