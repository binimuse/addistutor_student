import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class EditprofileController extends GetxController with StateMixin {
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> EditProf = GlobalKey<FormState>();
  var inforesponse;
  var isLoading = false.obs;
  late TextEditingController parent_first_name;
  late TextEditingController firstname;
  late TextEditingController lastname;
  late TextEditingController parent_last_name;
  late TextEditingController phone;
  late TextEditingController email;
  late var macthgender = "Male".obs;
  late var locaion = "Bole".obs;
  late var education = "Primary".obs;
  var date;

  var studyperpose = "Regular support".obs;
  late var Grade = "Nersury".obs;
  late TextEditingController About;
  // ignore: non_constant_identifier_names
  late var is_parent = false.obs;
  var isFetched = false.obs;
  @override
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

  var fetched;

  Future<void> fetchPf(var id) async {
    try {
      //  openAndCloseLoadingDialog();
      fetched = await RemoteServices.fetchpf(id);
      //   print(fetched);
      if (fetched != "") {
        isFetched.value = true;

        parent_first_name.text = fetched.parent_first_name;
        parent_last_name.text = fetched.parent_last_name;
        firstname.text = fetched.first_name;
        lastname.text = fetched.last_name;
        phone.text = fetched.phone_no;
        email.text = fetched.email;
        email.text = fetched.email;

        macthgender.value = fetched.gender;
        date = fetched.birth_date;
        locaion.value = fetched.location;
        locaion.value = fetched.location;
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

      // TODO
    }
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
    //   openAndCloseLoadingDialog();

    var data = {
      "is_parent": is_parent.value,
      "parent_first_name": parent_first_name.text,
      "parent_last_name": parent_last_name.text,
      "first_name": firstname.text,
      "last_name": lastname.text,
      "phone_no": phone.text,
      "gender": macthgender.value,
      "birth_date": date,
      "location": locaion.value,
      "study_purpose": studyperpose.value,
      "grade": Grade.value,
      "about": About.text,
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
