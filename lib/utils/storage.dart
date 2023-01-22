import 'package:flutter/material.dart';
import 'package:saturn/loginpage.dart';
import 'package:saturn/models/student.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//username & password
// late var storage;

void logout(BuildContext context, FlutterSecureStorage storage) {
  storage.write(key: 'rememberMe', value: false.toString());
  student = null;
  Navigator.pushAndRemoveUntil(context, 
    MaterialPageRoute(
      builder: (_) => LoginPage(storage: storage)
    ), (route) => false
  );
}