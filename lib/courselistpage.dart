import 'package:flutter/material.dart';
import 'package:saturn/loginpage.dart';
import 'package:saturn/models/course.dart';
import 'package:saturn/models/student.dart';
import 'package:saturn/utils/sizes.dart';
import 'package:saturn/utils/themes.dart';
import 'package:saturn/coursepage.dart';
import 'package:saturn/utils/storage.dart';


class CourseListPage extends StatefulWidget {
  const CourseListPage({Key? key}) : super(key: key);

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.green,
          title: Text(student!.name),
          centerTitle: true,
          leading: Container(),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem<String> (
                    value: 'logout',
                    child: Text("Log Out", style: TextStyle(color: Color.fromARGB(255, 198, 49, 39)),)
                  )
                ];
              },
              onSelected: (value) {
                if (value == 'logout') {
                  logout(context);
                }
              },
            )
          ],
        ),
      ),

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

class CourseWidget extends StatelessWidget {
  final Course course;
  const CourseWidget({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenWidth * 0.2,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Darkmode.darkPurple),
          top: BorderSide(color: Darkmode.darkPurple)
        )
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return (CoursePage(course: course));
          })
        ),
        child: Text("${course.name} ${course.teacher} ${course.grade} ${course.getLatestExam().toString()}", style: TextStyle(color: Colors.black))
      ),
    );
  }
}