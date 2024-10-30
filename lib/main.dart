import 'package:flutter/material.dart';
import 'package:mvvm_counter/auth_widget.dart';
import 'package:mvvm_counter/example_widget.dart';

void main() {
  runApp(const MainWidget());
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AuthWidget.create());
  }
}
