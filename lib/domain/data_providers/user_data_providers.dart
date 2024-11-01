import 'package:mvvm_counter/domain/entity/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider {
  final sharedPreferences = SharedPreferences.getInstance();
  var user = User(0);

  Future<User> loadValue() async {
    final age = (await sharedPreferences).getInt('age') ?? 0;
    user = User(age);
    return User(age);
  }

  Future<void> saveValue() async {
    (await sharedPreferences).setInt('age', user.age);
  }
}
