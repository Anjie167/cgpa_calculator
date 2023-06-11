import 'package:flutter/material.dart';
import '../../global widgets/method_widgets.dart';
import '../../utils/console.dart';
import '../../utils/styles.dart';
import '../calculator/models/course.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key, required this.course, required this.gpa});

  final List<Course> course;
  final String gpa;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Details"),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Align(
          alignment: Alignment.topCenter,
            child: Text("GPA: $gpa", style: Styles.title.copyWith(fontSize: 22),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
            itemCount: course.length,
            itemBuilder: (context, index){
              final item = course[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text("Units: ${item.units}"),
                trailing: Text("Score: ${item.score}"),
              );
            }, separatorBuilder: (BuildContext context, int index) { return const Divider(); },
        ),
      ),
    );
  }
}
