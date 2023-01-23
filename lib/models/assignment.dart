import 'package:saturn/models/student.dart';
import 'package:flutter/material.dart';
import 'package:saturn/models/course.dart';

class Assignment {
  String due;
  String name;
  num? score;
  num points;
  String category;
  bool graded;

  Assignment(this.due, this.name, this.score, this.points, this.category, this.graded);

  factory Assignment.fromJson(dynamic json) {
    return Assignment(
      json['due'] as String,
      fix(json['name'] as String),
      json['score'] as num?,
      json['points'] as num,
      json['category'] as String,
      json['graded'] as bool
    );
  }

  String toString() {
    if (score == null) {
      return '$name: Not Graded';
    }
    return '$name: $score / $points';
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

    if (score == null) {
      return const Color.fromARGB(150, 60, 60, 60);
    }

    int range = Course.getGradeRange((score!.toDouble() / points.toDouble()) * 100);
    range = (range > 0) ? range : 0;

    return colors[range];
  }
}