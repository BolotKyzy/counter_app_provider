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
    return MaterialApp(routes: {
      'auth': (_) => AuthWidget.create(),
      'example': (_) => ExampleWidget.create()
    }, home: LoaderWidget.create());
  }
}
