import 'package:cgpa_calcultor/core/auth/models/auth.dart';
import 'package:cgpa_calcultor/core/auth/viewModel/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../main.dart';
import '../../../utils/console.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      bool isLogged = false;
      if (event != null) {
        isLogged = true;
      }
      Future.delayed(const Duration(seconds: 2)).then((value) async {
        if (isLogged) {
          await firestore
              .collection('users')
              .where("email", isEqualTo: event!.email)
              .get()
              .then((userDataSnapshot) {
            UserData userData =
                UserData.fromSnapshot(userDataSnapshot.docs.first);
            AuthViewModel.instance.user = UserData(
              uid: userData.uid,
                firstName: userData.firstName,
                lastName: userData.lastName,
                email: userData.email,
                level: userData.level,
                semester: userData.semester,
                matricNumber: userData.matricNumber,
                phoneNumber: userData.phoneNumber,
                role: userData.role);
            Console.log(userData.email);
            if(userData.role == "student"){
              Navigator.pushReplacementNamed(context, "profile");
            }else{
              Navigator.pushReplacementNamed(context, "students");
            }
              });
        } else {
          Navigator.pushReplacementNamed(context, "sign_in");
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 30),
                      children: [
                    TextSpan(
                        text: "CGPA",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color)),
                    TextSpan(
                        text: "Calculator",
                        style: TextStyle(color: Theme.of(context).primaryColor))
                  ])),
              LoadingAnimationWidget.waveDots(color: Colors.grey, size: 30),

              // Image.asset(
              //   Images.logo,
              //   fit: BoxFit.cover,
              //   width: MediaQuery.of(context).size.width * 0.8,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
