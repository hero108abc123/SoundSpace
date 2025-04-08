import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soundspace/core/network/constants/endpoints.dart';
import 'package:soundspace/core/network/remote/dio_client.dart';
import 'package:soundspace/features/home/data/models/playlist_model.dart';
import 'package:soundspace/features/home/data/models/track_model.dart';

abstract interface class FavoriteRemoteDataSource {
  Future<List<TrackModel>?> getFavoriteTracks();
  Future<List<PlaylistModel>?> getFollowedPlaylists();
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final DioClient _dio;
  static const storage = FlutterSecureStorage();
  FavoriteRemoteDataSourceImpl(this._dio);

  @override
  Future<List<TrackModel>?> getFavoriteTracks() async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.track}/get-favorite-tracks",
        options: Options(headers: {
          "accept": "application/json; charset=utf-8",
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> trackList = response.data as List<dynamic>;
        return trackList.map((track) => TrackModel.fromJson(track)).toList();
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Failed to load favorite tracks: ${e.toString()}");
    }
  }

  @override
  Future<List<PlaylistModel>?> getFollowedPlaylists() async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.playlist}/get-followed-playlist",
        options: Options(headers: {
          "accept": "application/json; charset=utf-8",
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> playlistList = response.data as List<dynamic>;
        return playlistList
            .map((playlist) => PlaylistModel.fromJson(playlist))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Failed to load followed playlists: ${e.toString()}");
    }
  }
}
