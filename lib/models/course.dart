import 'package:saturn/models/assignment.dart';
import 'package:saturn/models/category.dart';
import 'dart:math';

class Course {
  String name;
  String teacher;
  String schedule;
  num grade;
  List<Category> categories;
  List<Assignment> assignments;

  Course(this.name, this.teacher, this.schedule, this.grade, this.categories, this.assignments);

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
}

