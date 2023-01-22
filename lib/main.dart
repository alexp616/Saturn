import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:saturn/courselistpage.dart';
import 'package:saturn/loginpage.dart';
import 'package:saturn/utils/themes.dart';
import 'package:saturn/utils/storage.dart';
import 'package:saturn/utils/request.dart';
import 'package:saturn/models/student.dart';
import 'package:saturn/utils/sizes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  storage = const FlutterSecureStorage();

  var requestClient = RequestBuilder();
  final rememberMe = (await storage.read(key: 'rememberMe')) == 'true';
  if (rememberMe) {
    String json = await requestClient.makeRequest(
      id: await storage.read(key: 'osis'), password: await storage.read(key: 'password'), 
      school: 'Bronx High School of Science',
      city: 'New York City', state: 'us_ny'
    );
    student = Student.fromJson(jsonDecode(json));
  }
  runApp(MyApp(rememberMe: rememberMe));
}

class MyApp extends StatelessWidget {
  final bool? rememberMe;
  const MyApp({Key? key, required this.rememberMe}) : super(key: key);

  @override
  build(BuildContext context) {
    if (rememberMe ?? false) {
      return MaterialApp(
        home: const CourseListPage(),
        theme: ThemeData(fontFamily: 'Raleway')
      );
    }
    else {
      return MaterialApp(
        home: const LoginPage(),
        theme: ThemeData(fontFamily: 'Raleway')
      );
    }
  }
}

