// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:addistutor_student/Screens/Login/login_screen.dart';
import 'package:addistutor_student/Screens/Signup/signup_screen.dart';
import 'package:addistutor_student/Screens/Welcome/components/background.dart';
import 'package:addistutor_student/components/rounded_button.dart';
import 'package:addistutor_student/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "WELCOME TO NEXTGEN",
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.bold,
                letterSpacing: 0.4,
                height: 0.9,
                color: kPrimaryColor,
              ),
            ),
            const Text(
              "Student Applicaion",
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
                letterSpacing: 0.4,
                height: 0.9,
                color: kPrimaryLightColor,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Image(
              image: AssetImage(
                'assets/images/login.jpg',
              ),
              height: size.height * 0.25,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "Login",
              press: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Register",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return const SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
