import 'package:flutter/material.dart';
import 'package:saturn/models/assignment.dart';
import 'package:saturn/models/category.dart';
import 'dart:math';

class Course {
  late String name;
  late String teacher;
  late String schedule;
  late num grade;
  late List<Category> categories;
  late List<Assignment> assignments;

  // Course(this.name, this.teacher, this.schedule, this.grade, this.categories, this.assignments);

  Course(String name, String teacher, String schedule, num grade, List<Category> category, List<Assignment> assignments) {
    this.name = name;
    this.teacher = teacher;
    this.schedule = schedule;
    this.grade = ((Random().nextInt(50) + 50) / 100.0) * grade;
    this.categories = categories;
    this.assignments = assignments;
  }

  factory Course.fromJson(json) {
    List<Category> jsonCategories = [];
    List<Assignment> jsonAssignments = [];

    for (dynamic item in json['categories']) {
      jsonCategories.add(Category.fromJson(item));
    }

    for (dynamic item in json['assignments']) {
      jsonAssignments.add(Assignment.fromJson(item));
    }

    return Course(
      json['name'] as String,
      json['teacher'] as String,
      json['schedule'] as String,
      json['grade'] as num,
      jsonCategories, 
      jsonAssignments 
    );
  }

  Assignment? getLatestExam() {

    List<num> categoryWeights = [for (Category c in categories) c.weight];
    Category greatestCategory = categories[categoryWeights.indexOf(categoryWeights.reduce(max))];
    for (Assignment a in assignments) {
      if (a.category == greatestCategory.name) {
        return a;
      }
    }
    return null;
  }

  int getGradeRange() {
    if (grade < 70) {
      return 0;
    } if (grade >= 70 && grade < 80) {
      return 1;
    } if (grade >= 80 && grade < 90) {
      return 2;
    } if (grade >= 90 && grade < 100) {
      return 3;
    } else {
      return 4;
    }
  }

  Color getGradeColor() {
    List<Color> colors = [
      const Color.fromARGB(255, 255, 99, 87),
      const Color.fromARGB(255, 252, 235, 166),
      const Color.fromARGB(255, 134, 216, 141),
      const Color.fromARGB(255, 101, 210, 226),
      const Color.fromARGB(255, 172, 111, 204)
    ];

    int range = getGradeRange();
    Color start = colors[range];
    Color end = colors[(range == 4) ? 4 : range+1];
    double percent = (grade % 10) / 10.0;

    int r = (start.red + percent * (end.red - start.red)).floor();
    int g = (start.green + percent * (end.green - start.green)).floor();
    int b = (start.blue + percent * (end.blue - start.blue)).floor();

    return Color.fromARGB(255, r, g, b);
  }
}

// red 70 and below
// yellow 70-80
// green 80-90
// blue 90-100
// purple 100 and above
