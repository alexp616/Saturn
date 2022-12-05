import 'package:flutter/material.dart';
import 'package:saturn/loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 54, 38, 82)),
      home: const LoginPage(title: 'LoginPage'),
    );
  }
}