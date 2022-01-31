// ignore_for_file: non_constant_identifier_names, duplicate_ignore, prefer_typing_uninitialized_variables, avoid_print, avoid_web_libraries_in_flutter

import 'dart:convert';

import 'package:addistutor_student/Screens/Login/components/body.dart';
import 'package:addistutor_student/Screens/Login/login_screen.dart';
import 'package:addistutor_student/Screens/Profile/profile.dart';
import 'package:addistutor_student/Screens/main/main.dart';
import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingeController extends GetxController with StateMixin {
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> book = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // ignore: prefer_typing_uninitialized_variables
  var inforesponse;
  var isLoading = false.obs;
  // ignore: non_constant_identifier_names

  var sessionsd = "3".obs;

  late var Mon = "Monday";
  late var Tue = "";
  late var Wed = "";
  late var Thu = "";
  late var Fri = "";
  late var Sat = "";
  late var Sun = "";
  late int subjectid = 0;
  late String teacherid = "";

  late var motime = '16:30';
  late var tuetime2 = "16:30";
  late var wentime3 = "16:30";
  late var thetime4 = "16:30";

  late var fritime5 = "16:30";

  late var suntime2 = "09:00";
  late var sattime = '09:00';

  bool ismonday = false;
  bool istue = false;
  bool iswen = false;
  bool isthe = false;
  bool isfri = false;
  bool issat = false;
  bool issun = false;

  late var days = "Mon".obs;
  late var days2 = "Mon".obs;
  late var days3 = "Mon".obs;

  final List<String> daylist = [];

  GetLocation? locaion;
  late var education = "Primary".obs;
  var date2 = "".obs;
  var id;
  //GetLocation? selectedModel;
  var studyperpose = "Regular support".obs;
  late var Grade = "".obs;
  late TextEditingController About;
  // ignore: non_constant_identifier_names
  late var is_parent = false.obs;
  var isFetched = false.obs;
  var ifupdatd = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  List<String> selecteddate = [];
  var day0;
  var day1;
  var day2;
  var day0time;
  var day1time;
  var day2time;

  var fetched;
  late var isValid;
  void Booking(BuildContext context, int id) async {
    teacherid = id.toString();
    if (ismonday) {
      day0 = "Monday";
      selecteddate.add(day0);
    }
    if (istue) {
      day0 = "Tuesday";
      selecteddate.add(day0);
    }

    if (iswen) {
      day0 = "Wensday";
      selecteddate.add(day0);
    }

    if (isthe) {
      day0 = "Thursday";
      selecteddate.add(day0);
    }

    if (isfri) {
      day0 = "Friday";
      selecteddate.add(day0);
    }

    if (issat) {
      day0 = "Saterday";
      selecteddate.add(day0);
    }
    if (issun) {
      day0 = "Sunday";
      selecteddate.add(day0);
    }

    try {
      day0 = selecteddate[0];
      day1 = selecteddate[1];
      day2 = selecteddate[2];
    } catch (e) {
      selecteddate.clear();
    }

    if (day0 == "Monday") {
      day0time = motime;
    } else if (day0 == "Tuesday") {
      day0time = tuetime2;
    } else if (day0 == "Wensday") {
      day0time = wentime3;
    } else if (day0 == "Thursday") {
      day0time = thetime4;
    } else if (day0 == "Friday") {
      day0time = fritime5;
    } else if (day0 == "Saterday") {
      day0time = sattime;
    } else if (day0 == "Sunday") {
      day0time = suntime2;
    }

    if (day1 == "Monday") {
      day1time = motime;
    } else if (day1 == "Tuesday") {
      day1time = tuetime2;
    } else if (day1 == "Wensday") {
      day1time = wentime3;
    } else if (day1 == "Thursday") {
      day1time = thetime4;
    } else if (day1 == "Friday") {
      day1time = fritime5;
    } else if (day1 == "Saterday") {
      day1time = sattime;
    } else if (day0 == "Sunday") {
      day1time = suntime2;
    }

    if (day2 == "Monday") {
      day2time = motime;
    } else if (day2 == "Tuesday") {
      day2time = tuetime2;
    } else if (day2 == "Wensday") {
      day2time = wentime3;
    } else if (day2 == "Thursday") {
      day2time = thetime4;
    } else if (day2 == "Friday") {
      day2time = fritime5;
    } else if (day2 == "Saterday") {
      day2time = sattime;
    } else if (day2 == "Sunday") {
      day2time = suntime2;
    }

    // print(sessionsd.value);
    // print(day0);
    // print(day0time);
    // print(day1);
    // print(day1time);
    // print(day2);
    // print(day2time);
    // print(subjectid.toString());
    // print(teacherid.toString());

    await seteditInfo(context);
  }

  var image;

  Future<void> seteditInfo(BuildContext context) async {
    // openAndCloseLoadingDialog(context);

    List<Dateandtime> tags = [
      Dateandtime(day0, day0time),
      Dateandtime(day1, day1time),
      Dateandtime(day2, day2time)
    ];
    String jsonTags = jsonEncode(tags);
    print(jsonTags.toString());
    var data = {
      "session": "3",
      "subject_id": "1",
      "teacher_id": teacherid,
      'dates': jsonTags.toString()
      // "session": sessionsd.value,
      // "day[0]": day0,
      // "time[0]": day0time,
      // "day[1]": day1,
      // "time[1]": day1time,
      // "subject_id": subjectid,
      // "teacher_id": teacherid,
    };

    inforesponse = await RemoteServices.booking(data);

    if (inforesponse.toString() == "200") {
      closeDialog(true, '', context);
      isLoading(false);
    } else {
      print("noo");
      closeDialog(false, inforesponse, context);
    }
  }

// openAndCloseLoadingDialog() {

// }

  closeDialog(bool stat, String data, BuildContext context) {
    Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    //Navigator.of(context).pop();
    if (stat == false) {
      scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text("Not successfully  Booked")));
    } else {
      // ignore: deprecated_member_use
      isLoading(false);
      //Navigator.of(context).pop(true);
      scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(
            "Sucessfully Booked Tutor \nplease go to notification page for any updateds"),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
        backgroundColor: kPrimaryColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(50),
        elevation: 30,
      ));
      //  editstudentid(context);
    }
  }

  openSnackBaredit(BuildContext context) async {
    scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("Booking "),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
      backgroundColor: kPrimaryColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(50),
      elevation: 30,
    ));
  }

  var body;
  Future<void> editstudentid(BuildContext context) async {}

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide a valid Email";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "please Provide a name";
    }
    return null;
  }
}

void openAndCloseLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.grey.withOpacity(0.3),
    builder: (_) => WillPopScope(
      onWillPop: () async => false,
      child: const Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            color: kPrimaryColor,
            strokeWidth: 8,
          ),
        ),
      ),
    ),
  );
}

class Dateandtime {
  String date;
  String time;

  Dateandtime(this.date, this.time);

  Map toJson() {
    return {
      'day': date,
      'time': time,
    };
  }
}
