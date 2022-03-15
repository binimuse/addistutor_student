// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, deprecated_member_use, duplicate_ignore

import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class GetReqBooking extends GetxController with StateMixin {
  var listsubject = <RequestedBooking>[].obs;
  var isfetchedsubject = false.obs;
  var sent = false.obs;
  var ratings;
  List<MultiSelectItem<GetSubject>> hobItem = [];
  var isLoading = false.obs;
  void fetchReqBooking(var id) async {
    listsubject.value = await RemoteServices.getrequestedbooking(id, "");

    if (listsubject.isNotEmpty) {
      //print(list.length.toString());
      isfetchedsubject(true);
      update();
    }
  }

  var listsubject5;
  var isfetchedsubject5 = false.obs;

  var fname;
  var mname;
  var genders;
  var facebook;
  var ratingt;
  late int tid;
  var bid;
  var session;

//booking_schedule
  List<Bookingschedule> reqdate = [];

  var is_active;

  var title;

  getsingle(var id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    listsubject5 = await RemoteServices.getsinglebooking(id);

    if (listsubject5 != null) {
      //print(list.length.toString());
      bid = listsubject5!.id.toString();
      fname = listsubject5!.teacher.first_name.toString();
      mname = listsubject5!.teacher.middle_name.toString();
      genders = listsubject5!.teacher.gender.toString();
      ratingt = listsubject5!.teacher.rating.toString();
      tid = listsubject5!.teacher.id;
      session = listsubject5!.session.toString();
      //
      reqdate = listsubject5!.booking_schedule;
      is_active = listsubject5!.is_active.toString();
      title = listsubject5!.subject.title.toString();

      isfetchedsubject5(true);
    }
  }

  var edited = "";
  Future<void> rating(context, b_id) async {
    openAndCloseLoadingDialog(context);

    var data = {
      "rating": ratings,
    };

    edited = await RemoteServices.rating(data, b_id);
    //print(edited.toString());
    if (edited.toString() == "200") {
      closeDialogpassword(true, edited, context);
      isLoading(false);
    } else {
      //inforesponse = edited;
      closeDialogpassword(false, edited, context);

      //  print(edited.toString());
    }
  }

  closeDialogpassword(bool stat, String data, BuildContext context) {
    Future.delayed(const Duration(seconds: 1));
    // Dismiss CircularProgressIndicator
    Navigator.of(context).pop();
    if (stat == false) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Rating  Not Updated \n ' + data.toString(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                update();
                Navigator.of(context).pop(true);
                Navigator.pop(context);
                isLoading(false);
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
    } else {
      // ignore: deprecated_member_use

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Rating Edited',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () async {
                isLoading(false);
                update();
                Navigator.of(context).pop(true);

                Navigator.pop(context);
                isLoading(false);
              },
              child: const Text('ok'),
            ),
          ],
        ),
      );
    }
  }

  void openAndCloseLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.grey.withOpacity(0.3),
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              color: kPrimaryColor,
              strokeWidth: 8,
            ),
          ),
        ),
      ),
    );
  }
}
