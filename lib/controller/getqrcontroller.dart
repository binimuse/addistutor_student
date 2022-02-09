// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:addistutor_student/remote_services/service.dart';

class GetQrCode extends GetxController with StateMixin {
  var qr;
  var getqr;
  var isfetchedsubject = false.obs;

  void fetchqr(var bId) async {
    qr = await RemoteServices.getqr(bId);

    if (qr != null) {
      getqr = qr.data;
      // print("getqr.toString()");
      // print(getqr + "\n" + b_id.toString());
      isfetchedsubject(true);
    }
  }
}
