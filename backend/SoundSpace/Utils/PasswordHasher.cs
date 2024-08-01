using System.Security.Cryptography;
using System.Text;

namespace SoundSpace.Utils
{
    public static class PasswordHasher
    {
        public static string HashPassword(string password)
        {
            byte[] salt = new byte[16];
            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] passwordBytes = Encoding.UTF8.GetBytes(password);
                byte[] saltPassword = new byte[passwordBytes.Length + salt.Length];
                Array.Copy(passwordBytes, saltPassword, passwordBytes.Length);
                Array.Copy(salt, 0, saltPassword, passwordBytes.Length, salt.Length);

                byte[] hashBytes = sha256.ComputeHash(saltPassword);

                byte[] saltedHash = new byte[salt.Length + hashBytes.Length];
                Array.Copy(salt, saltedHash, salt.Length);
                Array.Copy(hashBytes, 0, saltedHash, salt.Length, hashBytes.Length);

                string hashBase64 = Convert.ToBase64String(saltedHash);

                return hashBase64;

            }
        }

        public static bool VerifyPassword(string password, string hashedPassword)
        {
            byte[] saltedHash = Convert.FromBase64String(hashedPassword);

            byte[] salt = new byte[16];
            Array.Copy(saltedHash, salt, salt.Length);

            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] passwordBytes = Encoding.UTF8.GetBytes(password);
                byte[] saltedPassword = new byte[passwordBytes.Length + salt.Length];
                Array.Copy(passwordBytes, saltedPassword, passwordBytes.Length);
                Array.Copy(salt, 0, saltedPassword, passwordBytes.Length, salt.Length);

                byte[] hashBytes = sha256.ComputeHash(saltedPassword);

                for (int i = 0; i < hashBytes.Length; i++)
                {
                    if (hashBytes[i] != saltedHash[i + salt.Length])
                    {
                        return false;
                    }
                }

                return true;
            }
        }
    }
}
