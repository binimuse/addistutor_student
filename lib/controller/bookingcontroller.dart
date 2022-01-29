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
  late TextEditingController parent_first_name;
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController parent_last_name;
  late TextEditingController phone;
  late TextEditingController email;

  late var sessions = "3".obs;

  late TextEditingController Mon;
  late TextEditingController Tue;
  late TextEditingController Wed;
  late TextEditingController Thu;
  late TextEditingController Fri;
  late TextEditingController Sat;
  late TextEditingController Sun;

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
    parent_first_name = TextEditingController();
    parent_last_name = TextEditingController();
    firstname = TextEditingController();
    lastname = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    About = TextEditingController();

    Mon = TextEditingController();
    Tue = TextEditingController();
    Wed = TextEditingController();
    Wed = TextEditingController();
    Thu = TextEditingController();
    Fri = TextEditingController();
    Sat = TextEditingController();
    Sun = TextEditingController();

    super.onInit();
  }

  var fetched;
  late var isValid;
  void Booking(BuildContext context) async {
    try {
      if (days.contains(days2) ||
          days.contains(days3) ||
          days2.contains(days) ||
          days2.contains(days3) ||
          days3.contains(days) ||
          days3.contains(days2)) {
        isValid = false;

        print(daylist);
      } else {
        isValid = true;
      }
      if (isValid == true) {
        isLoading(true);
        book.currentState!.save();

        print("am herer");
        //  await seteditInfo(context);
      } else {
        print("am");
      }
    } finally {
      // ignore: todo
      // TODO
    }
  }

  var image;

  Future<void> seteditInfo(BuildContext context) async {
    openAndCloseLoadingDialog(context);

    var data = {
      "is_parent": is_parent.value,
      "parent_first_name": parent_first_name.text,
      "parent_last_name": parent_last_name.text,
      "first_name": firstname.text,
      "last_name": lastname.text,
      "phone_no": phone.text,
      "session": sessions.value,
      "email": email.text,
      "location_id": locaion!.id,
      "study_purpose": studyperpose.value,
      "grade": Grade.value,
      "about": About.text,
    };
    inforesponse = await RemoteServices.booking(data);
    if (inforesponse.toString() == "200") {
      closeDialog(true, '', context);
      isLoading(false);
    } else {
      closeDialog(false, inforesponse, context);
    }
  }

  // openAndCloseLoadingDialog() {

  // }

  closeDialog(bool stat, String data, BuildContext context) {
    Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    Navigator.of(context).pop();
    if (stat == false) {
      scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text("Not successfully  Booked")));
    } else {
      // ignore: deprecated_member_use

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Booking success',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () async {
                isLoading(false);
                Navigator.of(context).pop(true);
              },
              child: new Text('ok'),
            ),
          ],
        ),
      );
      editstudentid(context);
    }
  }

  openSnackBaredit(BuildContext context) async {
    scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("profile Edited"),
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
}
