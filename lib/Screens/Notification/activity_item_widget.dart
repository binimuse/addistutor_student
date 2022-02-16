import 'package:addistutor_student/Screens/Appointment/components/appointmentscreen.dart';
import 'package:addistutor_student/Screens/Home/components/course_info_screen_rating.dart';
import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';
import 'package:addistutor_student/Screens/Home/components/singlebooingpage.dart';

import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/controller/getnotificationcontoller.dart';
import 'package:addistutor_student/controller/getreqestedbookingcpntroller.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityItemWidget extends StatefulWidget {
  final Notifications? data;
  const ActivityItemWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

final GetReqBooking requestedBooking = Get.put(GetReqBooking());

class _ProfileScreenState extends State<ActivityItemWidget>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();

    super.initState();
  }

  var bid;

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  final Color divider = Colors.grey.shade600;

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
                widget.data!.data.message == "Booking accepted"
                    ? Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: widget.data!.data.message,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkText,
                                  )),
                              TextSpan(
                                  text:
                                      "\nby " + widget.data!.data.teacher_name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkText,
                                  )),
                              TextSpan(
                                  text: " " + widget.data!.created_at,
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
                                  text: widget.data!.data.message,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkText,
                                  )),
                              TextSpan(
                                  text:
                                      "\nby " + widget.data!.data.teacher_name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkText,
                                  )),
                              TextSpan(
                                  text: " " + widget.data!.created_at,
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
          onTap: () async {
            Navigator.push(
              Get.context!,
              MaterialPageRoute(
                  builder: (context) => SinglebookingPage(
                      hotelData: widget.data!.data.booking_id)),
            );
          },
        ));
  }

  Widget getTimeBoxUIday(String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showPopup(var ids) {
    final RequestedBooking booking = requestedBooking.listsubject5;
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
              color: Color.fromRGBO(243, 245, 248, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 24,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Text(
                        booking.teacher.first_name,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                ),
                ListView.builder(
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                booking.teacher.first_name,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.lightGreen),
                              ),
                              Text(
                                booking.teacher.first_name,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: 1,
                  padding: const EdgeInsets.all(0),
                ),
              ],
            ),
            controller: scrollController,
          ),
        );
      },
      initialChildSize: 0.65,
      minChildSize: 0.65,
      maxChildSize: 1,
    );
    // return ListView.builder(
    //   physics: const ScrollPhysics(),
    //   scrollDirection: Axis.vertical,
    //   shrinkWrap: true,
    //   itemBuilder: (BuildContext context, int index) {
    //     final RequestedBooking booking = requestedBooking.listsubject5[index];
    //     return Container(
    //       margin: const EdgeInsets.symmetric(horizontal: 32),
    //       padding: const EdgeInsets.all(16),
    //       decoration: const BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.all(Radius.circular(20))),
    //       child: Row(
    //         children: <Widget>[
    //           Stack(children: [
    //             Container(
    //               decoration: BoxDecoration(
    //                   border: Border.all(
    //                       width: 4,
    //                       color: Theme.of(context).scaffoldBackgroundColor),
    //                   boxShadow: [
    //                     BoxShadow(
    //                         spreadRadius: 2,
    //                         blurRadius: 10,
    //                         color: Colors.black.withOpacity(0.1),
    //                         offset: const Offset(0, 10))
    //                   ],
    //                   color: Colors.grey[100],
    //                   borderRadius:
    //                       const BorderRadius.all(Radius.circular(18))),
    //               child: Icon(
    //                 Icons.account_balance_wallet,
    //                 color: Colors.lightBlue[900],
    //               ),
    //               padding: const EdgeInsets.all(12),
    //             ),
    //           ]),
    //           const SizedBox(
    //             width: 16,
    //           ),
    //           Expanded(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Text(
    //                   "payment submitted",
    //                   style: TextStyle(
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w700,
    //                       color: Colors.grey[900]),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: <Widget>[
    //               Text(
    //                 booking.teacher.first_name + " Birr",
    //                 style: const TextStyle(
    //                     fontSize: 18,
    //                     fontWeight: FontWeight.w700,
    //                     color: Colors.lightGreen),
    //               ),
    //               Text(
    //                 booking.teacher.first_name,
    //                 style: TextStyle(
    //                     fontSize: 15,
    //                     fontWeight: FontWeight.w700,
    //                     color: Colors.grey[500]),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    //   itemCount: requestedBooking.listsubject.length,
    //   padding: const EdgeInsets.all(0),
    // );
  }

  // Widget _showPopup() {
  //   // must use StateSetter to update data between main screen and popup.
  //   // if use default setState, the data will not update

  // }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
