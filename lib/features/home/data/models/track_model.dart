import 'package:json_annotation/json_annotation.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
part 'track_model.g.dart';

@JsonSerializable()
class TrackModel extends Track {
  TrackModel({
    required super.id,
    required super.title,
    required super.album,
    required super.artist,
    required super.source,
    required super.image,
    required super.duration,
    required super.favorite,
    required super.counter,
    required super.replay,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return _$TrackModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TrackModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
