using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Sabio.Models;
using Sabio.Services;
using Sabio.Web.Controllers;
using Sabio.Web.Core;
using Sabio.Web.Models.Responses;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/auth")]
    [ApiController]
    public class AuthApiController : BaseApiController
    {
        private IUserService _userService;
        private IAuthenticationService<int> _authService;
        IOptions<SecurityConfig> _options;

        public AuthApiController(IUserService userService
            , IAuthenticationService<int> authService
            , ILogger<AuthApiController> logger
            , IOptions<SecurityConfig> options) : base(logger)
        {
            _userService = userService;
            _authService = authService;
            _options = options;
        }

        [HttpGet("current")]
        public ActionResult<ItemResponse<IUserAuthData>> GetCurrrent()
        {
            IUserAuthData user = _authService.GetCurrentUser();
            ItemResponse<IUserAuthData> response = new ItemResponse<IUserAuthData>();
            response.Item = user;

            return Ok200(response);
        }

        [HttpGet("logout")]
        public async Task<ActionResult<SuccessResponse>> LogoutAsync()
        {
            await _authService.LogOutAsync();
            SuccessResponse response = new SuccessResponse();
            return Ok200(response);
        }
    }
}