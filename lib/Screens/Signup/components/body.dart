import 'dart:convert';

import 'package:addistutor_student/components/signupcontroller.dart';
import 'package:addistutor_student/remote_services/api.dart';
import 'package:flutter/material.dart';
import 'package:addistutor_student/Screens/Login/login_screen.dart';
import 'package:addistutor_student/Screens/Signup/components/background.dart';
import 'package:addistutor_student/Screens/Signup/components/or_divider.dart';
import 'package:addistutor_student/Screens/Signup/components/social_icon.dart';
import 'package:addistutor_student/components/already_have_an_account_acheck.dart';

import 'package:addistutor_student/components/text_field_container.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Body> {
  final _multiSelectKey = GlobalKey<FormState>();
  SignupController signupController = Get.put(SignupController());

  bool isLoading = false;
  var inforesponse;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              const Text(
                "SIGNUP",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 23),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.15,
              ),
              Form(
                key: _multiSelectKey,
                child: Column(
                  children: [
                    TextFieldContainer(
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        autofocus: false,
                        controller: signupController.fullname,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person_add,
                            color: kPrimaryColor,
                          ),
                          hintText: "Fullname",
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          return signupController.validateName(value!);
                        },
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        autofocus: false,
                        controller: signupController.email,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: kPrimaryColor,
                          ),
                          hintText: "Email",
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          return signupController.validateEmail(value!);
                        },
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        autofocus: false,
                        controller: signupController.phone,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.phone,
                            color: kPrimaryColor,
                          ),
                          hintText: "Phone",
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          return signupController.validatephone(value!);
                        },
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        obscureText: true,
                        controller: signupController.password,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          hintText: "Password",
                          icon: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          return signupController.validatephone(value!);
                        },
                      ),
                    ),
                    // RoundedButton(
                    //   text: "SIGNUP",
                    //   press: () {
                    //     if (_multiSelectKey.currentState!.validate()) {
                    //    register();
                    //     }
                    //   },
                    // ),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        color: kPrimaryColor,
                        onPressed: () {
                          if (_multiSelectKey.currentState!.validate()) {
                            register();
                          }

                          // Navigator.push(
                          //   context,
                          //   PageRouteBuilder(
                          //     pageBuilder: (context, animation1, animation2) {
                          //       return Suggested();
                          //     },
                          //   ),
                          // );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: isLoading == false
                              ? const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              : const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  register() async {
    setState(() {
      isLoading = true;
    });

    var data = {
      "email": signupController.email.text,
      "full_name": signupController.fullname.text,
      "phone": signupController.phone.text,
      "password": signupController.password.text,
    };

    var res = await Network().authData(data, 'register-student');
    var body = json.decode(res.body);
    print(body.toString());
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("token", body["token"].toString());

      localStorage.setString('user', json.encode(body['user']));

      closeDialog(true, '');
      isLoading = false;
    } else {
      closeDialog(false, res);
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> closeDialog(bool stat, var data) async {
    await Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    // Navigator.of(Get.context!).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(height: 15),
            const Text(
              'Error',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Divider(
              height: 1,
              color: kPrimaryColor,
            ),
          ]),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(height: 15),
            const Text(
              'Email is already on Use',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
          ]),
          actions: <Widget>[
            // ignore: deprecated_member_use
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: InkWell(
                highlightColor: Colors.grey[200],
                onTap: () {
                  Navigator.of(context).pop(true);
                  setState(() {
                    isLoading = false;
                  });
                },
                child: Center(
                  child: Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(height: 15),
            const Text(
              'Success',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Divider(
              height: 1,
              color: kPrimaryColor,
            ),
          ]),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(height: 15),
            const Text(
              'Successfully registerd',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
          ]),
          actions: <Widget>[
            // ignore: deprecated_member_use
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: InkWell(
                highlightColor: Colors.grey[200],
                onTap: () {
                  Navigator.of(context).pop(true);
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => LoginScreen(),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
