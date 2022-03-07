import 'package:addistutor_student/remote_services/user.dart';
import 'package:get/get.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class GetSubjectController extends GetxController with StateMixin {
  var listsubject = <GetSubject>[].obs;
  var isfetchedsubject = false.obs;
  var sent = false.obs;
  List<MultiSelectItem<GetSubject>> hobItem = [];

  late List<GetSubject> subject;
  GetSubject? sub;

  void fetchLocation(var id) async {
    try {
      listsubject.value = await RemoteServices.getsubject(id);

      if (listsubject.isNotEmpty) {
        subject = listsubject;
        // ignore: unnecessary_null_comparison
        if (subject != null) {
          hobItem = subject
              .map((hobbies) =>
                  MultiSelectItem<GetSubject>(hobbies, hobbies.title))
              .toList();
        }
        isfetchedsubject(true);
      }
    } catch (e) {}
  }

  var psubj = <Search>[].obs;
  late List<Search> psubject;
  List<MultiSelectItem<Search>> phobItem = [];
  void prefred(var lid, sid, gender) async {
    psubj.value = await RemoteServices.search(lid, sid, gender);
  }
}
