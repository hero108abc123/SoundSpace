import 'package:soundspace/core/common/entities/user.dart';

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

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    int? age,
    String? gender,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
    );
  }
}
