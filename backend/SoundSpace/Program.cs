using System.IdentityModel.Tokens.Jwt;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.FileProviders;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using SoundSpace.Dbcontexts;
using SoundSpace.Services.Implements.Auth;
using SoundSpace.Services.Implements.Product;
using SoundSpace.Services.Interfaces.Auth;
using SoundSpace.Services.Interfaces.Product;
using SoundSpace.Utils;




namespace SoundSpace
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = Microsoft.AspNetCore.Builder.WebApplication.CreateBuilder(args);
            ConfigurationManager configuration = builder.Configuration;

            // Add services to the container.
            builder.Services.AddDbContext<ApplicationDbContext>(options =>
            {
                options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));        
            }, ServiceLifetime.Scoped);

            builder.Services.AddScoped<ApplicationDbContext>();

            builder
                .Services.AddAuthentication(options =>
                {
                    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme; 
                    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                    options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
                })
                .AddJwtBearer(options =>
                {
                    options.SaveToken = true;
                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidAudience = builder.Configuration["JWT:ValidAudience"],
                        ValidIssuer = builder.Configuration["JWT:ValidIssuer"],
                        ValidateAudience = false,
                        ValidateIssuer = false,
                        ValidateLifetime = true,
                        ValidateIssuerSigningKey = true,
                        IssuerSigningKey = new SymmetricSecurityKey(
                            Encoding.UTF8.GetBytes(builder.Configuration["JWT:Secret"])
                        ),
                        ClockSkew = TimeSpan.Zero
                    };
                    options.RequireHttpsMetadata = false;
                });

            builder.Services.AddHttpContextAccessor();
            builder.Services.AddControllers();
            builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Version = "v1", Title = "Web API" });
                c.AddSecurityDefinition(
                    JwtBearerDefaults.AuthenticationScheme,
                    new OpenApiSecurityScheme
                    {
                        Description =
                            "JWT Authorization header using the Bearer scheme. Example: \"Authorization: Bearer {token}\"",
                        Name = "Authorization",
                        BearerFormat = "JWT",
                        In = ParameterLocation.Header,
                        Type = SecuritySchemeType.ApiKey
                    }
                );

                c.AddSecurityRequirement(
                    new OpenApiSecurityRequirement
                    {
                        {
                            new OpenApiSecurityScheme
                            {
                                Reference = new OpenApiReference
                                {
                                    Type = ReferenceType.SecurityScheme,
                                    Id = "Bearer"
                                }
                            },
                            new string[] { }
                        }
                    }
                );
            });

            builder.Services.AddScoped<IAuthService, AuthService>();
            builder.Services.AddScoped<IUserService, UserService>();
            builder.Services.AddScoped<IUserFollowService, UserFollowService>();
            builder.Services.AddScoped<ITrackService, TrackService>();
            builder.Services.AddScoped<IPlaylistService, PlaylistService>();
            builder.Services.AddScoped<IPlaylistFollowService, PlaylistFollowService>();
            builder.Services.AddScoped<ITrackPlaylistService, TrackPlaylistService>();
            builder.Services.AddScoped<IFavoriteTrackService, FavoriteTrackService>();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }
            app.UseStaticFiles(new StaticFileOptions
            {
                FileProvider = new PhysicalFileProvider(
                Path.Combine(Directory.GetCurrentDirectory(),"Users")),
                RequestPath = "/Users"
            });
            app.UseStaticFiles(new StaticFileOptions
            {
                FileProvider = new PhysicalFileProvider(
                Path.Combine(Directory.GetCurrentDirectory(), "Tracks")),
                RequestPath = "/Tracks"
            });

            app.UseHttpsRedirection();

            app.UseAuthentication();
            app.UseAuthorization();

            app.UseMiddleware<TokenRevocationMiddleware>();


            app.MapControllers();

            app.Run();

        }
    }
}