import 'dart:io';

import 'package:soundspace/core/common/secrets/app_secrets.dart';

class Endpoints {
  Endpoints._();
  static String baseUrl =
      Platform.isAndroid ? AppSecrets.baseUrlAnd : AppSecrets.baseUrlIos;
  static String auth = "$baseUrl/Auth";
}
