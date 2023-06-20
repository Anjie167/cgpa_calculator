import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String id = DateTime.now().millisecondsSinceEpoch.toString();
  String name;
  String units;
  String score;


  Course({this.name = '', this.units = "0", this.score = "0"});
  

  factory Course.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Course(
      name: data['name'] ?? '',
      units: data['units'] ?? '0',
      score: data['score'] ?? '',
    );
  }

  factory Course.fromJson(snapshot) {
    Map<String, dynamic> data = snapshot as Map<String, dynamic>;
    return Course(
      name: data['name'] ?? '',
      units: data['units'] ?? '0',
      score: data['score'] ?? '',
    );
  }
  // Convert the Course object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'units': units,
      'score': score,
    };
  }
}
