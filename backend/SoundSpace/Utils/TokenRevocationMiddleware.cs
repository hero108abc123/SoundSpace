using Microsoft.EntityFrameworkCore;
using SoundSpace.Dbcontexts;

namespace SoundSpace.Utils
{
    public class TokenRevocationMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly IServiceScopeFactory _scopeFactory;

        public TokenRevocationMiddleware(RequestDelegate next, IServiceScopeFactory scopeFactory)
        {
            _next = next;
            _scopeFactory = scopeFactory;
        }

        public async Task Invoke(HttpContext context)
        {
            var token = context.Request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();

            if (!string.IsNullOrEmpty(token))
            {
                using var scope = _scopeFactory.CreateScope();
                var dbContext = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();

                var revokedToken = await dbContext.RevokedTokens.FirstOrDefaultAsync(rt => rt.Token == token);
                if (revokedToken != null)
                {
                    context.Response.StatusCode = StatusCodes.Status401Unauthorized;
                    await context.Response.WriteAsync("Token has been revoked.");
                    return;
                }
            }

            await _next(context);
        }
    }
}
