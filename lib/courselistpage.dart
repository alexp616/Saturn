import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:saturn/loginpage.dart';
import 'package:saturn/models/course.dart';
import 'package:saturn/models/student.dart';
import 'package:saturn/utils/customcard.dart';
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
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(.13*screenWidth),
        child: AppBar(
          backgroundColor: Darkmode.background,
          brightness: Brightness.dark,
          title: Text(student!.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300)),
          centerTitle: true,
          leadingWidth: .22*screenWidth,
          leading: Padding(
            padding: EdgeInsets.only(
              left: .02*screenWidth
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  student!.gpa!.toStringAsFixed(2) + '%',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)
                )
              ]
            )
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: .02*screenWidth
              ),
              child: PopupMenuButton(
                color: Darkmode.background,
                icon: Image.asset("assets/saturn.png", color: Darkmode.textColor),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<String> (
                      value: 'logout',
                      child: Text(
                        "Log Out", 
                        style: TextStyle(color: Darkmode.textColor)
                      )
                    )
                  ];
                },
                onSelected: (value) {
                  if (value == 'logout') {
                    logout(context, widget.storage);
                  }
                },
              )
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

  ListView buildCourseList(Student? student) {
    List<Widget> courseList = [];
    for (Course c in student!.courses) {
      courseList.add(CourseWidget(course: c, storage: widget.storage));
    }
    return ListView(
      padding: EdgeInsets.only(
        top: 0.01*screenWidth
      ),
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

  Widget lastExam() {
    if (course.getLatestExam() == null) {
      return Text('No exams yet', style: TextStyle(color: Darkmode.textColor, fontSize: 14, fontWeight: FontWeight.w300));
    }
    String grade = ' ${course.getLatestExam()?.score ?? '__'} / ${course.getLatestExam()?.points}';
    
    return SizedBox(
      height: screenWidth*0.045,
      width: 0.74*screenWidth,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Text('${course.getLatestExam()?.name}:', style: TextStyle(color: Darkmode.textColor, fontSize: 14, fontWeight: FontWeight.w300)),
          Text(grade, style: TextStyle(color: Darkmode.textColor, fontSize: 14))
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: screenWidth*.0035),
          Container(
            width: screenWidth,
            height: screenWidth * 0.23,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0),
            ),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return (CoursePage(course: course, storage: storage));
                })
              ),
              child: customCard(
                color: course.getGradeColor(),
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
                          Text(course.name, style: TextStyle(color: Darkmode.textColor, fontSize: 22)),
                          Text(course.teacher, style: TextStyle(color: Darkmode.textColor, fontSize: 18, fontWeight: FontWeight.w300)),
                          lastExam(),
                        ]
                      ),
                      Container(
                        height: 0.184*screenWidth,
                        width: 0.184*screenWidth,
                        decoration: BoxDecoration(
                          color: course.getGradeColor(),
                        ),
                        child: Center(
                          child: Text('${course.grade}%', 
                            style: TextStyle(
                              color: Darkmode.textColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 22,
                            )
                          )
                        ) 
                      )
                    ]
                  )
                )
              )
            ),
          ),
        ]
      )
    );
  }
}