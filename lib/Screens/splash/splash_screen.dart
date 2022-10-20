import 'dart:convert';

import 'package:addistutor_student/Screens/Login/components/background.dart';
import 'package:addistutor_student/Screens/Progress/progress.dart';
import 'package:addistutor_student/Screens/main/main.dart';
import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/controller/geteducationlevelcontroller.dart';
import 'package:addistutor_student/controller/getlocationcontroller.dart';
import 'package:addistutor_student/controller/getsubjectcontroller.dart';
import 'package:addistutor_student/controller/searchcontroller.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetEducationlevelController getEducationlevelController =
      Get.put(GetEducationlevelController());
  GetLocationController getLocationController =
      Get.put(GetLocationController());
  SearchController searchController = Get.put(SearchController());
  GetSubjectController getSubjectController = Get.put(GetSubjectController());
  bool isAuth = false;

  @override
  void initState() {
    var d = const Duration(seconds: 5);
    // delayed 3 seconds to next page
    Future.delayed(d, () {
      //to next page and close this page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: isAuth ? const Mainscrren() : const MyPages(),
          ),
        ),
        (route) => false,
      );
    });
    _checkIfLoggedIn();
    _getall();
    super.initState();
  }

  _getall() async {
    _geteducation();
    _getsubject();
    _getlocation();
  }

  List<GetSubject> subject = [];
  _getsubject() {
    subject = getSubjectController.listsubject.value;
    if (subject != null && subject.isNotEmpty) {
      setState(() {
        //  getSubjectController.subject = subject[0];
      });
    }
  }

  _geteducation() async {
    getEducationlevelController.fetchLocation();
    getSubjectController.fetchLocation("1");
    getLocationController.fetchLocation();

    //
    // ignore: invalid_use_of_protected_member
  }

  _getlocation() async {
    getLocationController.fetchLocation();
    // ignore: invalid_use_of_protected_member
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var user = localStorage.getString('user');
    var bodys = json.decode(user!);
    if (token != null &&
        bodys["email_verified_at"] != null &&
        bodys["student_id"] != null) {
      // print(user);
      // print("token login");
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/lg3.png',
                  height: 170,
                  width: 360,
                ),
              ),
              Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(
                        child: Text(
                          "One-on-One \n Tutorial Service",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.0,
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.4,
                            height: 0.9,
                            color: kPrimaryLightColor,
                          ),
                        ),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Connecting you with the best tutors in Addis. Conveniently.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.2,
                    height: 0.9,
                    color: Colors.black,
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
