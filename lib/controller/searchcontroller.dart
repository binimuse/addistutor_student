import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:get/get.dart';

class SubjectController extends GetxController {
  var list = <Searchsubject>[].obs;
  var isfetched = false.obs;

  void fetch(id) async {
    list.value = await RemoteServices.searchsubject(id);
    if (list.isNotEmpty) {
      isfetched(true);
    }
  }
}
