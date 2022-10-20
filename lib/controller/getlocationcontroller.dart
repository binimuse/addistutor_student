// ignore_for_file: empty_catches, duplicate_ignore

import 'package:addistutor_student/remote_services/user.dart';
import 'package:get/get.dart';
import 'package:addistutor_student/remote_services/service.dart';

class GetLocationController extends GetxController with StateMixin {
  RxList<GetLocationforedit> listlocation = List<GetLocationforedit>.of([]).obs;
  final listLOcationvalue = Rxn<GetLocationforedit>();
  var isfetchedlocation = false.obs;
  var sent = false.obs;
  GetLocation? location;
  void fetchLocation() async {
    try {
      listlocation.value = await RemoteServices.getlocationforedit();

      if (listlocation.isNotEmpty) {
        //print(list.length.toString());
        isfetchedlocation(true);
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  void fetchLocationfor() async {
    try {
      listlocation.value = await RemoteServices.getlocationforedit();

      if (listlocation.isNotEmpty) {
        //print(list.length.toString());
        isfetchedlocation(true);
      }
    } catch (e) {}
  }

  void setLocationStatus(GetLocationforedit zonemodel) {
    listLOcationvalue.value = zonemodel;
  }
}
