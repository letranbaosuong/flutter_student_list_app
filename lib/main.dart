import 'package:apidemo/blocs/student_bloc.dart';
import 'package:apidemo/ui/students.dart';
import 'package:flutter/material.dart';

void main() {
  final _studentBloc = StudentBloc.getInstance();
  _studentBloc.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Students(),
    );
  }
}
