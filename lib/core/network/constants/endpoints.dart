import 'package:soundspace/core/common/secrets/app_secrets.dart';

class Endpoints {
  Endpoints._();
  static String baseUrl = AppSecrets.baseUrlIos;
  static String auth = "$baseUrl/Auth";
  static String user = "$baseUrl/User";
}
