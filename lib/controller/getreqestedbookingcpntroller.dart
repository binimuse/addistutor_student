import 'package:addistutor_student/remote_services/user.dart';
import 'package:get/get.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class GetReqBooking extends GetxController with StateMixin {
  var listsubject = <RequestedBooking>[].obs;
  var isfetchedsubject = false.obs;
  var sent = false.obs;
  List<MultiSelectItem<GetSubject>> hobItem = [];

  void fetchReqBooking(var id) async {
    listsubject.value = await RemoteServices.getrequestedbooking(id);

    if (listsubject.isNotEmpty) {
      //print(list.length.toString());
      isfetchedsubject(true);
    }
  }
}
