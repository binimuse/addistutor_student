// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'dart:io';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

import 'api.dart';

class RemoteServices {
  // ignore: prefer_typing_uninitialized_variables
  static var res, body;
  static List<String> sent = [];

  static Future<String> editPersonalInfo(var data) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "update-profile-student");

    body = json.decode(res.body);

    if (res.statusCode == 200) {
      return res.statusCode.toString();
    } else {
      if (body["message"] != null) {
        return body["message"].toString();
      } else {
        Map<String, dynamic> map = body["errors"];
        map.forEach((key, value) {
          errors.add(value[0].toString());
        });

        return errors.join("\n").toString();
      }
    }
  }

  static Future<Student> fetchpf(var id) async {
    // print("id.toString()");
    //print(id.toString());
    res = await Network().getData("student/${id.toString()}");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      //  print(body);
      return Student.fromJson(body);
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<List<GetLocation>> getlocation() async {
    // print("id.toString()");
    //print(id.toString());
    res = await Network().getData("location");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body
          .map((e) => GetLocation.fromJson(e))
          .toList()
          .cast<GetLocation>();
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<bool> uploadImage(File image, String id) async {
    // ignore: unnecessary_null_comparison

    print("object");
    print(image.toString());
    print(id);
    if (image != null) {
      // ignore: deprecated_member_use
      var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
      var length = await image.length();
      // create multipart request
      res = await Network()
          .uploadFile("student/${id}/updateProfile", image, stream, length);

      if (res.statusCode == 200) {
        res.stream.transform(utf8.decoder).listen((value) {});
        return true;
      } else {
        throw Exception('Failed to Upload file' + res.statusCode.toString());
      }
    } else {
      return false;
    }
  }

  static Future<List<GetEducationlevel>> geteducation() async {
    // print("id.toString()");
    //print(id.toString());
    res = await Network().getData("tutoring-level");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => GetEducationlevel.fromJson(e))
          .toList()
          .cast<GetEducationlevel>();
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<List<GetSubject>> getsubject(var id) async {
    // print("id.toString()");
    //print(id.toString());
    res = await Network().getData("subjects?tutoring_level_id=${id}");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => GetSubject.fromJson(e))
          .toList()
          .cast<GetSubject>();
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<List<Search>> search(
      var locationid, var subjectid, var gender) async {
    res = await Network().getData(
        "tutors?location_id=${locationid}&subject_id=${subjectid}&gender=${gender}");
    //  res = await Network().getData("tutors?location_id=l&subject_id=2");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      print(body["data"]);
      return body["data"]
          .map((e) => Search.fromJson(e))
          .toList()
          .cast<Search>();

      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }
}
