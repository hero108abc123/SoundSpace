namespace SoundSpace.Dtos.Auth.UserDtos
{
    public class UserDto
    {
        public int Id { get; set; }

        public string DisplayName { get; set; }

        public int Age { get; set; }

        public string Gender { get; set; }

        public string Image { get; set; }

        public int FollowersCount { get; set; }  // Số người theo dõi
        public int FollowingCount { get; set; }  // Số người đang theo dõi
    }
}
 