import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';
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
                const Icon(Icons.notification_add, color: kPrimaryColor),
                data!.data.message == "Booking accepted"
                    ? Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: data!.data.message,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkText,
                                  )),
                              TextSpan(
                                  text: "\nby " + data!.data.teacher_name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkText,
                                  )),
                              TextSpan(
                                  text: " " + data!.created_at,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.grey,
                                  ))
                            ]))))
                    : Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: data!.data.message,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkText,
                                  )),
                              TextSpan(
                                  text: "\nby " + data!.data.teacher_name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkText,
                                  )),
                              TextSpan(
                                  text: " " + data!.created_at,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.grey,
                                  )),
                            ])))),
              ],
            ),
          ),
          onTap: () {},
        ));
  }
}
