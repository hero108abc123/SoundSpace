import 'package:json_annotation/json_annotation.dart';
import 'package:soundspace/features/home/domain/entitites/track.dart';
part 'track_model.g.dart';

@JsonSerializable()
class TrackModel extends Track {
  TrackModel({
    required super.trackId,
    required super.title,
    required super.album,
    required super.artist,
    required super.source,
    required super.image,
    required super.favorite,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return _$TrackModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TrackModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackModel &&
          runtimeType == other.runtimeType &&
          trackId == other.trackId;

  @override
  int get hashCode => trackId.hashCode;
}
