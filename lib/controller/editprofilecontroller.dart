// ignore_for_file: non_constant_identifier_names, duplicate_ignore, prefer_typing_uninitialized_variables, avoid_print, avoid_web_libraries_in_flutter

import 'package:addistutor_student/Screens/Profile/profile.dart';
import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class EditprofileController extends GetxController with StateMixin {
  // ignore: non_constant_identifier_names
  GlobalKey<FormState> EditProf = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
  late var macthgender = "male".obs;
  GetLocation? locaion;
  late var education = "Primary".obs;
  var date;
  var id;
  //GetLocation? selectedModel;
  var studyperpose = "Regular support".obs;
  late var Grade = "Nersury".obs;
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
        //  print("yess");

        // ignore: unrelated_type_equality_checks
        print("yess");
        ifupdatd(true);
      } else {
        closeDialog(false, inforesponse, context);

        ifupdatd(false);
        print("noo");
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
      } else {
        closeDialog(false, inforesponse, context);
      }
    }
  }

  // openAndCloseLoadingDialog() {

  // }

  closeDialog(bool stat, String data, BuildContext context) {
    Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    Navigator.of(context).pop();
    if (stat == false) {
      scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text("profile Not Edited")));
    } else {
      openSnackBaredit(context);
    }
  }

  openSnackBaredit(BuildContext context) async {
    //  snackbar("", "profile Edited",
    //       icon: Icon(Icons.person, color: kPrimaryColor.withOpacity(0.05)),
    //       snackPosition: SnackPosition.TOP);

    //   // Navigator.pushNamed(Get.context!, '/home');

    scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("profile Edited"),
    ));
   await Future.delayed(const Duration(seconds: 3));
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const ProfileScreen(),
      ),
    );
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
