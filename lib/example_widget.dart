import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int age;
  User(this.age);

  User copyWith({
    int? age,
  }) {
    return User(age ?? this.age);
  }
}

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

class ViewModelService {
  final String ageTitle;
  ViewModelService({required this.ageTitle});
}

class ViewModel extends ChangeNotifier {
  final _userService = UserService();
  var _state = ViewModelService(ageTitle: '');
  ViewModelService get state => _state;

  Future<void> loadValue() async {
    await _userService.loadValue();
    _state = ViewModelService(ageTitle: _userService.user.age.toString());
    notifyListeners();
  }

  ViewModel() {
    loadValue();
  }

  Future<void> onIncBtnPressed() async {
    _userService.incrementAge();
    _state = ViewModelService(ageTitle: _userService.user.age.toString());
    notifyListeners();
  }

  Future<void> onDecBtnPressed() async {
    _userService.decrementAge();
    _state = ViewModelService(ageTitle: _userService.user.age.toString());
    notifyListeners();
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _AgeWidget(),
          SizedBox(
            height: 20,
          ),
          AgeIncWidget(),
          SizedBox(
            height: 20,
          ),
          AgeDecWidget()
        ]),
      )),
    );
  }
}

class _AgeWidget extends StatelessWidget {
  const _AgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final age = context.select((ViewModel vm) => vm.state.ageTitle);
    return Text(age);
  }
}

class AgeIncWidget extends StatelessWidget {
  const AgeIncWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    return ElevatedButton(
        onPressed: viewModel.onIncBtnPressed, child: const Text("+"));
  }
}

class AgeDecWidget extends StatelessWidget {
  const AgeDecWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    return ElevatedButton(
        onPressed: viewModel.onDecBtnPressed, child: const Text("-"));
  }
}
