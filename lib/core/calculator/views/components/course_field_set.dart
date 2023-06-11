import 'package:cgpa_calcultor/utils/global.dart';
import 'package:flutter/material.dart';

import '../../models/course.dart';

class CourseFieldSet extends StatelessWidget {
  final Course course;

  const CourseFieldSet({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    var w = Global.getWidth(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: w*0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Course Name',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  initialValue: course.name,
                  onChanged: (value) {
                    course.name = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter course name',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: w*0.2,
            child: Column(
              children: [
                const Text(
                  'Units',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: course.units.toString(),
                  onChanged: (value) {
                    course.units = value!.toString();
                  },
                  items: ["1", "2", "3", "4", "5", "0"]
                      .map(
                        (unit) => DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    ),
                  )
                      .toList(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Select units',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: w*0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Score',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  initialValue: course.score,
                  onChanged: (value) {
                    course.score = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter score',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
