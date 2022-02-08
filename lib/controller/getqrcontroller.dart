import 'package:addistutor_student/remote_services/user.dart';
import 'package:get/get.dart';
import 'package:addistutor_student/remote_services/service.dart';

class GetQrCode extends GetxController with StateMixin {
  var qr;
  var getqr;
  var isfetchedsubject = false.obs;

  void fetchqr(var b_id) async {
    qr = await RemoteServices.getqr(b_id);

    if (qr != null) {
      getqr = qr.data;
      // print("getqr.toString()");
      // print(getqr + "\n" + b_id.toString());
      isfetchedsubject(true);
    }
  }
}
