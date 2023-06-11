import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? uid;
  String firstName;
  String lastName;
  String email;
  String role;
  String? semester;
  int? level;

  String phoneNumber;
  String? matricNumber; // Nullable field for students
  String? cgpa; // Nullable field for students

  UserData({
    this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    this.matricNumber,
    this.level,
    this.semester,
    this.cgpa,
  });

  factory UserData.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserData(
      uid: data["uid"],
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      role: data["role"],
      semester: data["semester"],
      level: data["level"],
      phoneNumber: data['phoneNumber'],
      matricNumber: data['matricNumber'],
      cgpa: data['cgpa'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      "role": role,
      "semester": semester,
      "level": level,
      'phoneNumber': phoneNumber,
      'matricNumber': matricNumber,
      'cgpa': cgpa,
    };
  }
}
