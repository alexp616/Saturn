import 'package:saturn/models/course.dart';

class Student {
  String name;
  num? gpa;
  List<Course> courses;

  Student(this.name, this.gpa, this.courses);

  factory Student.fromJson(dynamic json) {
    List<Course> jsonCourses = [];

    for (dynamic item in json['courses']) {
      jsonCourses.add(Course.fromJson(item));
    }

    return Student(
      json['name'] as String,
      json['gpa'] as num?,
      jsonCourses,
    );                      
  }
}

Student? student;

String fix(String text) {
  return text.replaceAll('&amp;', ' & ');
}
