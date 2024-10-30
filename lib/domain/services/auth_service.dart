import 'package:mvvm_counter/domain/data_providers/auth_api_provider.dart';
import 'package:mvvm_counter/domain/data_providers/session_data_provider.dart';

class AuthService {
  final _sessionDataProvider = SessionDataProvider();
  final _authApiProvidr = AuthApiProvider();

  Future<bool> checkAuth() async {
    final _apiKey = await _sessionDataProvider.apiKey();
    return _apiKey != null;
  }

  Future<void> login(String login, String password) async {
    final _apiKey = await _authApiProvidr.login(login, password);
    await _sessionDataProvider.saveApiKey(_apiKey!);
  }

  Future<void> logout() async {
    await _sessionDataProvider.clearAplKey();
  }
}
