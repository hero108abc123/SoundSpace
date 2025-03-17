import 'package:soundspace/core/common/secrets/app_secrets.dart';

class Endpoints {
  Endpoints._();
  static String baseUrl = AppSecrets.baseUrl;
  static String auth = "$baseUrl/Auth";
  static String user = "$baseUrl/User";
  static String track = "$baseUrl/Track";
  static String playlist = "$baseUrl/Playlist";
  static String playlistFollow = "$baseUrl/PlaylistFollow";
  static String follow = "$baseUrl/Follow";
  static String trackPlaylist = "$baseUrl/TrackPlaylist";
  static String favoriteTrack = "$baseUrl/FavoriteTrack";
}
