import 'package:addistutor_student/remote_services/user.dart';
import 'package:get/get.dart';
import 'package:addistutor_student/remote_services/service.dart';

class GetEducationlevelController extends GetxController with StateMixin {
  var listeducation = <GetEducationlevel>[].obs;
  var isfetchededucation = false.obs;
  var sent = false.obs;

  GetEducationlevel? education;

  void fetchLocation() async {
    try {
      listeducation.value = await RemoteServices.geteducation();

      if (listeducation.isNotEmpty) {
        //print(list.length.toString());
        isfetchededucation(true);
      }
      // ignore: empty_catches
    } catch (e) {}
  }
}
