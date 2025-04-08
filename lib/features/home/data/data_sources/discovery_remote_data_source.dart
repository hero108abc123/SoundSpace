import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soundspace/core/network/constants/endpoints.dart';
import 'package:soundspace/core/network/remote/dio_client.dart';
import 'package:soundspace/features/home/data/models/artist_model.dart';
import 'package:soundspace/features/home/data/models/playlist_model.dart';
import 'package:soundspace/features/home/data/models/track_model.dart';

abstract interface class DiscoveryRemoteDataSource {
  Future<List<TrackModel>?> getTracksFromUnfollowings();
  Future<List<PlaylistModel>?> getPlaylistsFromUnfollowings();
  Future<List<ArtistModel>?> getUnfollowedArtists();
  Future<List<PlaylistModel>?> getPlaylistsByUserId({
    required int userId,
  });
  Future<List<TrackModel>?> getTracksByUserId({
    required int userId,
  });
}

class DiscoveryRemoteDataSourceImpl implements DiscoveryRemoteDataSource {
  final DioClient _dio;
  static const storage = FlutterSecureStorage();
  DiscoveryRemoteDataSourceImpl(this._dio);

  @override
  Future<List<TrackModel>?> getTracksFromUnfollowings() async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.track}/get-track-from-nonfollowing",
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
  Future<List<PlaylistModel>?> getPlaylistsFromUnfollowings() async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.playlist}/get-playlist-from-unfollowing",
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
      throw Exception("Failed to load playlists: ${e.toString()}");
    }
  }

  @override
  Future<List<ArtistModel>?> getUnfollowedArtists() async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.follow}/get-unfollowed-artists",
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
      throw Exception("Failed to load unfollowed artists: ${e.toString()}");
    }
  }

  Future<List<PlaylistModel>?> getPlaylistsByUserId({
    required int userId,
  }) async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.playlist}/get-playlists-by-userid/$userId",
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
      throw Exception("Failed to load playlists by user ID: ${e.toString()}");
    }
  }

  Future<List<TrackModel>?> getTracksByUserId({
    required int userId,
  }) async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.track}/get-tracks-by-user/$userId",
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
      throw Exception("Failed to load tracks by user ID: ${e.toString()}");
    }
  }
}
