import 'package:flutter/material.dart';
import 'package:mvvm_counter/auth_widget.dart';
import 'package:mvvm_counter/example_widget.dart';
import 'package:mvvm_counter/loader_widget.dart';

void main() {
  runApp(MainWidget());
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == 'auth') {
            return PageRouteBuilder(
                pageBuilder: (context, anumation1, animation2) =>
                    AuthWidget.create(),
                transitionDuration: Duration.zero);
          } else if (settings.name == 'example') {
            return PageRouteBuilder(
                pageBuilder: (context, anumation1, animation2) =>
                    ExampleWidget.create(),
                transitionDuration: Duration.zero);
          } else if (settings.name == 'loader') {
            return PageRouteBuilder(
                pageBuilder: (context, anumation1, animation2) =>
                    LoaderWidget.create(),
                transitionDuration: Duration.zero);
          }
        },
        home: LoaderWidget.create());
  }
}
