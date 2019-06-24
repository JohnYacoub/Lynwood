using Sabio.Data.Providers;
using Sabio.Models.Requests;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace Sabio.Services
{
    public class TokensService : ITokensService
    {
        private IDataProvider _dataProvider;

        public TokensService(IDataProvider dataProvider)
        {
            _dataProvider = dataProvider;
        }

        public int Insert(TokensAddRequest model, int tokenTypeId, Guid token, int userId)
        {
            int id = 0;

            _dataProvider.ExecuteNonQuery("dbo.Tokens_Insert", inputParamMapper: delegate (SqlParameterCollection parms)
            {
                SqlParameter parm = new SqlParameter();
                parm.ParameterName = "@Id";
                parm.SqlDbType = SqlDbType.Int;
                parm.Direction = ParameterDirection.Output;
                parms.Add(parm);

                parms.AddWithValue("@TokenType", tokenTypeId);
                parms.AddWithValue("@Token", token);
                parms.AddWithValue("@UserId", userId);

            }, returnParameters: delegate (SqlParameterCollection parms)
            {
                Int32.TryParse(parms["@Id"].Value.ToString(), out id);
            });
            Console.WriteLine("id", id);
            return id;
        }
    }
}
