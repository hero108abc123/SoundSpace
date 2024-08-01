import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:soundspace/core/error/exceptions.dart';
import 'package:soundspace/core/network/remote/dio_client.dart';
import 'package:soundspace/features/home/data/models/track_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<TrackModel>?> loadData();
}

abstract interface class HomeLocalDataSource {
  Future<List<TrackModel>?> loadData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient _dio;

  HomeRemoteDataSourceImpl(this._dio);

  @override
  Future<List<TrackModel>?> loadData() async {
    try {
      Response response = await _dio.get(
        "https://thantrieu.com/resources/braniumapis/songs.json",
      );
      if (response.statusCode == 200) {
        final dataContent = utf8.decode(response.data);
        var trackWrapper = jsonDecode(dataContent) as Map<String, dynamic>;
        var trackList = trackWrapper["songs"] as List;
        List<TrackModel> tracks =
            trackList.map((track) => TrackModel.fromJson(track)).toList();
        return tracks;
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  Future<List<TrackModel>?> loadData() async {
    final String response = await rootBundle.loadString('assets/tracks.json');
    final jsonBody = jsonDecode(response) as Map<String, dynamic>;
    final trackList = jsonBody["songs"] as List;
    List<TrackModel> tracks =
        trackList.map((track) => TrackModel.fromJson(track)).toList();
    return tracks;
  }
}
