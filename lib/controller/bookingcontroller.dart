// ignore_for_file: non_constant_identifier_names, duplicate_ignore, prefer_typing_uninitialized_variables, avoid_print, avoid_web_libraries_in_flutter, unused_import, unnecessary_overrides, deprecated_member_use, empty_catches, prefer_const_constructors

import 'dart:convert';

import 'package:addistutor_student/Screens/Login/components/body.dart';
import 'package:addistutor_student/Screens/Login/login_screen.dart';
import 'package:addistutor_student/Screens/Profile/profile.dart';
import 'package:addistutor_student/Screens/main/main.dart';
import 'package:addistutor_student/Screens/search/components/searchscreen.dart';
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
  late int? subjectid = 1;
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
  List<String> daylist = [];
  var day0;
  var day1;
  var day2;
  var day3;
  var day4;
  var day5;
  var day6;
  var day0time;
  var day1time;
  var day2time;
  var day3time;
  var day4time;
  var day5time;
  var day6time;

  var fetched;
  late var isValid;
  void Booking(BuildContext context, int id) async {
    teacherid = id.toString();
    if (ismonday) {
      day0 = "monday";
      selecteddate.add(day0);
    }
    if (istue) {
      day0 = "Tuesday";
      selecteddate.add(day0);
    }

    if (iswen) {
      day0 = "wednesday";
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
      day3 = selecteddate[3];
      day4 = selecteddate[4];
      day5 = selecteddate[5];
      day6 = selecteddate[6];
    } catch (e) {
      // selecteddate.clear();
    }

    if (day0 == "monday") {
      day0time = motime;
    } else if (day0 == "Tuesday") {
      day0time = tuetime2;
    } else if (day0 == "wednesday") {
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

    if (day1 == "monday") {
      day1time = motime;
    } else if (day1 == "Tuesday") {
      day1time = tuetime2;
    } else if (day1 == "wednesday") {
      day1time = wentime3;
    } else if (day1 == "Thursday") {
      day1time = thetime4;
    } else if (day1 == "Friday") {
      day1time = fritime5;
    } else if (day1 == "Saterday") {
      day1time = sattime;
    } else if (day1 == "Sunday") {
      day1time = suntime2;
    }

    if (day2 == "monday") {
      day2time = motime;
    } else if (day2 == "Tuesday") {
      day2time = tuetime2;
    } else if (day2 == "wednesday") {
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

    if (day3 == "monday") {
      day3time = motime;
    } else if (day3 == "Tuesday") {
      day3time = tuetime2;
    } else if (day3 == "wednesday") {
      day3time = wentime3;
    } else if (day3 == "Thursday") {
      day3time = thetime4;
    } else if (day3 == "Friday") {
      day3time = fritime5;
    } else if (day3 == "Saterday") {
      day3time = sattime;
    } else if (day3 == "Sunday") {
      day3time = suntime2;
    }

    if (day4 == "monday") {
      day4time = motime;
    } else if (day4 == "Tuesday") {
      day4time = tuetime2;
    } else if (day4 == "wednesday") {
      day4time = wentime3;
    } else if (day4 == "Thursday") {
      day4time = thetime4;
    } else if (day4 == "Friday") {
      day4time = fritime5;
    } else if (day4 == "Saterday") {
      day4time = sattime;
    } else if (day4 == "Sunday") {
      day4time = suntime2;
    }

    if (day5 == "monday") {
      day5time = motime;
    } else if (day5 == "Tuesday") {
      day5time = tuetime2;
    } else if (day5 == "wednesday") {
      day5time = wentime3;
    } else if (day5 == "Thursday") {
      day5time = thetime4;
    } else if (day5 == "Friday") {
      day5time = fritime5;
    } else if (day5 == "Saterday") {
      day5time = sattime;
    } else if (day5 == "Sunday") {
      day5time = suntime2;
    }

    if (day6 == "monday") {
      day6time = motime;
    } else if (day6 == "Tuesday") {
      day6time = tuetime2;
    } else if (day6 == "wednesday") {
      day6time = wentime3;
    } else if (day6 == "Thursday") {
      day6time = thetime4;
    } else if (day6 == "Friday") {
      day6time = fritime5;
    } else if (day6 == "Saterday") {
      day6time = sattime;
    } else if (day6 == "Sunday") {
      day6time = suntime2;
    }

    //cheak

    print(daylist);
    print(selecteddate);

    if (selecteddate.every((element) => daylist.contains(element))) {
      await seteditInfo(context);
      // daylist.clear();
    } else {
      scaffoldKey.currentState!.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
              "Tutor not avalble in the selected days please try to change the selected to :  " +
                  daylist.toString())));

      //  daylist.clear();
    }
  }

  var image;
  late List<Dateandtime> tags = [];
  Future<void> seteditInfo(BuildContext context) async {
    // openAndCloseLoadingDialog(context);
    try {
      if (day1 == null) {
        tags = [
          Dateandtime(day0, day0time),
        ];
      } else if (day2 == null) {
        tags = [
          Dateandtime(day0, day0time),
          Dateandtime(day1, day1time),
        ];
      } else if (day3 == null) {
        tags = [
          Dateandtime(day0, day0time),
          Dateandtime(day1, day1time),
          Dateandtime(day2, day2time),
        ];
      } else if (day4 == null) {
        tags = [
          Dateandtime(day0, day0time),
          Dateandtime(day1, day1time),
          Dateandtime(day2, day2time),
          Dateandtime(day3, day3time),
        ];
      } else if (day5 == null) {
        tags = [
          Dateandtime(day0, day0time),
          Dateandtime(day1, day1time),
          Dateandtime(day2, day2time),
          Dateandtime(day3, day3time),
          Dateandtime(day4, day4time),
        ];
      } else if (day6 == null) {
        tags = [
          Dateandtime(day0, day0time),
          Dateandtime(day1, day1time),
          Dateandtime(day2, day2time),
          Dateandtime(day3, day3time),
          Dateandtime(day4, day4time),
          Dateandtime(day5, day5time),
        ];
      } else {
        tags = [
          Dateandtime(day0, day0time),
          Dateandtime(day2, day2time),
          Dateandtime(day3, day3time),
          Dateandtime(day4, day4time),
          Dateandtime(day5, day5time),
          Dateandtime(day6, day6time),
        ];
      }
    } catch (e) {}

    String jsonTags = jsonEncode(tags);

    var data = {
      "session": sessionsd.value,
      "subject_id": subjectid,
      "teacher_id": teacherid,
      'dates': jsonTags.toString()
    };

    print(data);

    inforesponse = await RemoteServices.booking(data);

    if (inforesponse.toString() == "200") {
      closeDialog(true, inforesponse);
      tags.clear();
      data.clear();
      isLoading(false);
    } else {
      print("noo");
      tags.clear();
      data.clear();
      closeDialog(
        false,
        inforesponse,
      );
    }
  }

// openAndCloseLoadingDialog() {

// }

  closeDialog(
    bool stat,
    String data,
  ) {
    Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator

    if (stat == false) {
      scaffoldKey.currentState!.showSnackBar(
          SnackBar(content: Text(data + "Not successfully  Booked")));
    } else {
      // ignore: deprecated_member_use
      isLoading(false);
      //Navigator.of(context).pop(true);
      scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: const Text(
            "Sucessfully Booked Tutor \nplease go to notification page for any updateds"),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Navigator.push(
            //   Get.context!,
            //   MaterialPageRoute(builder: (context) => const SerachPage()),
            // );
          },
        ),
        backgroundColor: kPrimaryColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(50),
        elevation: 30,
      ));
      //  editstudentid(context);
    }
  }
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
