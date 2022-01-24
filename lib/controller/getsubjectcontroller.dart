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

  void fetchLocation(var id) async {
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
  }
}
