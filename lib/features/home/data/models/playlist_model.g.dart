// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistModel _$PlaylistModelFromJson(Map<String, dynamic> json) =>
    PlaylistModel(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      follower: json['follower'] as int,
      createBy: json['createBy'] as String,
      trackCount: json['trackCount'] as int,
    );

Map<String, dynamic> _$PlaylistModelToJson(PlaylistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'follower': instance.follower,
      'createBy': instance.createBy,
      'trackCount': instance.trackCount,
    };
