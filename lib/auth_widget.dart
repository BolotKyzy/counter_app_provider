import 'package:flutter/material.dart';
import 'package:mvvm_counter/domain/data_providers/auth_api_provider.dart';
import 'package:mvvm_counter/domain/services/auth_service.dart';
import 'package:provider/provider.dart';

enum _ViewModelAuthBtnState { CanSubmit, AuthProcess, Disable }

class ViewModelService {
  final String authErrorTitle;
  final String? password;
  final String? login;
  final bool isAuthInProcess;
  _ViewModelAuthBtnState get authBtnState {
    if (isAuthInProcess) {
      return _ViewModelAuthBtnState.AuthProcess;
    } else if (login!.isNotEmpty && password!.isNotEmpty) {
      return _ViewModelAuthBtnState.CanSubmit;
    } else {
      return _ViewModelAuthBtnState.Disable;
    }
  }

  ViewModelService(
      {this.isAuthInProcess = false,
      this.authErrorTitle = '',
      this.login = '',
      this.password = ''});

  ViewModelService copyWith(
      {String? authErrorTitle,
      String? password,
      String? login,
      bool? isAuthInProcess,
      _ViewModelAuthBtnState? authBtnState}) {
    return ViewModelService(
        authErrorTitle: authErrorTitle ?? this.authErrorTitle,
        login: login ?? this.login,
        isAuthInProcess: isAuthInProcess ?? this.isAuthInProcess,
        password: password ?? this.password);
  }
}

class _ViewModel extends ChangeNotifier {
  var _state = ViewModelService();
  var _authService = AuthService();
  ViewModelService get state => _state;
  void changeLogin(String value) {
    if (_state.login == value) return;
    _state = _state.copyWith(login: value);
    notifyListeners();
  }

  void changePassword(String value) {
    if (_state.password == value) return;

    _state = _state.copyWith(password: value);
    notifyListeners();
  }

  Future<void> onAuthBtnPressed() async {
    final login = _state.login;
    final psw = _state.password;
    if (login!.isEmpty || psw!.isEmpty) return;
    _state = _state.copyWith(authErrorTitle: "", isAuthInProcess: true);
    notifyListeners();

    try {
      await _authService.login(login, psw);
      _state = _state.copyWith(isAuthInProcess: false);
      notifyListeners();
    } on AuthApiProviderIncorretLoginDataError {
      _state = _state.copyWith(
          authErrorTitle: "Incorrect login or password",
          isAuthInProcess: false);
      notifyListeners();
    } catch (exeption) {
      _state = _state.copyWith(
          authErrorTitle: "Something is wrong", isAuthInProcess: false);
      notifyListeners();
    }
  }
}

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});
  static Widget create() {
    return ChangeNotifierProvider(
        create: (_) => _ViewModel(), child: AuthWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
            child: Column(
          children: [
            _ErrorTitleWidget(),
            const SizedBox(
              height: 20,
            ),
            _LoginWidget(),
            const SizedBox(
              height: 20,
            ),
            _PswWidget(),
            const SizedBox(
              height: 20,
            ),
            _AuthBtnWidget()
          ],
        )),
      ),
    );
  }
}

class _LoginWidget extends StatelessWidget {
  const _LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextField(
      decoration:
          InputDecoration(labelText: "Login", border: OutlineInputBorder()),
      onChanged: model.changeLogin,
    );
  }
}

class _PswWidget extends StatelessWidget {
  const _PswWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return TextField(
      decoration:
          InputDecoration(labelText: "Password", border: OutlineInputBorder()),
      onChanged: model.changePassword,
    );
  }
}

class _ErrorTitleWidget extends StatelessWidget {
  const _ErrorTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authErrorTitle =
        context.select((_ViewModel value) => value.state.authErrorTitle);

    return Text(authErrorTitle);
  }
}

class _AuthBtnWidget extends StatelessWidget {
  const _AuthBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();

    final authBtnState =
        context.select((_ViewModel value) => value.state.authBtnState);

    final Widget child = authBtnState == _ViewModelAuthBtnState.AuthProcess
        ? CircularProgressIndicator()
        : Text("Log in");
    return ElevatedButton(
      onPressed: authBtnState == _ViewModelAuthBtnState.CanSubmit
          ? model.onAuthBtnPressed
          : null,
      child: child,
    );
  }
}