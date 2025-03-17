import 'package:json_annotation/json_annotation.dart';
import 'package:soundspace/features/home/domain/entitites/playlist.dart';

part 'playlist_model.g.dart';

@JsonSerializable()
class PlaylistModel extends Playlist {
  PlaylistModel({
    required super.id,
    required super.title,
    required super.image,
    required super.follower,
    required super.createBy,
    required super.trackCount,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) =>
      _$PlaylistModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
