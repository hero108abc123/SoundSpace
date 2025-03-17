class Profile {
  final int id;
  final String displayName;
  final int age;
  final String gender;
  final String? image;
  final int followersCount;
  final int followingCount;

  Profile(
      {required this.id,
      required this.displayName,
      required this.age,
      required this.gender,
      required this.image,
      required this.followersCount,
      required this.followingCount});
}
