import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'course.dart';

class Result {
  int level;
  String semester;
  double gpa;
  dynamic courses;

  Result({
    required this.level,
    required this.semester,
    required this.gpa,
    this.courses,
  });

  // Factory method to create a Result object from a DocumentSnapshot
  factory Result.fromSnapshot(Map<String, dynamic> snapshot) {
    List courses = jsonDecode(snapshot['courses']).toList();
    return Result(
      level: snapshot['level'] ?? 0,
      semester: snapshot['semester'] ?? '',
      gpa: snapshot['gpa']?.toDouble() ?? 0.0,
      courses: courses.map((e)=>Course.fromJson(e)).toList(),
    );
  }

  // Convert the Result object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'semester': semester,
      'gpa': gpa,
      'courses': courses,
    };
  }
}
