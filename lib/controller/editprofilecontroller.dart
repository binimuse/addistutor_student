import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditprofileController extends GetxController with StateMixin {
  GlobalKey<FormState> Form = GlobalKey<FormState>();
  var inforesponse;
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController phone;
  late TextEditingController email;
  var gender;
  var location;
  var education;
  late TextEditingController About;

  void onInit() {
    firstname = TextEditingController();
    lastname = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    About = TextEditingController();

    super.onInit();
  }

  Future<void> seteditInfo() async {
    openAndCloseLoadingDialog();

    var data = {
      "first_name": firstname.text,
      "last_name": lastname.text,
      "phone_no": lastname.text,
      "gender": lastname.text,
      "last_name": lastname.text,
      "last_name": lastname.text,
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
}
