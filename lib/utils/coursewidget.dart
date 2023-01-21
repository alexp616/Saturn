import 'package:flutter/material.dart';
import 'package:saturn/models/course.dart';
import 'package:saturn/utils/sizes.dart';
import 'package:saturn/utils/themes.dart';

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
          bottom: BorderSide(color: Darkmode.purple),
          top: BorderSide(color: Darkmode.purple)
        )
      ),

      child: Text("${course.name} ${course.teacher} ${course.grade}", style: TextStyle(color: Colors.black))
    );
  }
}