import 'package:saturn/models/assignment.dart';
import 'package:saturn/models/category.dart';

class Course {
  String name;
  String teacher;
  String schedule;
  String grade;
  List<Category> categories;
  List<Assignment> assignments;

  Course(this.name, this.teacher, this.schedule, this.grade, this.categories, this.assignments);
}