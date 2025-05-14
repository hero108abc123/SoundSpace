import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soundspace/core/network/constants/endpoints.dart';
import 'package:soundspace/core/network/remote/dio_client.dart';
import 'package:soundspace/features/home/data/models/artist_model.dart';
import 'package:soundspace/features/home/data/models/playlist_model.dart';
import 'package:soundspace/features/home/data/models/track_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<TrackModel>?> loadData();
  Future<List<PlaylistModel>?> getPlaylistsFromFollowings(); // New method
  Future<List<ArtistModel>?> getFollowedArtists(); // New method

  Future<bool> isFavorite({
    required int trackId,
  });
  Future<String> likeTrack({
    required int trackId,
  });
  Future<String> unlikeTrack({
    required int trackId,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient _dio;
  static const storage = FlutterSecureStorage();
  HomeRemoteDataSourceImpl(this._dio);

  @override
  Future<List<TrackModel>?> loadData() async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.track}/get-track-from-following",
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
      throw Exception("Failed to load tracks: ${e.toString()}");
    }
  }

  @override
  Future<List<PlaylistModel>?> getPlaylistsFromFollowings() async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.playlist}/get-playlist-from-following",
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

  @override
  Future<List<ArtistModel>?> getFollowedArtists() async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.follow}/get-followed-artists",
        options: Options(headers: {
          "accept": "application/json; charset=utf-8",
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> artistList = response.data as List<dynamic>;
        return artistList
            .map((artist) => ArtistModel.fromJson(artist))
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Failed to load followed artists: ${e.toString()}");
    }
  }

  @override
  Future<bool> isFavorite({
    required int trackId,
  }) async {
    try {
      var token = await storage.read(key: "token");
      Response response = await _dio.get(
        "${Endpoints.favoriteTrack}/is-favorite/$trackId",
        options: Options(headers: {
          "accept": "application/json; charset=utf-8",
          'Authorization': 'Bearer $token',
        }),
      );
      return response.data['isFavorite'];
    } catch (e) {
      throw Exception("Failed to check if track is favorite: ${e.toString()}");
    }
  }

  @override
  Future<String> likeTrack({
    required int trackId,
  }) async {
    try {
      var token = await storage.read(key: "token");
      Response response = await _dio.post(
        "${Endpoints.favoriteTrack}/add/$trackId",
        options: Options(headers: {
          "accept": "application/json; charset=utf-8",
          'Authorization': 'Bearer $token',
        }),
      );
      return response.data['message'];
    } catch (e) {
      throw Exception("Failed to like track: ${e.toString()}");
    }
  }

  @override
  Future<String> unlikeTrack({
    required int trackId,
  }) async {
    try {
      var token = await storage.read(key: "token");
      Response response = await _dio.delete(
        "${Endpoints.favoriteTrack}/remove/$trackId",
        options: Options(headers: {
          "accept": "application/json; charset=utf-8",
          'Authorization': 'Bearer $token',
        }),
      );
      return response.data['message'];
    } catch (e) {
      throw Exception("Failed to unlike track: ${e.toString()}");
    }
  }
}
