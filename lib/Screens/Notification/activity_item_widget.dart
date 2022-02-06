import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';

class ActivityItemWidget extends StatelessWidget {
  final Notifications? data;
  const ActivityItemWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Row(
              children: <Widget>[
                Icon(Icons.notification_add, color: kPrimaryColor),
                data!.data.message == "Booking accepted"
                    ? Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: data!.data.message,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                              TextSpan(
                                  text: "\nby " + data!.data.teacher_name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                              TextSpan(
                                  text: ' at 11 pm',
                                  style: Theme.of(context).textTheme.subtitle1),
                            ]))))
                    : Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: data!.data.message,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                              TextSpan(
                                  text: ' 11 pm',
                                  style: Theme.of(context).textTheme.subtitle1),
                            ])))),
              ],
            ),
          ),
          onTap: () {},
        ));
  }
}
