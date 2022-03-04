import 'package:addistutor_student/remote_services/user.dart';
import 'package:get/get.dart';
import 'package:addistutor_student/remote_services/service.dart';

class GetLocationController extends GetxController with StateMixin {
  var listlocation = <GetLocation>[].obs;
  var listlocationforedit = <GetLocationforedit>[].obs;
  var isfetchedlocation = false.obs;
  var sent = false.obs;
  GetLocation? location;
  void fetchLocation() async {
    listlocation.value = await RemoteServices.getlocation();

    if (listlocation.isNotEmpty) {
      //print(list.length.toString());
      isfetchedlocation(true);
    }
  }
}
