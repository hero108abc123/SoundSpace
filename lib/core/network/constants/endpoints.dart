import 'package:soundspace/core/common/secrets/app_secrets.dart';

class Endpoints {
  Endpoints._();
  static String baseUrl = AppSecrets.soundSpaceApi;
  static String auth = "$baseUrl/Auth";
}
