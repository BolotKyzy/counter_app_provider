import 'dart:math';

import 'package:mvvm_counter/domain/data_providers/user_data_providers.dart';
import 'package:mvvm_counter/domain/entity/user.dart';

class UserService {
  final userDataProvider = UserDataProvider();
  User get user => userDataProvider.user;

  Future<void> initialize() async {
    userDataProvider.loadValue();
  }

  incrementAge() {
    final user = userDataProvider.user;
    userDataProvider.user = user.copyWith(age: user.age + 1);
  }

  decrementAge() {
    final user = userDataProvider.user;

    userDataProvider.user = user.copyWith(age: max(user.age - 1, 0));
  }
}
