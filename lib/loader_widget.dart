import 'package:flutter/material.dart';
import 'package:mvvm_counter/domain/services/auth_service.dart';
import 'package:provider/provider.dart';

class _ViewModel {
  final _authService = AuthService();
  BuildContext context;
  _ViewModel(this.context) {
    init();
  }
  void init() async {
    final _isAuth = await _authService.checkAuth();
    if (_isAuth) {
      _goToExampleScreen();
    } else {
      _goToAuthScreen();
    }
  }

  void _goToAuthScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil('auth', (route) => false);
  }

  void _goToExampleScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil('example', (route) => false);
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});
  static Widget create() {
    return Provider(
      create: (context) => _ViewModel(context),
      child: LoaderWidget(),
      lazy: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
