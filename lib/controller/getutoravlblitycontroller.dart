import 'package:addistutor_student/Screens/Book/book.dart';
import 'package:addistutor_student/controller/bookingcontroller.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:addistutor_student/remote_services/service.dart';

class GetTutorAvlblityController extends GetxController with StateMixin {
  var listdate = <Day>[].obs;
  var isfetchedlocation = false.obs;
  var sent = false.obs;
  Day? day;

  void fetchDay(var id) async {
    print("object2");
    listdate.value = await RemoteServices.getAvalbledate(id);

    if (listdate.isNotEmpty) {
      //print(list.length.toString());

      //  isfetchedlocation(true);

      isfetchedlocation(true);
    }
  }
}
