import 'package:soundspace/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.displayName,
    required super.age,
    required super.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      age: map['age'] ?? '',
      gender: map['gender'] ?? '',
    );
  }
}
