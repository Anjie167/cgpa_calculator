import 'package:cgpa_calcultor/core/auth/models/auth.dart';
import 'package:cgpa_calcultor/core/auth/viewModel/auth_view_model.dart';
import 'package:cgpa_calcultor/core/calculator/models/course.dart';
import 'package:cgpa_calcultor/core/calculator/views/calculator.dart';
import 'package:cgpa_calcultor/core/course/course_screen.dart';
import 'package:cgpa_calcultor/global%20widgets/method_widgets.dart';
import 'package:cgpa_calcultor/main.dart';
import 'package:cgpa_calcultor/utils/colors.dart';
import 'package:cgpa_calcultor/utils/extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../calculator/models/results.dart';


final helloWorldProvider = Provider<String>((_) => "Hello world");

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.user});
  final UserData? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Home", trailIcon: AuthViewModel.instance.user!.role == "student"
          ? GestureDetector(
        onTap: (){
          AuthViewModel.instance.signOut(context);
        },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.logout, color: Colors.black,),
          )) : null, leadIcon: AuthViewModel.instance.user!.role == "student" ? const SizedBox() : null),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Consumer(
                    //     builder: (_, ref, __) {
                    //       final helloWorld = ref.watch(helloWorldProvider);
                    //       return customAppBar(context, title: helloWorld);
                    //     }
                    // ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.grey.withOpacity(0.3),
                          backgroundImage: const NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_IL7rrxG16RZZctgVpd0BAcq9YQEhUlyA7s5HkayHSw&s'),
                        ),
                        10.0.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user != null ? "${user!.firstName} ${user!.lastName}" : "${AuthViewModel.instance.user!.firstName} ${AuthViewModel.instance.user!.lastName}",
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              user != null ? user!.matricNumber ?? "" : AuthViewModel.instance.user!.matricNumber ?? "",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                            5.0.height,
                            Text(
                              user != null ? "${user!.cgpa ?? 0.0} CGPA" :'${AuthViewModel.instance.user!.cgpa ?? 0.0} CGPA',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              user != null ? "${user!.level} level, ${user!.semester} semester" :'${AuthViewModel.instance.user!.level} level, ${AuthViewModel.instance.user!.semester} semester',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text(
                    //   'About',
                    //   style: TextStyle(
                    //     fontSize: 20.0,
                    //     color: Colors.grey,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // const SizedBox(height: 10.0),
                    // const Text(
                    //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    //   style: TextStyle(
                    //     fontSize: 16.0,
                    //   ),
                    // ),
                    20.0.height,
                    const Text(
                      'Experience',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    StreamBuilder(
                      stream:firestore.collection("results").doc(user != null ? user!.uid : AuthViewModel.instance.user!.uid!).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                        if(snapshot.hasData){
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.data()!["results"].length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i){
                              var data = snapshot.data!.data()!["results"];
                              Result result = data.map((e){
                                return Result.fromSnapshot(e);
                              }).toList()[i];
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CourseScreen(course: result.courses as List<Course>, gpa: result.gpa.toString(),)));
                                  },
                                child: ListTile(
                                  leading: const Icon(Icons.work),
                                  title: Text('${result.level} Level'),
                                  subtitle: Text('${result.semester} Semester'),
                                  trailing: Text('${result.gpa} GPA'),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(),
                            ),);
                        }else{
                          return const Center(child: Text("No Data"),);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
        floatingActionButton: AuthViewModel.instance.user!.role == "student" ? FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const CGPACalculator()));
          },
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          child: const Icon(Icons.edit),
        ) : null
    );
  }
}
