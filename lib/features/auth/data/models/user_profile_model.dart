import 'package:json_annotation/json_annotation.dart';

import '../../../../core/common/entities/user_profile.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends Profile {
  ProfileModel({
    required super.id,
    required super.displayName,
    required super.age,
    required super.gender,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return _$ProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
