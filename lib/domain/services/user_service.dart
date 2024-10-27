import 'dart:math';

import 'package:mvvm_counter/domain/entity/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  var _user = User(0);
  User get user => _user;

  Future<void> loadValue() async {
    final sharedPrefernces = await SharedPreferences.getInstance();
    final age = sharedPrefernces.getInt('age') ?? 0;
    _user = User(age);
  }

  Future<void> saveValue() async {
    final sharedPrefernces = await SharedPreferences.getInstance();
    sharedPrefernces.setInt('age', _user.age);
  }

  incrementAge() {
    _user = _user.copyWith(age: _user.age + 1);
  }

  decrementAge() {
    _user = _user.copyWith(age: max(_user.age - 1, 0));
  }
}
