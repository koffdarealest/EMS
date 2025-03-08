using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EMS.Business.Clouds
{
    public interface IAzureBlobCheckService
    {
        Task<string> UploadCheckPhotoAsync(Stream fileStream, string fileName);
    }
}
