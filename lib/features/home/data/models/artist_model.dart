import 'package:json_annotation/json_annotation.dart';
import 'package:soundspace/features/home/domain/entitites/artist.dart';

part 'artist_model.g.dart';

@JsonSerializable()
class ArtistModel extends Artist {
  ArtistModel({
    required super.id,
    required super.displayName,
    required super.image,
    required super.followersCount,
    required super.followingCount,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtistModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
