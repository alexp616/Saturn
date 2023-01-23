import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:saturn/models/assignment.dart';
import 'package:saturn/models/category.dart';
import 'package:saturn/models/course.dart';
import 'package:saturn/utils/customcard.dart';
import 'package:saturn/utils/themes.dart';
import 'package:saturn/models/student.dart';
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
        preferredSize: Size.fromHeight(.07*screenHeight),
        child: AppBar(
          backgroundColor: Darkmode.background,
          title: Text(student!.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300)),
          centerTitle: true,
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
                    PopupMenuItem<String> (
                      value: 'logout',
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Positioned(
                            child: const Text(
                              "Log Out", 
                              style: TextStyle(color: Darkmode.textColor)
                            )
                          )
                        ],
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
          ]
        )
      ),

      backgroundColor: Darkmode.background,
      body: Center(
        child: buildCoursePage()
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
    return SizedBox(
      width: screenWidth,
      child: Padding (
        padding: EdgeInsets.symmetric(
          horizontal: .038*screenWidth
        ),
        child: TextField(
          style: const TextStyle(color: Darkmode.textColor),
          decoration: InputDecoration(
            hintText: 'Search for assignments',
            hintStyle: TextStyle(color: Darkmode.textColor.withAlpha(175)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.course.getGradeColor()),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Darkmode.lightBlue),
            ),
          ),
          onChanged: (text) {
            setState(() => search = text.toLowerCase());
          },
        ),
      )
    );
  }

  Widget buildCoursePage() {
    List<Widget> widgetList = [
      SizedBox(height: screenHeight*.0017),
      courseHeading(),
      buildSearchBar(),
      SizedBox(height: screenHeight*.0028),
      buildAssignmentList()
    ];

    return ListView(
      padding: EdgeInsets.only(
        top: 0.01*screenWidth
      ),
      children: widgetList,
    );
  }

  Widget courseHeading() {
    List<Widget> widgetList = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: .6*screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.course.name, style: TextStyle(color: Darkmode.textColor, fontSize: 22)),
                Text(widget.course.teacher, style: TextStyle(color: Darkmode.textColor, fontSize: 18, fontWeight: FontWeight.w300)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  //shrinkWrap: true,
                  child: Text(
                    widget.course.schedule,
                    style: const TextStyle(
                      color: Darkmode.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w300
                    )
                  )
                )
              ]
            ),
          ),
          Container(
            height: 0.09*screenHeight,
            width: 0.184*screenWidth,
            decoration: BoxDecoration(
              color: widget.course.getGradeColor(),
            ),
            child: Center(
              child: Text('${widget.course.grade}%', 
                style: TextStyle(
                  color: Darkmode.textColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 22,
                )
              )
            ) 
          )
        ]
      ),
      SizedBox(height: screenHeight*0.0049),
      Divider(
        color: Darkmode.textColor,
        height: 0.015*screenHeight
      ),
      SizedBox(height: screenHeight*0.0049),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          Text('Categories', style: TextStyle(color: Darkmode.textColor, fontSize: 18)),
          Text('Weight', style: TextStyle(color: Darkmode.textColor, fontSize: 18))
        ]
      ),
      SizedBox(height: screenHeight*0.0049),
    ];

    for (Category c in widget.course.categories) {
      widgetList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '${c.name}: ',
                  style: const TextStyle(
                    color: Darkmode.textColor,
                    fontSize: 14
                  )
                ),
                Text(
                  (c.grade != null) ? '${c.grade}%' : 'n/a',
                  style: const TextStyle(
                    color: Darkmode.textColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 14
                  )
                )
              ]
            ),
            Text(
              '${(c.weight * 100).toStringAsFixed(0)}%', 
              style: const TextStyle(
                color: Darkmode.textColor,
                fontWeight: FontWeight.w300,
                fontSize: 14
              )
            )
          ]
        )
      );
    }
    
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0),
      ),
      child: customCard(
        color: widget.course.getGradeColor(),
        child: Padding(
          padding: EdgeInsets.only(
            left: .02*screenWidth,
            right: .02*screenWidth,
            bottom: .02*screenWidth,
            top: .01*screenWidth 
          ),
          child: Column(
            children: widgetList
          )
        )
      )
    );
  }

  Widget buildAssignmentList() {
    List<Widget> assignmentList = [];
    
    for (Assignment assignment in findAssignments()) {
      assignmentList.add(assignmentWidget(assignment));
    }

    return Column(
      children: assignmentList
    );
  }

  Widget assignmentWidget(Assignment assignment) {
    return Column(
      children: [
        SizedBox(height: screenHeight*.0017),
        Container(
          width: screenWidth,
          height: .11*screenHeight,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0),
          ),
          child: customCard(
            color: Darkmode.cardBackground,
            child: Padding(
              padding: EdgeInsets.only(
                left: .02*screenWidth,
                right: .02*screenWidth
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth*0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(assignment.name, style: const TextStyle(color: Darkmode.textColor, fontSize: 20)),
                        ),
                        Text(
                          (assignment.due != '') ? '${assignment.category}, ${assignment.due}' : assignment.category,
                          style: const TextStyle(
                            color: Darkmode.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w300
                          )
                        ),
                      ],
                    )
                    
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    color: assignment.getGradeColor(),
                    elevation: 4,
                    child: SizedBox(
                      height: 0.09*screenHeight,
                      width: 0.184*screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (assignment.score != null) ? assignment.score!.toStringAsFixed(2) : ' ',
                            style: const TextStyle(color: Darkmode.textColor, fontSize: 20, fontWeight: FontWeight.w300)
                          ),
                          Text(
                            '/ ${assignment.points}',
                            style: const TextStyle(color: Darkmode.textColor, fontSize: 12)
                          )
                        ],
                      )
                    )
                  )
                ]
              )
            )
          )
        ),
      ]
    );
  }
}