import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soundspace/core/network/constants/endpoints.dart';
import 'package:soundspace/core/network/remote/dio_client.dart';
import 'package:soundspace/features/home/data/models/artist_model.dart';
import 'package:soundspace/features/home/data/models/playlist_model.dart';
import 'package:soundspace/features/home/data/models/track_model.dart';

abstract interface class UserRemoteDataSource {
  Future<String> logout();
  Future<String> updateUserProfile({
    required String displayName,
    required int age,
    required String gender,
    required String image,
  });
  Future<List<PlaylistModel>?> getMyPlaylists();
  Future<List<TrackModel>?> getMyTracks();
  Future<List<ArtistModel>?> getFollowers();
  Future<String> followUser({
    required int userId,
  });
  Future<String> unfollowUser({
    required int userId,
  });
  Future<String> createPlaylist({
    required String title,
    required int trackId,
  });
  Future<String> addTrack({
    required String title,
    required String image,
    required String source,
    required String album,
    required String lyric,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient _dio;
  static const storage = FlutterSecureStorage();
  UserRemoteDataSourceImpl(this._dio);

  @override
  Future<String> logout() async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.post(
        "${Endpoints.auth}/logout",
        options: Options(headers: {
          "accept": "multipart/form-data; charset=utf-8",
          'Authorization': 'Bearer $token',
        }),
      );
      await storage.delete(key: 'token');
      return response.data['message'] ?? "Logout successful";
    } catch (e) {
      throw Exception("Failed to load tracks: ${e.toString()}");
    }
  }

  @override
  Future<String> updateUserProfile({
    required String displayName,
    required int age,
    required String gender,
    required String image,
  }) async {
    try {
      var token = await storage.read(key: 'token');
      // Prepare the form data
      FormData formData = FormData.fromMap({
        'displayName': displayName,
        'age': age,
        'gender': gender,
        if (image.startsWith('http')) // If the image is a URL, send it as is
          'image': image
        else // If the image is a local file, upload it
          'image': await MultipartFile.fromFile(image,
              filename: image.split('/').last),
      });

      // Make the API call
      Response response = await _dio.put(
        "${Endpoints.user}/update",
        data: formData,
        options: Options(headers: {
          "accept": "/json; charset=utf-8",
          'Authorization': 'Bearer $token',
        }),
      );

      return response.data['message'] ?? "Profile updated successfully";
    } catch (e) {
      throw Exception("Failed to update profile: ${e.toString()}");
    }
  }

  @override
  Future<List<PlaylistModel>?> getMyPlaylists() async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.playlist}/get-my-playlists",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      List<dynamic> playlistList = response.data as List<dynamic>;
      return playlistList
          .map((playlist) => PlaylistModel.fromJson(playlist))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch playlists: ${e.toString()}");
    }
  }

  @override
  Future<List<TrackModel>?> getMyTracks() async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.track}/get-my-tracks",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      List<dynamic> trackList = response.data as List<dynamic>;
      return trackList.map((track) => TrackModel.fromJson(track)).toList();
    } catch (e) {
      throw Exception("Failed to fetch tracks: ${e.toString()}");
    }
  }

  @override
  Future<List<ArtistModel>?> getFollowers() async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.get(
        "${Endpoints.follow}/get-followers",
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
  Future<String> followUser({
    required int userId,
  }) async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.post(
        "${Endpoints.follow}/follow/$userId",
        options: Options(headers: {
          "accept": "*/*",
          'Authorization': 'Bearer $token',
        }),
      );
      return response.data['message'] ?? "User followed successfully";
    } catch (e) {
      throw Exception("Failed to follow user: ${e.toString()}");
    }
  }

  @override
  Future<String> unfollowUser({
    required int userId,
  }) async {
    try {
      var token = await storage.read(key: 'token');
      Response response = await _dio.post(
        "${Endpoints.follow}/unfollow/$userId",
        options: Options(headers: {
          "accept": "*/*",
          'Authorization': 'Bearer $token',
        }),
      );
      return response.data['message'] ?? "User unfollowed successfully";
    } catch (e) {
      throw Exception("Failed to follow user: ${e.toString()}");
    }
  }

  @override
  Future<String> createPlaylist({
    required String title,
    required int trackId,
  }) async {
    try {
      var token = await storage.read(key: 'token');
      FormData formData = FormData.fromMap({
        'title': title,
        'trackId': trackId,
      });

      Response response = await _dio.post(
        "${Endpoints.playlist}/create",
        data: formData,
        options: Options(headers: {
          "accept": "application/json; charset=utf-8",
          'Authorization': 'Bearer $token',
        }),
      );
      return response.data['message'] ?? "Playlist created successfully";
    } catch (e) {
      throw Exception("Failed to create playlist: ${e.toString()}");
    }
  }

  @override
  Future<String> addTrack({
    required String title,
    required String image,
    required String source,
    required String album,
    required String lyric,
  }) async {
    try {
      var token = await storage.read(key: 'token');
      FormData formData = FormData.fromMap({
        'title': title,
        if (image.startsWith('http')) // If the image is a URL, send it as is
          'image': image
        else // If the image is a local file, upload it
          'image': await MultipartFile.fromFile(image,
              filename: image.split('/').last),
        if (source.startsWith('http')) // If the image is a URL, send it as is
          'source': source
        else // If the image is a local file, upload it
          'source': await MultipartFile.fromFile(source,
              filename: source.split('/').last),
        'album': album,
        'lyric': lyric,
      });

      Response response = await _dio.post(
        "${Endpoints.track}/add-track",
        data: formData,
        options: Options(headers: {
          "accept": "application/json; charset=utf-8",
          'Authorization': 'Bearer $token',
        }),
      );
      return response.data['message'] ?? "Track added successfully";
    } catch (e) {
      throw Exception("Failed to add track: ${e.toString()}");
    }
  }
}
