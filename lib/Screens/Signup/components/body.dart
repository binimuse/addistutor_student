// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields

import 'dart:convert';

import 'package:addistutor_student/Screens/Profile/termsodservice.dart';
import 'package:addistutor_student/Screens/Signup/components/otp.dart';
import 'package:addistutor_student/Screens/main/main.dart';
import 'package:addistutor_student/controller/signupcontroller.dart';
import 'package:addistutor_student/remote_services/api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:addistutor_student/Screens/Login/login_screen.dart';
import 'package:addistutor_student/Screens/Signup/components/background.dart';
import 'package:addistutor_student/components/already_have_an_account_acheck.dart';

import 'package:addistutor_student/components/text_field_container.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  bool showPassword1 = true;
  bool isPasswordTextField1 = true;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isChecked = false;
  bool ispassChecked = false;
  var confirmpass;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            const Text(
              "Register",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 23),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image(
                image: const AssetImage(
                  'assets/images/new.png',
                ),
                height: size.height * 0.15,
              ),
            ),
            Form(
              key: _multiSelectKey,
              child: Column(
                children: [
                  TextFieldContainer(
                    child: TextFormField(
                      maxLength: 20,
                      cursorColor: kPrimaryColor,
                      autofocus: false,
                      controller: signupController.fullname,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person_add,
                          color: kPrimaryColor,
                        ),
                        hintText: "Full Name",
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        return signupController.validateName(value!);
                      },
                    ),
                  ),
                  TextFieldContainer(
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                            RegExp(r'\s')), // Deny spaces
                      ],
                      cursorColor: kPrimaryColor,
                      autofocus: false,
                      controller: signupController.email,
                      decoration: const InputDecoration(
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
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          color: kPrimaryColor,
                        ),
                        hintText: "Phone 2519",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                      ],
                      validator: (value) {
                        return signupController.validatephone(value!);
                      },
                    ),
                  ),
                  TextFieldContainer(
                    child: TextFormField(
                      obscureText: isPasswordTextField1 ? showPassword1 : false,
                      cursorColor: kPrimaryColor,
                      controller: signupController.password,
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: const Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: isPasswordTextField1
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPassword1 = !showPassword1;
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove_red_eye,
                                  color: kPrimaryColor,
                                ),
                              )
                            : null,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: InputBorder.none,
                      ),
                      onSaved: (value) {},
                      validator: (value) {
                        return signupController.validateNamep(value!);
                      },
                    ),
                  ),
                  TextFieldContainer(
                    child: TextFormField(
                      obscureText: isPasswordTextField1 ? showPassword1 : false,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hintText: "Confirm password",
                        icon: const Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: isPasswordTextField1
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPassword1 = !showPassword1;
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove_red_eye,
                                  color: kPrimaryColor,
                                ),
                              )
                            : null,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: kPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (values) {
                        setState(() {
                          confirmpass = values;
                        });
                      },
                      onSaved: (value) {},
                      validator: (value) {
                        return signupController.validateNamep(value!);
                      },
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Checkbox(
                      activeColor: kPrimaryColor,
                      checkColor: kPrimaryLightColor,
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                            style: const TextStyle(color: Colors.grey),
                            children: [
                              TextSpan(
                                text: 'I agree with the terms of service',
                                style: const TextStyle(
                                  color: kPrimaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) {
                                          return const ProductDescriptionPage();
                                        },
                                      ),
                                    );
                                  },
                              ),
                            ]),
                      ),
                    ),
                  ]),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),
                      ),
                      color: kPrimaryColor,
                      onPressed: () {
                        if (signupController.password.text == confirmpass) {
                          setState(() {
                            ispassChecked = true;
                          });
                        } else {
                          setState(() {
                            ispassChecked = false;
                          });
                        }
                        if (_multiSelectKey.currentState!.validate()) {
                          if (ispassChecked == true) {
                            isChecked
                                ? register()
                                : showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          "Please check terms of service"),
                                      actions: <Widget>[
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                            setState(() {
                                              isLoading = false;
                                            });
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: const Text("Password don't match"),
                                actions: <Widget>[
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
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
                      return const LoginScreen();
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

  registerbygoogle() async {
    setState(() {
      isLoading = true;
    });

    var data = {
      "email": signupController.email.text,
      "full_name": signupController.fullname.text,
    };

    var res = await Network().authData(data, 'register-student');
    var body = json.decode(res.body);

    //print(body.toString());
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("token", body["token"]);

      localStorage.setString('user', json.encode(body['user']));

      closeDialoggoogle(true, '');
      isLoading = false;
    } else if (res.statusCode == 422) {
      _googleSignIn.signOut().then((value) {
        setState(() {});
      }).catchError((e) {});

      var errorString = body["errors"].toString();
      var trimmedString = errorString.replaceAll(RegExp(r'[{}\[\]]'), '');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(trimmedString),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                setState(() {
                  isLoading = false;
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      closeDialoggoogle(false, res);
    }

    setState(() {
      isLoading = false;
    });
  }

  void register() async {
    try {
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

      if (res.statusCode == 200) {
        _handleSuccessfulRegistration(body);
      } else if (res.statusCode == 422) {
        _handleRegistrationError(body["errors"].toString());
      } else {
        _handleRegistrationError(res.body);
      }
    } catch (e) {
      _handleRegistrationError(e.toString());
    }
  }

  void _handleSuccessfulRegistration(body) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString("token", body["token"]);

    localStorage.setString('user', json.encode(body['user']));

    closeDialog(true, '');
    isLoading = false;
  }

  void _handleRegistrationError(String error) async {
    var trimmedString = error.replaceAll(RegExp(r'[{}\[\]]'), '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(trimmedString),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              setState(() {
                isLoading = false;
              });
            },
            child: const Text('ok'),
          ),
        ],
      ),
    );
  }

  Future<void> closeDialoggoogle(bool stat, var data) async {
    await Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    // Navigator.of(Get.context!).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 0,
          backgroundColor: const Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Column(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(height: 15),
            Text(
              'Errorr',
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
          content: Column(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(height: 15),
            Text(
              "Running to a problem please try again",
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
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: const Text(
                      'Ok',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
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
          backgroundColor: const Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Column(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(height: 15),
            Text(
              'Registered successfully',
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
          content: Column(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Please check your email inbox or your sms  to verify your email address  or phone number  before you log in.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
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
                        builder: (BuildContext context) => const Mainscrren(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: kPrimaryColor,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const Mainscrren(),
                          ),
                        );
                      },
                      child: Container(
                          width: 20,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: const Text(
                            'Ok',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                  )),
            ),
          ],
        ),
      );
    }
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
          backgroundColor: const Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Column(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(height: 15),
            Text(
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
          content: Column(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(height: 15),
            Text(
              "Running to a problem please try again",
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: kPrimaryColor,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                          width: 20,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: const Text(
                            'Ok',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                  )),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 0,
          backgroundColor: const Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Column(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(height: 15),
            Text(
              'Registered successfully',
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
          content: Column(mainAxisSize: MainAxisSize.min, children: const [
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Please check your email inbox or your sms  to verify your email address  or phone number  before you log in. ',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
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
                    // Navigator.push<dynamic>(
                    //   context,
                    //   MaterialPageRoute<dynamic>(
                    //     builder: (BuildContext context) => const LoginScreen(),
                    //   ),
                    // );

                    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => OTPPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: kPrimaryColor,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        setState(() {
                          isLoading = false;
                        });
                        // Navigator.push<dynamic>(
                        //   context,
                        //   MaterialPageRoute<dynamic>(
                        //     builder: (BuildContext context) =>
                        //         const LoginScreen(),
                        //   ),
                        // );

                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => OTPPage(),
                          ),
                        );
                      },
                      child: Container(
                          width: 20,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          child: const Text(
                            'Ok',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    ),
                  )),
            ),
          ],
        ),
      );
    }
  }
}
