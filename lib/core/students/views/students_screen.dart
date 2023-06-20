import 'package:cgpa_calcultor/core/auth/models/auth.dart';
import 'package:cgpa_calcultor/core/profile/views/profile_screen.dart';
import 'package:cgpa_calcultor/main.dart';
import 'package:cgpa_calcultor/utils/extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../global widgets/animated_search_bar.dart';
import '../../../utils/global.dart';
import '../../auth/viewModel/auth_view_model.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final TextEditingController searchController = TextEditingController();
  List<UserData> searchList = [];
  List<UserData> allStudents = [];

  @override
  void initState() {
    searchController.addListener(() {
      setState(() {
        searchList = allStudents.where((element) {
          return element.matricNumber!
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              element.firstName
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              element.lastName
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase());
        }).toList();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = Global.getHeight(context);
    var w = Global.getWidth(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox(),
        centerTitle: true,
        title: Text(
          'Students',
          style: TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.w700),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                AuthViewModel.instance.signOut(context);
              },
              child: const Icon(Icons.logout))
          // Row(
          //   children: [
          //     IconButton(
          //       onPressed: () {},
          //       icon: const Icon(
          //         Icons.search,
          //         color: Colors.grey,
          //       ),
          //     ),
          //   ],
          // )
        ],
        iconTheme: const IconThemeData(color: Colors.grey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            StreamBuilder(
              stream: firestore
                  .collection("users")
                  .where("role", isEqualTo: "student")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 40),
                      itemCount: searchController.text.isNotEmpty ? searchList.length : snapshot.data!.docs.length,
                      itemBuilder: (ctx, i) {
                        List<UserData> students = snapshot.data!.docs
                            .map((e) => UserData.fromSnapshot(e))
                            .toList();
                        allStudents = students;
                        UserData student = searchController.text.isNotEmpty ? searchList[i] : students[i];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileScreen(user: student)));
                          },
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  "https://i.postimg.cc/x8khcwc7/Joe-Biden-presidential-portrait.jpg"),
                            ),
                            title: Text(
                              "${student.firstName} ${student.lastName}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            subtitle: Text(
                              student.matricNumber ?? "",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: Text("No Registered Students"),
                  );
                }
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10),
                    child: AnimatedSearchBar(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.7),
                                fontSize: 17),
                            hintText: "Search students",
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
