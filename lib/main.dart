import 'package:cgpa_calcultor/core/auth/views/sign_in_screen.dart';
import 'package:cgpa_calcultor/core/auth/views/sign_up_screen.dart';
import 'package:cgpa_calcultor/core/calculator/views/calculator.dart';
import 'package:cgpa_calcultor/core/profile/views/profile_screen.dart';
import 'package:cgpa_calcultor/core/students/views/students_screen.dart';
import 'package:cgpa_calcultor/count_down.dart';
import 'package:cgpa_calcultor/utils/theme/custom_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/Splash/View/splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      routes: {
        "sign_up": (context)=> const SignUpScreen(),
        "sign_in": (context)=> const LoginScreen(),
        "splash": (context)=> const SplashScreen(),
        "profile": (context)=> const ProfileScreen(),
        "students": (context)=> const StudentsScreen()
      },
      initialRoute: "splash",
      // home: Scaffold(body: Center(child:
      // CountdownWidget(
      //   time: DateTime.now().copyWith(minute: 31),
      //   color: const Color(0xFFC57979),
      //   width: 300,
      //   height: 70,
      // ))),
    );
  }
}
