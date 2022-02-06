// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, invalid_use_of_protected_member

import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var list = <Search>[].obs;
  var isfetched = false.obs;

  var locationid;
  var homepagegender = "Female";

  void fetch(lid, sid, gender) async {
    list.value = await RemoteServices.search(lid, sid, gender);

    if (list.isNotEmpty) {
      isfetched(true);
      print("yess");
      print(list.value);
    } else {
      print("Noo");
    }
  }

  //   void getpreferdsubject (var id) async {
  //   listsubject.value = await RemoteServices.getsubject(id);

  //   if (listsubject.isNotEmpty) {
  //     subject = listsubject;
  //     // ignore: unnecessary_null_comparison
  //     if (subject != null) {
  //       hobItem = subject
  //           .map((hobbies) =>
  //               MultiSelectItem<GetSubject>(hobbies, hobbies.title))
  //           .toList();
  //     }
  //     isfetchedsubject(true);
  //   }
  // }

}
