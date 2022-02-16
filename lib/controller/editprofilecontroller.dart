// ignore_for_file: non_constant_identifier_names, duplicate_ignore, prefer_typing_uninitialized_variables, avoid_print, avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:convert';

import 'package:addistutor_student/Screens/Login/login_screen.dart';
import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditprofileController extends GetxController with StateMixin {
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> EditProf = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> changePass = GlobalKey<FormState>();
  final GlobalKey<FormState> forgot = GlobalKey<FormState>();

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

  //update pass
  late TextEditingController passControl;
  late TextEditingController newpassControl;
  late TextEditingController confirmpassControl;

  late TextEditingController forgotpass;
  var pass = '';
  var forgo = '';

  late var macthgender = "".obs;
  GetLocation? locaion;
  late var education = "Primary".obs;
  var date;
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

    //update pass
    passControl = TextEditingController();
    newpassControl = TextEditingController();
    confirmpassControl = TextEditingController();

    //forgot
    forgotpass = TextEditingController();

    super.onInit();
  }

  void forgotpassword(BuildContext context) async {
    try {
      final isValid = forgot.currentState!.validate();

      if (isValid == true) {
        isLoading(true);
        forgot.currentState!.save();
        await forgott(context);
      }
    } finally {}
  }

  var emailadd = "";
  Future<void> forgott(context) async {
    openAndCloseLoadingDialog(context);

    var data = {
      "email": forgotpass.text,
    };
    print(data);
    emailadd = await RemoteServices.forgott(data);
    print(emailadd.toString());
    if (emailadd.toString() == "200") {
      closeDialogforgot(true, emailadd, context);
      isLoading(false);
      print("yess");
    } else {
      //inforesponse = edited;
      closeDialogforgot(false, emailadd, context);
      print("noo");
      //  print(edited.toString());
    }
  }

  closeDialogforgot(bool stat, String data, BuildContext context) {
    Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    Navigator.of(context).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            data.toString(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                Navigator.pop(context);
                isLoading(false);
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
            'cheak your email aadress ',
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

                Navigator.pop(context);
                isLoading(false);
                //    openAndCloseLoadingDialog(context);
                print("yess");
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
    }
  }

  void changepass(BuildContext context) async {
    try {
      final isValid = changePass.currentState!.validate();

      if (isValid == true) {
        isLoading(true);
        changePass.currentState!.save();
        await updatePass(context);
      }
    } finally {
      // ignore: todo
      // TODO
    }
  }

  var edited = "";
  Future<void> updatePass(context) async {
    openAndCloseLoadingDialog(context);

    var data = {
      "old_password": passControl.text,
      "password": newpassControl.text,
      "password_confirmation": confirmpassControl.text,
    };
    print(data);
    edited = await RemoteServices.updatepass(data);
    //print(edited.toString());
    if (edited.toString() == "200") {
      closeDialogpassword(true, edited, context);
      isLoading(false);
      print("yess");
    } else {
      //inforesponse = edited;
      closeDialogpassword(false, edited, context);
      print("noo");
      //  print(edited.toString());
    }
  }

  closeDialogpassword(bool stat, String data, BuildContext context) {
    Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    Navigator.of(context).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Password Not Updated \n ' + data.toString(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                Navigator.pop(context);
                isLoading(false);
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
            'Password Edited',
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

                Navigator.pop(context);
                isLoading(false);
                //    openAndCloseLoadingDialog(context);
                print("yess");
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
    }
  }

  var fetched;

  Future<void> fetchPf(var id) async {
    if (id == "noid") {
      change(fetched, status: RxStatus.success());
      isFetched.value = true;
    } else {
      try {
        //  openAndCloseLoadingDialog();
        fetched = await RemoteServices.fetchpf(id);
        //   print(fetched);
        if (fetched != "") {
          isFetched.value = true;
          id = fetched.id;
          parent_first_name.text = fetched.parent_first_name;
          parent_last_name.text = fetched.parent_last_name;
          firstname.text = fetched.first_name;
          lastname.text = fetched.last_name;
          phone.text = fetched.phone_no;
          email.text = fetched.email;
          macthgender.value = fetched.gender;
          date = fetched.birth_date;
          // locaion!.id = fetched.location;

          Grade.value = fetched.grade;
          studyperpose.value = fetched.study_purpose;
          About.text = fetched.about;

          await Future.delayed(const Duration(seconds: 1));
          // Dismiss CircularProgressIndicator
          //   Navigator.of(Get.context!).pop();
        }
        change(fetched, status: RxStatus.success());
      } on Exception {
        change(null, status: RxStatus.error("Something went wrong"));

        // ignore: todo
        // TODO
      }
    }
  }

  void editProf(id, BuildContext context) async {
    try {
      final isValid = EditProf.currentState!.validate();

      if (isValid == true) {
        isLoading(true);
        EditProf.currentState!.save();
        await seteditInfo(id, context);
      }
    } finally {
      // ignore: todo
      // TODO
    }
  }

  var image;

  Future<void> seteditInfo(ids, BuildContext context) async {
    openAndCloseLoadingDialog(context);
    var uploaded = await RemoteServices.uploadImage(image, ids.toString());

    if (uploaded) {
      var data = {
        "is_parent": is_parent.value,
        "parent_first_name": parent_first_name.text,
        "parent_last_name": parent_last_name.text,
        "first_name": firstname.text,
        "last_name": lastname.text,
        "phone_no": phone.text,
        "gender": macthgender.value,
        "birth_date": date,
        "email": email.text,
        "location_id": locaion!.id,
        "study_purpose": studyperpose.value,
        "grade": Grade.value,
        "about": About.text,
      };
      inforesponse = await RemoteServices.editPersonalInfo(data);
      if (inforesponse.toString() == "200") {
        closeDialog(true, '', context);
        isLoading(false);

        ifupdatd(true);
      } else {
        closeDialog(false, inforesponse, context);

        ifupdatd(false);
      }
    } else {
      var data = {
        "is_parent": is_parent.value,
        "parent_first_name": parent_first_name.text,
        "parent_last_name": parent_last_name.text,
        "first_name": firstname.text,
        "last_name": lastname.text,
        "phone_no": phone.text,
        "gender": macthgender.value,
        "birth_date": date,
        "email": email.text,
        "location_id": locaion!.id,
        "study_purpose": studyperpose.value,
        "grade": Grade.value,
        "about": About.text,
      };
      inforesponse = await RemoteServices.editPersonalInfo(data);
      if (inforesponse.toString() == "200") {
        closeDialog(true, '', context);
        isLoading(false);
      } else {
        closeDialog(false, inforesponse, context);
      }
    }
  }

  // openAndCloseLoadingDialog() {

  // }

  // closeDialog(bool stat, String data, BuildContext context) {
  //   Future.delayed(const Duration(seconds: 1));
  //   // Dismiss CircularProgressIndicator
  //   Navigator.of(context).pop();
  //   if (stat == false) {
  //     scaffoldKey.currentState!
  //         .showSnackBar(const SnackBar(content: Text("profile Not Edited")));
  //   } else {
  //     // ignore: deprecated_member_use

  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text(
  //           'profile Edited',
  //           style: TextStyle(
  //             fontSize: 13,
  //             fontWeight: FontWeight.w500,
  //             color: Colors.black,
  //             fontFamily: 'WorkSans',
  //           ),
  //         ),
  //         content: const Text(
  //           'if its your first time updating your profile you will me redirected to login',
  //           style: TextStyle(
  //             fontSize: 13,
  //             fontWeight: FontWeight.w500,
  //             color: Colors.black,
  //             fontFamily: 'WorkSans',
  //           ),
  //         ),
  //         actions: <Widget>[
  //           // ignore: deprecated_member_use
  //           FlatButton(
  //             onPressed: () async {
  //               isLoading(false);
  //               Navigator.of(context).pop(true);

  //               SharedPreferences localStorage =
  //                   await SharedPreferences.getInstance();
  //               localStorage.setBool('isupdated', true);

  //               var token = localStorage.getString('user');

  //               if (token != null) {
  //                 body = json.decode(token);

  //                 if (body["student_id"] != null) {
  //                   Navigator.pop(context);
  //                   isLoading(false);
  //                   //    openAndCloseLoadingDialog(context);
  //                   print("yess");
  //                 } else {
  //                   isLoading(false);

  //                   Navigator.push(
  //                     context,
  //                     PageRouteBuilder(
  //                       pageBuilder: (context, animation1, animation2) {
  //                         return const LoginScreen();
  //                       },
  //                     ),
  //                   );
  //                 }
  //               }
  //             },
  //             child: const Text('ok'),
  //           ),
  //         ],
  //       ),
  //     );
  //     editstudentid(context);
  //   }
  // }

  closeDialog(bool stat, String data, BuildContext context) async {
    Future.delayed(const Duration(seconds: 1));
    var body;

    // Dismiss CircularProgressIndicator
    Navigator.of(context).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'profile Not Edited',
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
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      var token = localStorage.getString('user');
      localStorage.setBool('isupdated', true);

      if (token != null) {
        body = json.decode(token);

        if (body["student_id"] != null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'profile Edited',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'WorkSans',
                ),
              ),
              content: const Text(
                '',
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

                    Navigator.pop(context);
                    isLoading(false);
                  },
                  child: const Text('ok'),
                ),
              ],
            ),
          );

          //    openAndCloseLoadingDialog(context);
          print("yess");
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'profile Edited',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'WorkSans',
                ),
              ),
              content: const Text(
                'if its your first time updating your profile you will be redirected to login',
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

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                  child: const Text('ok'),
                ),
              ],
            ),
          );
        }
      }

      editstudentid(context);
    }
  }

  openSnackBaredit(BuildContext context) async {
    scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: const Text("profile Edited"),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
      backgroundColor: kPrimaryColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
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

  String? validateNamep(String value) {
    if (value.isEmpty) {
      return "please Provide a Password";
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
