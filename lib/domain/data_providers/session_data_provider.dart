import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionDataProviderKeys {
  static const _apiKey = "api_key";
}

class SessionDataProvider {
  final sharedPreferences = SharedPreferences.getInstance();

  Future<String?> apiKey() async {
    final String? apikey =
        (await sharedPreferences).getString(SessionDataProviderKeys._apiKey);
    print(apikey);
    return apikey;
  }

  Future<void> saveApiKey(String key) async {
    (await sharedPreferences).setString(SessionDataProviderKeys._apiKey, key);
  }

  Future<void> clearAplKey() async {
    (await sharedPreferences).remove(SessionDataProviderKeys._apiKey);
  }
}
