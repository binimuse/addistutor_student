import 'package:get/get.dart';

class Student {
  int id;

  String parent_first_name;
  String parent_last_name;
  String first_name;

  String last_name;
  String phone_no;
  String email;
  String gender;
  String birth_date;
  String location;

  String grade;
  String study_purpose;
  String about;

  Student({
    required this.id,
    required this.parent_first_name,
    required this.parent_last_name,
    required this.first_name,
    required this.last_name,
    required this.phone_no,
    required this.email,
    required this.gender,
    required this.birth_date,
    required this.location,
    required this.grade,
    required this.study_purpose,
    required this.about,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json["id"] as int,
      parent_first_name: json["parent_first_name"],
      parent_last_name: json["parent_last_name"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      phone_no: json["phone_no"],
      email: json["email"],
      gender: json["gender"],
      birth_date: json["birth_date"],
      location: json["location"],
      grade: json["grade"],
      study_purpose: json["study_purpose"],
      about: json["about"],
    );
  }
}
