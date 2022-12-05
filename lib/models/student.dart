import 'package:saturn/models/course.dart';

class Student {
  String name;
  num gpa;
  List<Course> courses;

  Student(this.name, this.gpa, this.courses);
}