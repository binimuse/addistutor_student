// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_null_comparison, deprecated_member_use, duplicate_ignore

import 'dart:convert';

import 'dart:io';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/cupertino.dart';
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
      return Student.fromJson(body);
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<List<GetLocation>> getlocation() async {
    // print("id.toString()");
    //print(id.toString());
    res = await Network().getData("address?with_address=true");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body
          .map((e) => GetLocation.fromJson(e))
          .toList()
          .cast<GetLocation>();
    } else {
      throw Exception('Failed to load location' + res.statusCode.toString());
    }
  }

  static Future<List<GetLocationforedit>> getlocationforedit() async {
    // print("id.toString()");
    //print(id.toString());
    res = await Network().getData("address?with_address=true");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body
          .map((e) => GetLocationforedit.fromJson(e))
          .toList()
          .cast<GetLocationforedit>();
    } else {
      throw Exception('Failed to load location' + res.statusCode.toString());
    }
  }

  static Future<bool> uploadImage(File image, String id) async {
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
        "tutors?address_id=${locationid}&subject_id=${subjectid}&gender=${gender}");

    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => Search.fromJson(e))
          .toList()
          .cast<Search>();

      // return User.fromJson(jsonDecode(body["data"]));
    } else {
      throw Exception('Failed to load Users');
    }
  }

  static Future<String> booking(var data) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "booking");

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

  static Future<List<Day>> getAvalbledate(var id) async {
    // print("id.toString()");

    res = await Network().getData("teacher/${id}/availability");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"].map((e) => Day.fromJson(e)).toList().cast<Day>();
    } else {
      throw Text('Failed to load Days');
    }
  }

  static Future<List<RequestedBooking>> getrequestedbooking(
      var id, var status) async {
    res = await Network().getData("student/${id}/bookings?status=${status}");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => RequestedBooking.fromJson(e))
          .toList()
          .cast<RequestedBooking>();
    } else {
      throw Exception('Failed to load Comment');
    }
  }

  static Future<String> feedback(var data) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "feedback");

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

  static Future<ContactUS> contactus() async {
    res = await Network().getData("contact-us");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return ContactUS.fromJson(body["data"]);
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<String> updatepass(
    var data,
  ) async {
    List<String> errors = [];

    res = await Network().getpassedData(data, "change-password");
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

  static Future<String> rating(var data, var bId) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "rating/${bId}");

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

  static Future<List<Notifications>> getActivity() async {
    res = await Network().getData("student-notification");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => Notifications.fromJson(e))
          .toList()
          .cast<Notifications>();
    } else {
      throw Exception('Failed to load Comment');
    }
  }

  static Future<Qr> getqr(var bId) async {
    // print("id.toString()");
    //print(id.toString());
    res = await Network().getData("booking/${bId}/qr-code");

    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      //  print(body);
      return Qr.fromJson(body);
    } else {
      throw Exception('Failed to load Qr' + res.statusCode.toString());
    }
  }

  static Future<String> forgott(
    var data,
  ) async {
    List<String> errors = [];

    res = await Network().getpassedData(data, "password/email");
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

  static Future<List<Search>> getpopular() async {
    res = await Network().getData("top-tutors");
    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => Search.fromJson(e))
          .toList()
          .cast<Search>();
    } else {
      throw Exception('Failed to load Comment');
    }
  }

  static Future<RequestedBooking> getsinglebooking(var bId) async {
    res = await Network().getData("booking/${bId}");

    var body = json.decode(res.body);

    if (res.statusCode == 200) {
      return RequestedBooking.fromJson(body["data"]);
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<String> wallet(File image, var data, var id) async {
    // create multipart request
    var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    res = await Network()
        .postFile2("student-wallet/${id}/deposit", image, data, stream, length);

    if (res.statusCode == 200) {
      res.stream.transform(utf8.decoder).listen((value) {});

      return res.statusCode.toString();
    } else {
      throw Exception("can't");
    }
  }

  static Future<Balance> balance(var id) async {
    res = await Network().getData("student-wallet/${id}/balance");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return Balance.fromJson(body["data"]);
    } else {
      throw Exception('Failed to load balance' + res.statusCode.toString());
    }
  }

  static Future<List<Transaction>> transaction(var id) async {
    res = await Network().getData("student-wallet/${id}/transaction");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return body["data"]
          .map((e) => Transaction.fromJson(e))
          .toList()
          .cast<Transaction>();
    } else {
      throw Exception('Failed to load transaction');
    }
  }

  static Future<String> endbooking(var endingReason, var id) async {
    var data = {
      'ending_reason': endingReason,
    };
    res = await Network().getpassedData(data, "booking/${id}/end");
    body = json.decode(res.body);
    // ignore: avoid_print

    if (res.statusCode == 200) {
      return body["success"].toString();
    } else {
      throw Exception('Failed to send  Mesaage');
    }
  }

  static Future<Myaccount> getmyaacount() async {
    res = await Network().getData("my-account");

    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      return Myaccount.fromJson(body["data"]);
    } else {
      throw Exception('Failed to load User' + res.statusCode.toString());
    }
  }

  static Future<String> otp(var data) async {
    List<String> errors = [];
    // create multipart request
    res = await Network().getpassedData(data, "verify-account");

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
}
