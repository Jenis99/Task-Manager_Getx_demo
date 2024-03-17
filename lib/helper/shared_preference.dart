import 'package:get_storage/get_storage.dart';

class AppSharedPreference {
  static final _getStorage = GetStorage();

  static const _accessToken = 'access_Token';

  static Future<void> setJwtToken(String accessToken) async => _getStorage.write(_accessToken, accessToken);

  static String accessToken() {
    return _getStorage.read(_accessToken) ?? '';
  }

  static void clear() => _getStorage.erase();
}
