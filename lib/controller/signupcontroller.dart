// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignupController extends GetxController with StateMixin {
  GlobalKey<FormState> Form = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController fullname;
  late TextEditingController phone;
  late TextEditingController password;

  @override
  void onInit() {
    fullname = TextEditingController();

    email = TextEditingController();
    fullname = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();

    super.onInit();
  }

  var inforesponse;

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide a valid email";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Please provide a name";
    }
    return null;
  }

  String? validatePass(String value) {
    if (!validateStructure(value)) {
      return "Please provide a valid password";
    }
    return null;
  }

  String? validatephone(String value) {
    if (!value.contains("251")) {
      return "Please provide phone number  \n and start with 2519";
    }
    return null;
  }

  String? validateNamep(String value) {
    if (value.isEmpty) {
      return "Please provide a Password";
    }
    return null;
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
