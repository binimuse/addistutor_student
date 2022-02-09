import 'package:addistutor_student/remote_services/user.dart';

import 'package:get/get.dart';
import 'package:addistutor_student/remote_services/service.dart';

class GetTutorAvlblityController extends GetxController with StateMixin {
  var listdate = <Day>[].obs;
  var isfetchedlocation = false.obs;
  var sent = false.obs;
  Day? day;

  void fetchDay(var id) async {
    listdate.value = await RemoteServices.getAvalbledate(id);

    if (listdate.isNotEmpty) {
      isfetchedlocation(true);
    }
  }
}
