﻿using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Files;

namespace Sabio.Services.Interfaces
{
    public interface IFileService
    {
        int Add(FileAddRequest model, int userId);

        void Update(FileUpdateRequest model, int userId);

        FileUpload Get(int id);

        List<FileUpload> Get();

        Paged<FileUpload> GetPaginated(int pageIndex, int pageSize);

        Paged<FileUpload> SearchPaginated(int pageIndex, int pageSize, string query);

        void Delete(int Id);

        Task<string> UploadFile(IFormFile file, int id);
    }
}