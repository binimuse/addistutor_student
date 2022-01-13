import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditprofileController extends GetxController with StateMixin {
  GlobalKey<FormState> Form = GlobalKey<FormState>();
  final GlobalKey<FormState> EditProf = GlobalKey<FormState>();
  var inforesponse;
  var isLoading = false.obs;
  late TextEditingController parent_first_name;
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController parent_last_name;
  late TextEditingController phone;
  late TextEditingController email;
  late var macthgender = "Male";
  late var locaion = "Bole";
  late var education = "Primary";
  var date;
  var studyperpose = "Regular support";
  late var Grade = "Nersury";
  late TextEditingController About;
  late bool is_parent = true;

  void onInit() {
    parent_first_name = TextEditingController();
    parent_last_name = TextEditingController();
    firstname = TextEditingController();
    lastname = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    About = TextEditingController();

    super.onInit();
  }

  void editProf() async {
    try {
      final isValid = EditProf.currentState!.validate();

      if (isValid == true) {
        isLoading(true);
        EditProf.currentState!.save();
        await seteditInfo();
      }
    } finally {
      // TODO
    }
  }

  Future<void> seteditInfo() async {
    openAndCloseLoadingDialog();

    var data = {
      "is_parent": is_parent,
      "parent_first_name": parent_first_name.text,
      "parent_last_name": parent_last_name.text,
      "first_name": firstname.text,
      "last_name": lastname.text,
      "phone_no": phone.text,
      "gender": macthgender.obs,
      "birth_date": date,
      "location": locaion.obs,
      "about": About.text,
      // "image": About.text,
      "study_purpose": studyperpose.obs,
      "grade": Grade.obs,
    };
    inforesponse = await RemoteServices.editPersonalInfo(data);
    if (inforesponse.toString() == "200") {
      closeDialog(true, '');
    } else {
      closeDialog(false, inforesponse);
    }
  }

  Future<void> openAndCloseLoadingDialog() async {
    showDialog(
      context: Get.context!,
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

  Future<void> closeDialog(bool stat, String data) async {
    await Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    // Navigator.of(Get.context!).pop();
    if (stat == false) {
      Get.dialog(
        AlertDialog(
          title: const Text("info"),
          content: Text(data),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: const Text("close"),
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
        barrierDismissible: false,
      );
    } else {
      openSnackBaredit();
    }
  }

  Future<void> openSnackBaredit() async {
    Get.snackbar("", "profile Edited",
        icon: Icon(Icons.person, color: kPrimaryColor.withOpacity(0.05)),
        snackPosition: SnackPosition.TOP);
    await Future.delayed(const Duration(seconds: 1));
    // Navigator.pushNamed(Get.context!, '/home');
  }

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
}
