import 'dart:convert';

import 'package:cgpa_calcultor/core/auth/viewModel/auth_view_model.dart';
import 'package:cgpa_calcultor/core/calculator/models/results.dart';
import 'package:cgpa_calcultor/global%20widgets/common_button.dart';
import 'package:cgpa_calcultor/main.dart';
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

  calculateGPA() async{
    double totalGradePoints = 0;
    int totalUnits = 0;
    for (var course in courses) {
      var unit = int.parse(course.units);
      if (unit > 0 && course.score.isNotEmpty) {
        totalGradePoints += unit * getGradePoints(course.score);
        totalUnits += unit;
      }
    }
    double gpa = double.parse((totalGradePoints / totalUnits).toStringAsFixed(2));
    await updateInDatabase(gpa);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Your GPA for the semester is: $gpa'),
      ),
    );
  }

  updateInDatabase(cgpa)async{
    Result result = Result(
        level: AuthViewModel.instance.user!.level!,
        semester: AuthViewModel.instance.user!.semester!,
        gpa: cgpa,
        courses: jsonEncode(courses));
    var oldData = await firestore.collection("results").doc(AuthViewModel.instance.user!.uid).get();
    if(!oldData.exists){
      await firestore.collection("results").doc(AuthViewModel.instance.user!.uid).set(
          {
            "results" : [result.toJson()]
          });
    }else {
      firestore.collection("results").doc(AuthViewModel.instance.user!.uid).set(
          {
            "results": [
              ...oldData["results"],
              result.toJson()
            ]
          });
    }


    var newLevel = AuthViewModel.instance.user!.semester!.toLowerCase() == "Rain".toLowerCase() ? (AuthViewModel.instance.user!.level! + 100) : AuthViewModel.instance.user!.level!;
   var newSemester = AuthViewModel.instance.user!.semester!.toLowerCase() == "Rain".toLowerCase() ? "Harmattan" : "Rain";
    print(newLevel);
    print(newSemester);
   await firestore.collection("users").doc(AuthViewModel.instance.user!.uid).update({
      "level": newLevel,
      "semester": newSemester
    });
   AuthViewModel.instance.user!.semester = newSemester;
   AuthViewModel.instance.user!.level = newLevel;
  }


  forAll(){
    // double totalCreditPoints = 0;
    // int totalUnits = 0;
    // for (var semester in semesters) {
    //   double totalCreditPoints += total credit points for semester;
    //   int semesterUnits += total units for semester;
  // }
  //
  // double cgpa = totalCreditPoints / totalUnits;
  // return cgpa;
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
