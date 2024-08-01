// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackModel _$TrackModelFromJson(Map<String, dynamic> json) => TrackModel(
      id: json['id'] as String,
      title: json['title'] as String,
      album: json['album'] as String,
      artist: json['artist'] as String,
      source: json['source'] as String,
      image: json['image'] as String,
      duration: json['duration'] as int,
      favorite: json['favorite'] as String,
      counter: json['counter'] as int,
      replay: json['replay'] as int,
    );

Map<String, dynamic> _$TrackModelToJson(TrackModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'album': instance.album,
      'artist': instance.artist,
      'source': instance.source,
      'image': instance.image,
      'duration': instance.duration,
      'favorite': instance.favorite,
      'counter': instance.counter,
      'replay': instance.replay,
    };
