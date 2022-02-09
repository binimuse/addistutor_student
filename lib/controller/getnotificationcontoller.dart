import 'package:addistutor_student/remote_services/user.dart';

import 'package:get/get.dart';
import 'package:addistutor_student/remote_services/service.dart';

class GetNotigicationController extends GetxController with StateMixin {
  var listdate = <Notifications>[].obs;
  var isfetchedlocation = false.obs;
  var sent = false.obs;
  Day? day;

  void fetchNotfication() async {
    listdate.value = await RemoteServices.getActivity();

    if (listdate.isNotEmpty) {
      //  isfetchedlocation(true);

      isfetchedlocation(true);
    }
  }
}
