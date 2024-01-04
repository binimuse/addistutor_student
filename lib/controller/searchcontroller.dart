// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, invalid_use_of_protected_member

import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:get/get.dart';

class SearchControllers extends GetxController {
  var list = <Search>[].obs;
  var isfetched = false.obs;

  var locationid;
  var homepagegender = "";

  void fetch(lid, sid, gender, catgId) async {
    list.value = await RemoteServices.search(lid, sid, gender, catgId);

    if (list.isNotEmpty) {
      isfetched(true);
      print("yess");
      print(list.value);
    } else {
      print("Noo");
    }
  }
}
