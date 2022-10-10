// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, deprecated_member_use, duplicate_ignore

import 'package:addistutor_student/Screens/Login/login_screen.dart';
import 'package:addistutor_student/constants.dart';

import 'package:addistutor_student/controller/contactuscontroller.dart';
import 'package:addistutor_student/controller/getmyaccount.dart';
import 'package:addistutor_student/controller/getnotificationcontoller.dart';
import 'package:addistutor_student/controller/getqrcontroller.dart';
import 'package:addistutor_student/controller/getutoravlblitycontroller.dart';
import 'package:addistutor_student/controller/searchcontroller.dart';
import 'package:addistutor_student/controller/signupcontroller.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bookingcontroller.dart';
import 'editprofilecontroller.dart';
import 'feedbackcontroller.dart';
import 'geteducationlevelcontroller.dart';
import 'getlocationcontroller.dart';
import 'getreqestedbookingcpntroller.dart';
import 'getsubjectcontroller.dart';

class RemoveScreencontroller extends GetxController with StateMixin {
  GlobalKey<FormState> Formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController feedback;
  var inforesponse;
  var isLoading = false.obs;
  var isFetched = false.obs;
  @override
  void onInit() {
    feedback = TextEditingController();

    super.onInit();
  }

  Future<void> seteditInfo(BuildContext context, id) async {
    openAndCloseLoadingDialog(context);

    inforesponse = await RemoteServices.remove(id);
    if (inforesponse.toString() == "200") {
      closeDialog(true, '', context);
      isLoading(false);

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      localStorage.remove('user');

      Get.delete<SignupController>();
      Get.delete<EditprofileController>();
      Get.delete<GetLocationController>();
      Get.delete<GetSubjectController>();
      Get.delete<SearchController>();
      Get.delete<BookingeController>();
      Get.delete<ContactUSContolller>();
      Get.delete<FeedBackScreencontroller>();
      Get.delete<GetEducationlevelController>();
      Get.delete<GetLocationController>();
      Get.delete<GetReqBooking>();
      Get.delete<GetTutorAvlblityController>();
      Get.delete<GetQrCode>();
      Get.delete<GetNotigicationController>();
      Get.delete<EndBookingContoller>();
      Get.delete<GetmyAccount>();
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const LoginScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    } else {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      localStorage.remove('user');
      Get.delete<SignupController>();
      Get.delete<EditprofileController>();
      Get.delete<GetLocationController>();
      Get.delete<GetSubjectController>();
      Get.delete<SearchController>();
      Get.delete<BookingeController>();
      Get.delete<ContactUSContolller>();
      Get.delete<FeedBackScreencontroller>();
      Get.delete<GetEducationlevelController>();
      Get.delete<GetLocationController>();
      Get.delete<GetReqBooking>();
      Get.delete<GetTutorAvlblityController>();
      Get.delete<GetQrCode>();
      Get.delete<GetNotigicationController>();
      Get.delete<EndBookingContoller>();
      Get.delete<GetmyAccount>();
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const LoginScreen(),
          transitionDuration: Duration.zero,
        ),
      );
    }
  }

  closeDialog(bool stat, String data, BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    //
    Navigator.of(context).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Remove account Error',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                isLoading(false);
                Navigator.of(context).pop(true);
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
    } else {
      // ignore: deprecated_member_use

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Successfully Removed. ',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                isLoading(false);
                Navigator.of(context).pop(true);
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const ProfileScreen()),
                // );
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
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

  String? validateName(String value) {
    if (value.isEmpty) {
      return "please provide a Feedback";
    }
    return null;
  }
}

class EndBookingContoller {}
