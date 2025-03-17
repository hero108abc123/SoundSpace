// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      id: (json['id'] as num).toInt(),
      displayName: json['displayName'] as String,
      age: (json['age'] as num).toInt(),
      gender: json['gender'] as String,
      image: json['image'] as String?,
      followersCount: (json['followersCount'] as num).toInt(),
      followingCount: (json['followingCount'] as num).toInt(),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'age': instance.age,
      'gender': instance.gender,
      'image': instance.image,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
    };
