import 'package:flutter/material.dart';
import 'package:saturn/models/course.dart';
import 'package:saturn/models/student.dart';
import 'package:saturn/utils/coursewidget.dart';
import 'package:saturn/utils/themes.dart';


class CourseListPage extends StatefulWidget {
  const CourseListPage({Key? key}) : super(key: key);
  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: buildCourseList(student)
      ),
    );
  }
}

Widget buildCourseList(Student? student) {
  List<Widget> courseList = [];

  for (Course c in student!.courses) {
    courseList.add(CourseWidget(course: c));
  }
  return ListView(
    children: courseList
  );
}