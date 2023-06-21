import 'dart:convert';

import 'package:cgpa_calcultor/core/auth/viewModel/auth_view_model.dart';
import 'package:cgpa_calcultor/core/calculator/models/results.dart';
import 'package:cgpa_calcultor/global%20widgets/common_button.dart';
import 'package:cgpa_calcultor/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../global widgets/method_widgets.dart';
import '../models/course.dart';
import 'components/course_field_set.dart';

class CGPACalculator extends StatefulWidget {
  const CGPACalculator({super.key});

  @override
  State<CGPACalculator> createState() => _CGPACalculatorState();
}

class _CGPACalculatorState extends State<CGPACalculator> {
  List<Course> courses = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: customAppBar(context, title: "CGPA Calculator"),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (_) {
              setState(() {
                courses.removeAt(index);
              });
            },
            key: Key(courses[index].id),
            child: CourseFieldSet(
              course: courses[index],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
        onPressed: () {
          setState(() {
            courses.add(Course());
          });
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CommonButton(
          text: 'Calculate',
          onPress: calculateGPA,
          textColor: Colors.white,
        ),
      ),
    );
  }

  calculateGPA() async {
    if(AuthViewModel.instance.user!.level == 600){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You already graduated'),
        ),
      );
      return ;
    }
    if(courses.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add Courses'),
        ),
      );
      return ;
    }
    double totalGradePoints = 0;
    int totalUnits = 0;
    List<Course> carryOvers = [];
    for (var course in courses) {
      if(course.name.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Check course details, error occurred'),
          ),
        );
        return ;
      }
      var unit = int.parse(course.units);
      if (int.parse(course.score) < 40) {
        carryOvers.add(course);
      }
      if (unit > 0 && course.score.isNotEmpty) {
        totalGradePoints += unit * getGradePoints(course.score);
        totalUnits += unit;
      }
    }
    double gpa =
        double.parse((totalGradePoints / totalUnits).toStringAsFixed(2));

    await updateInDatabase(gpa, carryOvers);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Your GPA for the semester is: $gpa'),
      ),
    );
  }

  updateInDatabase(double cgpa, List<Course> carries) async {
    Result result = Result(
        level: AuthViewModel.instance.user!.level!,
        semester: AuthViewModel.instance.user!.semester!,
        gpa: cgpa,
        courses: jsonEncode(courses));
    var oldData = await firestore
        .collection("results")
        .doc(AuthViewModel.instance.user!.uid)
        .get();
    if (!oldData.exists) {
      await firestore
          .collection("results")
          .doc(AuthViewModel.instance.user!.uid)
          .set({
        "results": [result.toJson()]
      });
    } else {
      firestore
          .collection("results")
          .doc(AuthViewModel.instance.user!.uid)
          .set({
        "results": [...oldData["results"], result.toJson()]
      });
    }

    var userdata = await firestore
        .collection("users")
        .doc(AuthViewModel.instance.user!.uid)
        .get();
    List jsonCarries = carries.map((e) => jsonEncode(e)).toList();

    if (!userdata.data()!.containsKey("carryOvers")) {
      await firestore
          .collection("users")
          .doc(AuthViewModel.instance.user!.uid)
          .update({"carryOvers": jsonCarries});
    } else {
      firestore
          .collection("users")
          .doc(AuthViewModel.instance.user!.uid)
          .update({"carryOvers": FieldValue.arrayUnion(jsonCarries)});
    }
    var oldSemester = AuthViewModel.instance.user!.semester!.toLowerCase();
    var oldLevel = AuthViewModel.instance.user!.level!;
    var oldCGPA = userdata["cgpa"] == null
        ? 0.0
        : double.parse(userdata["cgpa"]);


    var newLevel = oldSemester == "Rain".toLowerCase()
        ? (AuthViewModel.instance.user!.level! + 100)
        : AuthViewModel.instance.user!.level!;


    var newSemester =
        oldSemester == "Rain".toLowerCase() ? "Harmattan" : "Rain";
    print(" New level $newLevel");
    print("New Semester $newSemester");
    await firestore
        .collection("users")
        .doc(AuthViewModel.instance.user!.uid)
        .update({
      "level": newLevel,
      "semester": newSemester,
      "cgpa": calculateNewCGPA(
          currentLevel: oldLevel.toString(),
          currentSemester: oldSemester,
          currentCGPA: oldCGPA,
          newGPA: cgpa)
    });
    AuthViewModel.instance.user!.semester = newSemester;
    AuthViewModel.instance.user!.level = newLevel;
  }

  String calculateNewCGPA(
      {required String currentLevel,
      required String currentSemester,
      required double currentCGPA,
      required double newGPA}) {


    int totalSemesters = 0;
    int level = int.parse(currentLevel);

    switch (level) {
      case 100:
        totalSemesters = currentSemester == 'harmattan' ? 0 : 1;
        break;
      case 200:
        totalSemesters = currentSemester == 'harmattan' ? 2 : 3;
        break;
      case 300:
        totalSemesters = currentSemester == 'harmattan' ? 4 : 5;
        break;
      case 400:
        totalSemesters = currentSemester == 'harmattan' ? 6 : 7;
        break;
      case 500:
        totalSemesters = currentSemester == 'harmattan' ? 8 : 9;
        break;
      default:
        totalSemesters = 0; // Default value if the level doesn't match any case
        break;
    }


    print("Total semesters :$totalSemesters");
    print("Total ccgpa :$currentCGPA");
    print("Total newG :$newGPA");

    // Add your calculation logic here based on the new GPA and current CGPA
    double newCGPA =
        ((currentCGPA * totalSemesters) + newGPA) / (totalSemesters + 1);
    return newCGPA.toStringAsFixed(2);
  }

  double getGradePoints(String score) {
    double gradePoints = 0;

    double numericScore = double.tryParse(score) ?? 0;

    if (numericScore >= 70) {
      gradePoints = 5.0;
    } else if (numericScore >= 60) {
      gradePoints = 4.0;
    } else if (numericScore >= 50) {
      gradePoints = 3.0;
    } else if (numericScore >= 45) {
      gradePoints = 2.0;
    } else if (numericScore >= 40) {
      gradePoints = 1.0;
    }

    return gradePoints;
  }
}
