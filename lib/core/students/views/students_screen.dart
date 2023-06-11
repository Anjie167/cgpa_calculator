import 'package:cgpa_calcultor/core/auth/models/auth.dart';
import 'package:cgpa_calcultor/core/profile/views/profile_screen.dart';
import 'package:cgpa_calcultor/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../auth/viewModel/auth_view_model.dart';
import '../models/student_class.dart';


class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {


    List<StudentClass> studentList = [
      StudentClass(
          id: 's1',
          name: 'Donald Trump',
          matricNo: 'CSC/2017/001',
          imageUrl:
              'https://i.postimg.cc/pdHH3Lpd/Donald-Trump-official-portrait.jpg'),
      StudentClass(
          id: 's2',
          name: 'Joe Biden',
          matricNo: 'CSC/2017/002',
          imageUrl:
              'https://i.postimg.cc/x8khcwc7/Joe-Biden-presidential-portrait.jpg')
    ];


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            AuthViewModel.instance.signOut(context);
          },
            child: const Icon(Icons.logout)
        ),
        centerTitle: true,
        title: Text(
          'Students',
          style: TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.w700),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder(
          stream: firestore.collection("users").where("role", isEqualTo: "student").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, i){
                  UserData student = snapshot.data!.docs.map((e) => UserData.fromSnapshot(e)).toList()[i];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen(
                        user: student
                      )));
                    },
                    child: ListTile(
                    leading: CircleAvatar(radius: 35,
                      backgroundImage: NetworkImage(studentList[i].imageUrl),
                    ),
                    title: Text(
                      "${student.firstName} ${student.lastName}",
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Text(
                      student.matricNumber ?? "",
                      style: const TextStyle(fontSize: 12),
                    ),
                ),
                  );}
              );
            }else{
              return const Center(child: Text("No Registered Students"),);
            }
          },
        ),
      ),
    );
  }
}
