abstract class AuthApiProvide {}

class AuthApiProviderIncorretLoginDataError {}

class AuthApiProvider {
  Future<String?> login(String login, String password) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final isSuccess = login == "admin" && password == "123456";
    if (isSuccess) {
      return "qwertyui";
    } else {
      throw AuthApiProviderIncorretLoginDataError();
    }
  }

  // Future<void> logout() async {}
}
