// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistModel _$ArtistModelFromJson(Map<String, dynamic> json) => ArtistModel(
      id: json['id'] as int,
      displayName: json['displayName'] as String,
      image: json['image'] as String,
      followersCount: json['followersCount'] as int,
      followingCount: json['followingCount'] as int,
    );

Map<String, dynamic> _$ArtistModelToJson(ArtistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'image': instance.image,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
    };
