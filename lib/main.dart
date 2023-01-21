import 'package:flutter/material.dart';
import 'package:saturn/loginpage.dart';
import 'package:saturn/utils/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Darkmode.background),
      home: LoginPage(),
    );
  }
}