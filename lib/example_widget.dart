import 'package:flutter/material.dart';
import 'package:mvvm_counter/domain/services/user_service.dart';
import 'package:provider/provider.dart';

class ViewModelService {
  final String ageTitle;
  ViewModelService({required this.ageTitle});
}

class ViewModel extends ChangeNotifier {
  final _userService = UserService();
  var _state = ViewModelService(ageTitle: '');
  ViewModelService get state => _state;

  Future<void> loadValue() async {
    await _userService.initialize();
    _updateState();
  }

  ViewModel() {
    loadValue();
  }

  Future<void> onIncBtnPressed() async {
    _userService.incrementAge();
    _updateState();
  }

  Future<void> onDecBtnPressed() async {
    _userService.decrementAge();
    _updateState();
  }

  void _updateState() {
    final user = _userService.user;
    _state = ViewModelService(ageTitle: user.age.toString());
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
