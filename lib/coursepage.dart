import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:saturn/courselistpage.dart';
import 'package:saturn/models/assignment.dart';
import 'package:saturn/models/course.dart';
import 'package:saturn/utils/themes.dart';
import 'package:saturn/models/student.dart';
import 'package:saturn/loginpage.dart';
import 'package:saturn/utils/storage.dart';
import 'package:saturn/utils/sizes.dart';

class CoursePage extends StatefulWidget {
  final Course course;
  final FlutterSecureStorage storage;
  
  const CoursePage({
    Key? key,
    required this.course,
    required this.storage
  }) : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.green,
          title: Text(student!.name),
          centerTitle: true,
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.menu),
              color: Colors.lightBlue,
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<String> (
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
        )
      ),

      backgroundColor: Darkmode.background,
      body: Center(
        child: buildAssignmentList()
      ),
    );
  }

  List<Assignment> findAssignments() {
    List<Assignment> matches = [];

    for (Assignment assignment in widget.course.assignments) {
      if (assignment.name.toLowerCase().contains(search)) {
        matches.add(assignment);
      }
    }

    return matches;
  }

  Widget buildSearchBar() {
    return TextField(
      onChanged: (text) {
        setState(() => search = text.toLowerCase());
      }
    );
  }

  Widget buildAssignmentList() {
    List<Widget> assignmentList = [
      courseHeading(),
      buildSearchBar(),
    ];

    for (Assignment assignment in findAssignments()) {
      assignmentList.add(assignmentWidget(assignment));
    }

    return ListView(
      children: assignmentList,
    );
  }

  Widget courseHeading() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: screenWidth,
        child: Column(
          children: <Widget>[
            Text(widget.course.name),
            Text(widget.course.teacher),
            Text(widget.course.schedule)
          ],
        )
      )
    );
  }

  Widget assignmentWidget(Assignment assignment) {
    return Text(assignment.name);
  }
}