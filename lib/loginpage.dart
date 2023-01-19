import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:saturn/models/student.dart';
import 'package:saturn/utils/studentinfo.dart';
import 'courselistpage.dart';
import 'utils/request.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  StudentInfo studentinfo = StudentInfo();
  String _osis = '';
  String _password = '';
  // TODO make sus encryption method

  final osisCon = new TextEditingController();
  final passwordCon = new TextEditingController();

  var requestClient = new RequestBuilder();
  
  String student = '';
  // TODO implement Student class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset("assets/saturnlogo.png")),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: osisCon,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'OSIS',
                    hintText: 'Your 9-digit OSIS'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                controller: passwordCon,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Jupiter password'),
              ),
            ),
            ElevatedButton(
              onPressed: ()=> exit(0),
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () async {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => HomePage()));
                  _osis = osisCon.text;
                  _password = passwordCon.text;
                  // TODO encrypt password
                  StudentInfo.studentinformation1 = await requestClient.makeRequest(id: _osis, password: _password, school: 'Bronx High School of Science', city: 'New York City', state: 'us_ny');
                  
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CourseListPage()));
                  });
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




















/*
import 'package:flutter/material.dart';
import 'package:saturn/courselistpage.dart';
import 'package:saturn/utils/request.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Future<String> sus;

  @override
  void initState() {
    super.initState();
    RequestBuilder builder = RequestBuilder();
    sus = builder.makeRequest(
      id: "245017082",
      password: "qwerty",
      school: "Bronx High School of Science",
      city: "New York City",
      state: "us_ny"
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder<String>(
            future: sus,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!,
                  style: TextStyle(color: Colors.white));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            }
          )
        )
      )
    );
  }

}
*/