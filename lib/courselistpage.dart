import 'package:flutter/material.dart';

class CourseListPage extends StatefulWidget {
  final String student;
  
  const CourseListPage({Key? key, required this.student}) : super(key: key);
  /*
  final Student student;
    //TODO implement object stuff
  */
  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('sus')
      ),
    );
  }
}
