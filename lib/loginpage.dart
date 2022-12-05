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
        child: FutureBuilder<String>(
          future: sus,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          }
        )
      )
    );
  }

}
