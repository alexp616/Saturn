import 'package:flutter/material.dart';
import 'package:saturn/utils/studentinfo.dart';


class CourseListPage extends StatefulWidget {
  
  const CourseListPage({Key? key}) : super(key: key);
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
        child: Text(StudentInfo.studentinformation1)
      ),
    );
  }
}
