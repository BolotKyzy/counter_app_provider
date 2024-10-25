import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModel extends ChangeNotifier {
  ViewModel() {
    loadValue();
  }

  var _age = 0;
  int get age => _age;
  void loadValue() async {
    final sharedPrefernces = await SharedPreferences.getInstance();
    _age = sharedPrefernces.getInt('age') ?? 0;
    notifyListeners();
  }

  Future<void> incrementAge() async {
    _age++;
    final sharedPrefernces = await SharedPreferences.getInstance();
    sharedPrefernces.setInt('age', _age);

    notifyListeners();
  }

  Future<void> decrementAge() async {
    _age = max(_age - 1, 0);
    final sharedPrefernces = await SharedPreferences.getInstance();
    sharedPrefernces.setInt('age', _age);

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
    final _age = context.select((ViewModel vm) => vm.age);
    return Text("$_age");
  }
}

class AgeIncWidget extends StatelessWidget {
  const AgeIncWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    return ElevatedButton(
        onPressed: viewModel.incrementAge, child: const Text("+"));
  }
}

class AgeDecWidget extends StatelessWidget {
  const AgeDecWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ViewModel>();
    return ElevatedButton(
        onPressed: viewModel.decrementAge, child: const Text("-"));
  }
}
