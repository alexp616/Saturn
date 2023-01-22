import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:saturn/models/student.dart';
import 'package:saturn/utils/storage.dart';
import 'package:saturn/utils/themes.dart';
import 'package:saturn/courselistpage.dart';
import 'package:saturn/utils/request.dart';
import 'package:saturn/utils/sizes.dart';

class LoginPage extends StatefulWidget {
  final FlutterSecureStorage storage;
  
  const LoginPage({
    Key? key, 
    required this.storage
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  String _osis = '';
  String _password = '';

  final osisCon = TextEditingController();
  final passwordCon = TextEditingController();

  var requestClient = RequestBuilder();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Darkmode.background,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 500,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
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
                    style: TextStyle(color: Darkmode.textColor),
                    decoration: InputDecoration(
                        labelText: 'OSIS',
                        labelStyle: TextStyle(color: Darkmode.textColor.withAlpha(175)),
                        hintText: 'Your 9-digit OSIS',
                        hintStyle: TextStyle(color: Darkmode.textColor.withAlpha(125)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Darkmode.darkBlue),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Darkmode.lightBlue),
                        ),
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 20),
                  child: TextField(
                    obscureText: true,
                    controller: passwordCon,
                    style: TextStyle(color: Darkmode.textColor),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Darkmode.textColor.withAlpha(175)),
                      hintText: 'Your Jupiter Password',
                      hintStyle: TextStyle(color: Darkmode.textColor.withAlpha(125)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Darkmode.darkBlue),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Darkmode.lightBlue),
                      ),
                    )
                  ),
                ),
                rememberCheckbox(),
                // ElevatedButton(
                //   onPressed: ()=> exit(0),
                //   child: Text(
                //     'Forgot Password',
                //     style: TextStyle(color: Colors.white, fontSize: 15),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Container(
                    
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Darkmode.darkBlue,
                        shadowColor: Darkmode.darkPurple,
                        elevation: 20,
                        shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                      ),
                      onPressed: () async {
                        _osis = osisCon.text;
                        _password = passwordCon.text;

                        String json = await requestClient.makeRequest(
                          id: _osis, password: _password, 
                          school: 'Bronx High School of Science', 
                          city: 'New York City', state: 'us_ny'
                        );

                        student = Student.fromJson(jsonDecode(json));
                        
                        if (student!.name != "Incorrect credentials") {
                          setState(() {
                            widget.storage.write(key: 'osis', value: _osis);
                            widget.storage.write(key: 'password', value: _password);
                            widget.storage.write(key: 'rememberMe', value: rememberMe.toString());
                            Navigator.push(context, MaterialPageRoute(builder: (_) => CourseListPage(storage: widget.storage)));
                          });
                        }
                        else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: Text(
                                  "Invalid credentials!", 
                                  style: TextStyle(
                                    color: Darkmode.textColor,
                                    fontSize: 26,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              );
                            },
                          );
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Darkmode.textColor, fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rememberCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text('Remember Me', style: TextStyle(color: Darkmode.textColor)),
        Checkbox(
          activeColor: Darkmode.darkBlue,
          side: MaterialStateBorderSide.resolveWith(
            (states) => BorderSide(width: 1.0, color: Darkmode.darkBlue),
          ),
          value: rememberMe,
          onChanged: (bool? value) {
            setState(() {
              rememberMe = value!;
            });
          },
        )
      ],
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