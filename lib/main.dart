import 'package:flutter/material.dart';
import './constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Constants.primaryColor,
      ),
      home: null,
    );
  }
}