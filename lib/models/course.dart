import 'package:flutter/material.dart';
import 'package:saturn/models/assignment.dart';
import 'package:saturn/models/category.dart';
import 'package:saturn/models/student.dart';
import 'dart:math';

class Course {
  late String name;
  late String teacher;
  late String schedule;
  late num grade;
  late List<Category> categories;
  late List<Assignment> assignments;

  Course(this.name, this.teacher, this.schedule, this.grade, this.categories, this.assignments);

  // Course(String name, String teacher, String schedule, num grade, List<Category> categories, List<Assignment> assignments) {
  //   this.name = name;
  //   this.teacher = teacher;
  //   this.schedule = schedule;
  //   this.grade = ((Random().nextInt(6) + 5) / 10.0) * grade;
  //   this.categories = categories;
  //   this.assignments = assignments;
  // }

  factory Course.fromJson(json) {
    List<Category> jsonCategories = [];
    List<Assignment> jsonAssignments = [];

    for (dynamic item in json['categories']) {
      jsonCategories.add(Category.fromJson(item));
    }

    for (dynamic item in json['assignments']) {
      jsonAssignments.add(Assignment.fromJson(item));
    }

    json['grade'] = num.parse(json['grade'].toStringAsFixed(1));

    return Course(
      fix(json['name'] as String),
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

  static int getGradeRange(num grade) {
    if (grade < 60) {
      return -1;
    } if (grade >= 60 && grade < 70) {
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
      const Color.fromARGB(255, 218, 90, 81),
      const Color.fromARGB(255, 226, 205, 121),
      const Color.fromARGB(255, 126, 206, 132),
      const Color.fromARGB(255, 101, 210, 226),
      const Color.fromARGB(255, 172, 111, 204)
    ];

    colors = [for (Color color in colors) darken(color, 0.22)];

    int range = getGradeRange(grade);
    
    if (range == -1) {
      return colors[0];
    }

    if (range == 4) {
      return colors[4];
    }

    Color start = colors[range];
    Color end = colors[range+1];
    double percent = (grade % 10) / 10.0;

    int r = (start.red + percent * (end.red - start.red)).floor();
    int g = (start.green + percent * (end.green - start.green)).floor();
    int b = (start.blue + percent * (end.blue - start.blue)).floor();

    return Color.fromARGB(255, r, g, b);
  }
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}