// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_typing_uninitialized_variables, duplicate_ignore, deprecated_member_use, unused_element

import 'dart:convert';

import 'package:addistutor_student/Screens/Profile/editprofile.dart';
import 'package:addistutor_student/Screens/Profile/profile.dart';
import 'package:addistutor_student/Screens/Signup/components/otp.dart';
import 'package:addistutor_student/components/text_field_container.dart';
import 'package:addistutor_student/controller/editprofilecontroller.dart';
import 'package:addistutor_student/controller/getlocationcontroller.dart';
import 'package:addistutor_student/controller/getmyaccount.dart';
import 'package:addistutor_student/remote_services/api.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:addistutor_student/Screens/Login/components/background.dart';
import 'package:addistutor_student/Screens/Signup/signup_screen.dart';
import 'package:addistutor_student/Screens/main/main.dart';
import 'package:addistutor_student/components/already_have_an_account_acheck.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import 'forgotpassword.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

bool showPassword1 = true;
bool isPasswordTextField1 = true;

bool _isLoggedIn = false;
late GoogleSignInAccount _userObj;
GoogleSignIn _googleSignIn = GoogleSignIn();
late TextEditingController emailcon;
final EditprofileController editprofileController =
    Get.put(EditprofileController());

final GetmyAccount getmyAccount = Get.put(GetmyAccount());

class _LoginScreenState extends State<Body> {
  @override
  void initState() {
    super.initState();
    _fetchUser();
    _getlocation();
    _getmyaccount();
    emailcon = TextEditingController();
  }

  void _getmyaccount() async {
    // monitor network fetch
    // await Future.delayed(const Duration(milliseconds: 1000));
    getmyAccount.fetchqr();
  }

  final GetLocationController getLocationController =
      Get.put(GetLocationController());

  _getlocation() async {
    getLocationController.fetchLocation();
    // ignore: invalid_use_of_protected_member
  }

  var ids;
  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      if (body["student_id"] != null) {
        setState(() {
          ids = int.parse(body["student_id"]);
        });

        editprofileController.fetchPf(int.parse(body["student_id"]));
      } else {
        var noid = "noid";

        editprofileController.fetchPf(noid);
      }
    } else {}
  }

  bool isLoading = false;
  SharedPreferences? localStorage;
  final _formKey = GlobalKey<FormState>();
  var body;
  // ignore: prefer_typing_uninitialized_variables
  var email;
  // ignore: prefer_typing_uninitialized_variables
  var password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Log in",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 23),
              ),
              SizedBox(height: size.height * 0.03),

              Image(
                image: const AssetImage(
                  'assets/images/new.png',
                ),
                height: size.height * 0.20,
              ),

              TextFieldContainer(
                child: TextFormField(
                  controller: emailcon,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    icon: Icon(
                      Icons.email,
                      color: kPrimaryColor,
                    ),
                    border: InputBorder.none,
                  ),
                  validator: (emailval) {
                    if (emailval!.isEmpty) {
                      return "Please put your email";
                    }
                    email = emailval.toString();
                    return null;
                  },
                  // validator: (value) {
                  //   return signupController.validatephone(value!);
                  // },
                ),
              ),

              TextFieldContainer(
                child: TextFormField(
                  obscureText: isPasswordTextField1 ? showPassword1 : false,
                  cursorColor: kPrimaryColor,
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
                      borderSide:
                          const BorderSide(color: kPrimaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: InputBorder.none,
                  ),
                  onSaved: (value) {},
                  validator: (passwordval) {
                    if (passwordval!.isEmpty) {
                      return "Please put your Password";
                    }
                    password = passwordval.toString();
                    return null;
                  },
                ),
              ),
              // TextFieldContainer(
              //   child: TextFormField(
              //     obscureText: true,
              //     cursorColor: kPrimaryColor,
              //     decoration: const InputDecoration(
              //       hintText: "Password",
              //       icon: Icon(
              //         Icons.lock,
              //         color: kPrimaryColor,
              //       ),
              //       suffixIcon: Icon(
              //         Icons.visibility,
              //         color: kPrimaryColor,
              //       ),
              //       border: InputBorder.none,
              //     ),
              //     validator: (passwordval) {
              //       if (passwordval!.isEmpty) {
              //         return "Please put your Password";
              //       }
              //       password = passwordval.toString();
              //       return null;
              //     },
              //   ),
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
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: isLoading == false
                        ? const Text(
                            'Log in',
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
              ),
              SizedBox(height: size.height * 0.03),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return const ForgotPassword();
                      },
                    ),
                  );
                },
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: kPrimaryColor,
                      ),
                    )),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
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
              // const OrDivider(),
              // const Text(
              //   "Register with Google? ",
              //   style: TextStyle(color: kPrimaryColor),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     SocalIcon(
              //       iconSrc: "assets/images/google.png",
              //       press: () {
              //         _googleSignIn.signIn().then((userData) {
              //           setState(() {
              //             _isLoggedIn = true;
              //             _userObj = userData!;
              //           });

              //           emailcon.text = _userObj.email;

              //           if (_isLoggedIn) {
              //             if (_formKey.currentState!.validate()) {
              //               _loginwithgoogle();
              //             }
              //           }

              //           // register();
              //         }).catchError((e) {
              //           _googleSignIn.signOut().then((value) {
              //             setState(() {
              //               _isLoggedIn = false;
              //             });
              //           }).catchError((e) {});
              //         });
              //       },
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  void _loginwithgoogle() async {
    setState(() {
      isLoading = true;
    });
    var data = {'email': emailcon, 'password': password};
    var res = await Network().authData(data, "login-student");
    body = json.decode(res.body);

    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("token", body["token"]);

      localStorage.setString('user', json.encode(body['user']));

      var token = localStorage.getString('user');
      var bodys = json.decode(token!);

      if (bodys["student_id"] == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Scaffold(body: Mainscrren()),
          ),
          (route) => false,
        );
      }

      isLoading = false;
    } else if (res.statusCode == 401) {
      _googleSignIn.signOut().then((value) {
        setState(() {
          _isLoggedIn = false;
        });
      }).catchError((e) {});
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('info'),
          content: Text(body["message"]),
          actions: <Widget>[
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
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('info'),
          content: Text(body["message"]),
          actions: <Widget>[
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
  }

  void _login() async {
    setState(() {
      isLoading = true;
    });
    var data = {'email': email, 'password': password};
    var res = await Network().authData(data, "login-student");
    body = json.decode(res.body);

    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("token", body["token"]);

      localStorage.setString('user', json.encode(body['user']));

      var token = localStorage.getString('user');
      var bodys = json.decode(token!);
      if (bodys["email_verified_at"] == null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Please verify your email or otp'),
            content: const Text("Go to your email or sms to confirm"),
            actions: <Widget>[
              Center(
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
                ),
              )
            ],
          ),
        );
      } else {
        if (bodys["student_id"] == null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const Text("To continue, please complete your profile."),
              actions: <Widget>[
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: kPrimaryColor,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    setState(() {
                      isLoading = false;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditPage(),
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
              ],
            ),
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Scaffold(body: Mainscrren()),
            ),
            (route) => false,
          );
        }

        isLoading = false;
      }
    } else if (res.statusCode == 401) {
      _googleSignIn.signOut().then((value) {
        setState(() {
          _isLoggedIn = false;
        });
      }).catchError((e) {});
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('info'),
          content: Text(body["message"]),
          actions: <Widget>[
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
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('incorrect Email or password '),
          content: Text(body["message"]),
          actions: <Widget>[
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
              'incorrect Email or Password',
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
    }
  }
}
