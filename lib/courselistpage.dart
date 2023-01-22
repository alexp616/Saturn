import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:saturn/loginpage.dart';
import 'package:saturn/models/course.dart';
import 'package:saturn/models/student.dart';
import 'package:saturn/utils/sizes.dart';
import 'package:saturn/utils/themes.dart';
import 'package:saturn/coursepage.dart';
import 'package:saturn/utils/storage.dart';


class CourseListPage extends StatefulWidget {
  final FlutterSecureStorage storage;

  const CourseListPage({
    Key? key,
    required this.storage
  }) : super(key: key);

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
          backgroundColor: Darkmode.darkBlue,
          title: Text(student!.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          centerTitle: true,
          leading: Container(),
          actions: [
            PopupMenuButton(
              color: Darkmode.darkBlue,
              icon: Icon(Icons.menu),
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
                  logout(context, widget.storage);
                }
              },
            )
          ],
        ),
      ),

      backgroundColor: Darkmode.background,
      body: Center(
        child: buildCourseList(student)
      ),
    );
  }

  Widget buildCourseList(Student? student) {
    List<Widget> courseList = [];
    for (Course c in student!.courses) {
      courseList.add(CourseWidget(course: c, storage: widget.storage));
    }
    return ListView(
      children: courseList
    ); 
  }
}

class CourseWidget extends StatelessWidget {
  final Course course;
  final FlutterSecureStorage storage;
  
  const CourseWidget({
    Key? key, 
    required this.course,
    required this.storage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenWidth * 0.23,
      decoration: BoxDecoration(
        color: Darkmode.background,
        border: Border(
          bottom: BorderSide(color: Darkmode.darkBlue),
          top: BorderSide(color: Darkmode.darkBlue)
        )
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return (CoursePage(course: course, storage: storage));
          })
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: .02*screenWidth,
            right: .02*screenWidth
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.name, style: TextStyle(color: Darkmode.textColor, fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(course.teacher, style: TextStyle(color: Darkmode.textColor, fontSize: 18)),
                  Text('${(course.getLatestExam() ?? 'No exams yet')}', style: TextStyle(color: Darkmode.textColor, fontSize: 14)),
                ]
              ),
              Container(
                height: 0.184*screenWidth,
                width: 0.184*screenWidth,
                decoration: BoxDecoration(
                  color: course.getGradeColor(),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: Text('${course.grade}%', style: TextStyle(
                    color: Darkmode.textColor, 
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ))
                ) 
              )
            ]
          )
        )
      ),
    );
  }
}