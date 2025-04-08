// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackModel _$TrackModelFromJson(Map<String, dynamic> json) => TrackModel(
      trackId: (json['trackId'] as num).toInt(),
      title: json['title'] as String,
      album: json['album'] as String,
      artist: json['artist'] as String,
      source: json['source'] as String,
      image: json['image'] as String,
      favorite: (json['favorite'] as num).toInt(),
      lyric: json['lyric'] as String,
    );

Map<String, dynamic> _$TrackModelToJson(TrackModel instance) =>
    <String, dynamic>{
      'trackId': instance.trackId,
      'title': instance.title,
      'artist': instance.artist,
      'image': instance.image,
      'source': instance.source,
      'album': instance.album,
      'favorite': instance.favorite,
      'lyric': instance.lyric,
    };
