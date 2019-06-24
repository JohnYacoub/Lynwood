using Microsoft.AspNetCore.Mvc;
using Sabio.Web.Controllers;
using Microsoft.Extensions.Logging;
using Sabio.Web.Models.Responses;
using System;
using Sabio.Services.Interfaces;
using Sabio.Services;
using Sabio.Models.Requests;

namespace Sabio.Web.Api.Controllers
{
    [Route("api/emails")]
    [ApiController]
    public class SendEmailApiController : BaseApiController
    {
        private IEmailService _emailService;

        public SendEmailApiController(IEmailService emailService, ILogger<SendEmailApiController> logger) : base(logger)
        {
            _emailService = emailService;
        }

        [HttpPost("send")]
        public ActionResult<SuccessResponse> SendEmail(EmailSendRequest model)
        {
            try
            {
                _emailService.Send(model);
                SuccessResponse resp = new SuccessResponse();
                return Ok200(resp);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex.ToString());
                return StatusCode(500, new ErrorResponse(ex.Message));
            }
        }
    }
}