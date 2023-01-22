import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:saturn/courselistpage.dart';
import 'package:saturn/loginpage.dart';
import 'package:saturn/utils/request.dart';
import 'package:saturn/models/student.dart';

void main() async {
  print('main method ran 1');
  
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();
  final requestClient = RequestBuilder();

  print('main method ran 2');

  bool rememberMe = (await storage.read(key: 'rememberMe')) == 'true';
  if (rememberMe) {
    String json = await requestClient.makeRequest(
      id: await storage.read(key: 'osis') ?? '',
      password: await storage.read(key: 'password') ?? '', 
      school: 'Bronx High School of Science',
      city: 'New York City', state: 'us_ny'
    );

    student = Student.fromJson(jsonDecode(json));
    if (student?.name == 'Incorrect credentials') {
      rememberMe = false;
    }
  }

  print(student?.name);

  runApp(MyApp(storage: storage, rememberMe: rememberMe));
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   storage = const FlutterSecureStorage();

//   var requestClient = RequestBuilder();
//   final rememberMe = (await storage.read(key: 'rememberMe')) == 'true';
//   if (rememberMe) {
//     String json = await requestClient.makeRequest(
//       id: await storage.read(key: 'osis'), password: await storage.read(key: 'password'), 
//       school: 'Bronx High School of Science',
//       city: 'New York City', state: 'us_ny'
//     );
//     student = Student.fromJson(jsonDecode(json));
//   }
//   runApp(MyApp(rememberMe: rememberMe));
// }

class MyApp extends StatelessWidget {
  final FlutterSecureStorage storage;
  final bool rememberMe;
  
  const MyApp({
    Key? key, 
    required this.storage, 
    required this.rememberMe
  }) : super(key: key);

  @override
  build(BuildContext context) {
    Widget home = (rememberMe) ? 
      CourseListPage(storage: storage,) : 
      LoginPage(storage: storage);
    
    return MaterialApp(
      home: home,
      theme: ThemeData(fontFamily: 'Raleway')
    );
  }
}