﻿using System.ComponentModel.DataAnnotations;

namespace SoundSpace.Dtos.Auth.UserDtos
{
    public class CreateUserDto
    {
        private string _displayName;

        [Required]
        [StringLength(30, ErrorMessage = "Display name must be between 3 and 30 characters long.", MinimumLength = 3)]
        public string DisplayName
        {
            get => _displayName;
            set => _displayName = value?.Trim();
        }

        [Required]
        public int Age { get; set; }

        private string _gender;
        [Required]
        [StringLength(30, MinimumLength = 3)]
        public string Gender 
        { 
            get => _gender; 
            set => _gender = value?.Trim(); 
        }
        public IFormFile? Image { get; set; }

    }
}
