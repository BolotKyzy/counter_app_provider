import 'dart:math';

import 'package:mvvm_counter/domain/data_providers/user_data_providers.dart';
import 'package:mvvm_counter/domain/entity/user.dart';

class UserState {
  final User currentUser;
  UserState({
    required this.currentUser,
  });

  UserState copyWith({
    User? currentUSer,
  }) {
    return UserState(
      currentUser: currentUSer ?? currentUser,
    );
  }

  @override
  String toString() => 'UserState(currentUSer: $currentUser)';

  @override
  bool operator ==(covariant UserState other) {
    if (identical(this, other)) return true;

    return other.currentUser == currentUser;
  }

  @override
  int get hashCode => currentUser.hashCode;
}

class UsersBloc {
  final _userProvider = UserDataProvider();
  var _state = UserState(currentUser: User(0));
  UserState get state => _state;

  UsersBloc() {}

  Future<void> _initialize() async {
    await _userProvider.loadValue();
    _state = _state.copyWith(currentUSer: _userProvider.user);
  }

  void incrementAge() {
    var user = _state.currentUser;
    user = user.copyWith(age: user.age + 1);
    _state = _state.copyWith(currentUSer: user);
    _userProvider.user = user.copyWith(age: user.age + 1);

    _userProvider.saveValue();
  }

  void decrementAge() {
    var user = _state.currentUser;
    user = user.copyWith(age: user.age - 1);
    _state = _state.copyWith(currentUSer: user);
    _userProvider.user = user.copyWith(age: max(user.age - 1, 0));
    _userProvider.saveValue();
  }
}
