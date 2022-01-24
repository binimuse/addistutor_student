import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var list = <Search>[].obs;
  var isfetched = false.obs;

  var locationid;

  void fetch(lid, sid, gender) async {
    print(lid);
    print(sid);
    print(gender);

    list.value = await RemoteServices.search(lid, sid, gender);
    if (list.isNotEmpty) {
      isfetched(true);
    }
  }
}
