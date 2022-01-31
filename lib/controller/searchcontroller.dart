import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var list = <Search>[].obs;
  var isfetched = false.obs;

  var locationid;
  var homepagegender = "";

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
}
