import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundspace/core/common/secrets/app_secrets.dart';
import 'package:soundspace/features/auth/domain/repositories/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  static const String _tokenKey = AppSecrets.token;

  @override
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }
}
