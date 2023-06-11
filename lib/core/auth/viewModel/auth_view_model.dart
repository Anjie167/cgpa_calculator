import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../utils/console.dart';
import '../models/auth.dart';

class AuthViewModel {

  AuthViewModel._();
  static final AuthViewModel instance = AuthViewModel._();
  UserData? user;


  Future<void> signUp(BuildContext context, UserData userData, password) async {
      UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(
        email: userData.email,
        password: password, // Set a default password for simplicity
      );

      String uid = userCredential.user!.uid;
      CollectionReference usersCollection = firestore.collection("users");

      userData.uid = uid;
      await usersCollection.doc(uid).set(userData.toMap());

  }

  Future<UserData?> login(BuildContext context, email, password) async {
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;
      DocumentSnapshot userDataSnapshot = await firestore
          .collection('users')
          .doc(uid)
          .get();
      Console.log(userDataSnapshot["email"]);

      UserData userData = UserData.fromSnapshot(userDataSnapshot);
      user = userData;
      return userData;
    }catch(e){
      return null;
    }
  }

  Future<void> signOut (context)async{
    await auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, "sign_in", (route) => false);
  }


}