using System.Collections.Generic;
using Sabio.Models;
using Sabio.Models.Domain.Business;
using Sabio.Models.Requests.BusinessVentures;
using Sabio.Models.Domain;

namespace Sabio.Services
{
    public interface IBusinessVenturesServices
    {
        #region CRUD
        int Add(BusinessVenturesAddRequest model);
        void Update(BusinessVenturesUpdateRequest model);
        Business Get(int id);
        Business GetByUserId(int userId);
        List<Business> Get();
        void Delete(int id);
        #endregion

        #region Pagination/Search
        Paged<Business> GetAllByPagination(int pageIndex, int pageSize);
        Paged<Business> SearchPagination(int pageIndex, int pageSize, string query);
        #endregion

        #region Business/Status/Industry Types
        List<BusinessType> GetBusinessTypes();
        List<Status> GetBusinessesStatus();
        List<IndustryType> GetIndustryType();
        #endregion

        #region Year Count
        List<BusinessTypesTotalCountByYear> GetBusinessTotalCountsByYear(int year);
        #endregion
    }
}