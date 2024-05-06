import 'package:json_annotation/json_annotation.dart';
import 'package:soundspace/core/common/entities/user.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.displayName,
    required super.age,
    required super.gender,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
