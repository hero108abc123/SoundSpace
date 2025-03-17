using SoundSpace.Exceptions;

namespace SoundSpace.Utils
{
    public static class UploadFile
    {
        public static async Task<string> SaveFileAsync(IFormFile file, string entityFolder, string subFolder)
        {
            if (file == null || file.Length == 0)
            {
                throw new UserFriendlyException("File không hợp lệ!");
            }

            var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), entityFolder, subFolder);
            if (!Directory.Exists(uploadsFolder))
            {
                Directory.CreateDirectory(uploadsFolder);
            }

            var fileName = $"{Guid.NewGuid()}{Path.GetExtension(file.FileName)}";
            var filePath = Path.Combine(uploadsFolder, fileName);

            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await file.CopyToAsync(stream);
            }

            return $"/{entityFolder}/{subFolder}/{fileName}"; // Trả về đường dẫn tương đối
        }

        public static string GetFileUrl(string relativePath, IHttpContextAccessor httpContextAccessor)
        {
            if (string.IsNullOrEmpty(relativePath))
            {
                return null;
            }

            var request = httpContextAccessor.HttpContext?.Request;
            if (request == null)
            {
                throw new UserFriendlyException("Cannot generate file URL without HTTP context");
            }

            var baseUrl = $"{request.Scheme}://{request.Host}";
            return $"{baseUrl}{relativePath}";
        }

        public static void DeleteFile(string relativePath, string entityFolder, string subFolder)
        {
            if (!string.IsNullOrEmpty(relativePath))
            {
                var rootPath = Path.Combine(Directory.GetCurrentDirectory(), entityFolder, subFolder);
                var fullPath = Path.Combine(rootPath, relativePath);
                if (System.IO.File.Exists(fullPath))
                {
                    System.IO.File.Delete(fullPath);
                }
            }
        }

    }
}
