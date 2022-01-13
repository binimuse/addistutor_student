import 'dart:convert';

import 'dart:io';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

import 'api.dart';

class RemoteServices {
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
    print(id.toString());
    res = await Network().getData("student/${id.toString()}");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      print(body);
      return Student.fromJson(body);
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }
}
