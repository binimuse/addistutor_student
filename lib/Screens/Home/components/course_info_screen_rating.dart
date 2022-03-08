// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'dart:convert';

import 'package:addistutor_student/Screens/Appointment/components/appointmentscreen.dart';
import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/controller/endbookingcontroller.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'design_course_app_theme.dart';

class CourseInfoScreenRating extends StatefulWidget {
  const CourseInfoScreenRating({
    Key? key,
    this.hotelData,
  }) : super(key: key);
  final RequestedBooking? hotelData;
  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreenRating>
    with TickerProviderStateMixin {
  final double _initialRating = 2.0;
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  final bool _isVertical = false;
  bool rating = false;
  IconData? _selectedIcon;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    _fetchUser();
    //
    super.initState();
  }

  final EndBookingContoller endBookingContoller =
      Get.put(EndBookingContoller());
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

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {
      // _getlocation();
      // _fetchUser();
      _fetchUser();
    });
    _refreshController.refreshCompleted();
  }

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      // var id = editprofileController.fetchPf(body["student_id"]);
      // print(body["student_id"]);
      //   walletContoller.getbalance(body["student_id"]);
      setState(() {
        //  walletContoller.getbalance(body["student_id"]);

        getReqBooking.fetchReqBooking(body["student_id"]);
      });
    }
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  final Color divider = Colors.grey.shade600;
  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        55.0;
    return Obx(() => Container(
        color: DesignCourseAppTheme.nearlyWhite,
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,

          //cheak pull_to_refresh
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: Image.asset('assets/images/lg3.png'),
                    ),
                  ],
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.2) - 34.0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: DesignCourseAppTheme.nearlyWhite,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: DesignCourseAppTheme.grey.withOpacity(0.2),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: infoHeight,
                              maxHeight: tempHeight > infoHeight
                                  ? tempHeight
                                  : infoHeight),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 32.0, left: 18, right: 16),
                                child: Text(
                                  "Tutor Profile",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.27,
                                    color: DesignCourseAppTheme.darkerText,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 8, top: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      widget.hotelData!.teacher.first_name +
                                          " " +
                                          widget.hotelData!.teacher.last_name,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 15,
                                        fontFamily: 'WorkSans',
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.grey,
                                      ),
                                    ),
                                    Text(
                                      widget.hotelData!.teacher.gender,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 15,
                                        fontFamily: 'WorkSans',
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.grey,
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        widget.hotelData!.teacher.rating != null
                                            ? Text(
                                                widget
                                                    .hotelData!.teacher.rating,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 15,
                                                  fontFamily: 'WorkSans',
                                                  letterSpacing: 0.27,
                                                ),
                                              )
                                            : const Text(
                                                "",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 15,
                                                  fontFamily: 'WorkSans',
                                                  letterSpacing: 0.27,
                                                ),
                                              ),
                                        const Icon(
                                          Icons.star,
                                          color: kPrimaryLightColor,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 18, right: 16),
                                child: Text(
                                  widget.hotelData!.teacher.about,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15,
                                    fontFamily: 'WorkSans',
                                    letterSpacing: 0.17,
                                    color: DesignCourseAppTheme.grey,
                                  ),
                                ),
                              ),
                              _buildDivider(),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 18, right: 16),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Booking info",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            fontFamily: 'WorkSans',
                                            letterSpacing: 0.27,
                                            color:
                                                DesignCourseAppTheme.darkerText,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        widget.hotelData!.ended_at != null
                                            ? Column(
                                                children: <Widget>[
                                                  Container(
                                                    width: 20.0,
                                                    height: 20.0,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                kPrimaryColor,
                                                            shape: BoxShape
                                                                .circle),
                                                    alignment: Alignment.center,
                                                  ),
                                                  const SizedBox(height: 5.0),
                                                  Text(
                                                    "Booking Ended",
                                                    style: TextStyle(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : getstutus(widget.hotelData),
                                      ]),
                                ),
                              ),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: opacity1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: <Widget>[
                                      getTimeBoxUIday(
                                          widget.hotelData!.subject.title),
                                      getTimeBoxUI(
                                          widget.hotelData!.session.toString(),
                                          'session'),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, index) {
                                      return Column(
                                        children: [
                                          getTimeBoxUIday(widget.hotelData!
                                                  .booking_schedule[index].day +
                                              " " +
                                              widget
                                                  .hotelData!
                                                  .booking_schedule[index]
                                                  .readable_time),
                                        ],
                                      );
                                    },
                                    itemCount: widget
                                        .hotelData!.booking_schedule.length),
                              ),
                              getReqBooking.isfetchedsubject.value
                                  ? widget.hotelData!.ended_at == null
                                      ? AnimatedOpacity(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          opacity: opacity3,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                bottom: 20,
                                                right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _displayTextInputDialog(
                                                          context,
                                                          widget.hotelData!.id);
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(16.0),
                                                        ),
                                                        boxShadow: <BoxShadow>[
                                                          BoxShadow(
                                                              color: DesignCourseAppTheme
                                                                  .nearlyBlue
                                                                  .withOpacity(
                                                                      0.5),
                                                              offset:
                                                                  const Offset(
                                                                      1.1, 1.1),
                                                              blurRadius: 6.0),
                                                        ],
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'End Booking',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18,
                                                            letterSpacing: 0.0,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : AnimatedOpacity(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          opacity: opacity3,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                bottom: 20,
                                                right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    height: 35,
                                                    width: 10,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(16.0),
                                                      ),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                            color:
                                                                DesignCourseAppTheme
                                                                    .nearlyBlue
                                                                    .withOpacity(
                                                                        0.5),
                                                            offset:
                                                                const Offset(
                                                                    1.1, 1.1),
                                                            blurRadius: 6.0),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Text(
                                                              "Booking ended at : ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 18,
                                                                letterSpacing:
                                                                    0.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Text(
                                                              widget.hotelData!
                                                                  .ended_at,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 18,
                                                                letterSpacing:
                                                                    0.0,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          ]),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                  : Center(
                                      child: Column(children: [
                                      CircularProgressIndicator(),
                                      // const Center(child: Text("No Booked Tutors"))
                                    ])),
                              SizedBox(
                                height: MediaQuery.of(context).padding.bottom,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
                  right: 35,
                  child: ScaleTransition(
                      alignment: Alignment.center,
                      scale: CurvedAnimation(
                          parent: animationController!,
                          curve: Curves.fastOutSlowIn),
                      child: SizedBox(
                          width: 100,
                          height: 70,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(18.0),
                              child: Image.network(
                                "https://tutor.oddatech.com/api/teacher-profile-picture/${widget.hotelData!.teacher.id}",
                              )))),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: SizedBox(
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: DesignCourseAppTheme.nearlyBlack,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
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

  final Color active = Colors.grey.shade800;
  buildRow(
    IconData icon,
    String title,
  ) {
    final TextStyle tStyle =
        TextStyle(color: active, fontSize: 16.0, fontFamily: "WorkSans");
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: kPrimaryColor,
        ),
        const SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        const Spacer(),
      ]),
    );
  }

  final TextEditingController _textFieldController = TextEditingController();
  var valueText;
  Future<void> _displayTextInputDialog(BuildContext context, int id) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: endBookingContoller.Formkey,
            child: AlertDialog(
              title: const Text('End Session'),
              content: TextFormField(
                onChanged: (value) {
                  setState(() {
                    valueText = value;
                  });
                },
                controller: _textFieldController,
                decoration: const InputDecoration(
                    hintText: "Please enter your reason?"),
                validator: (value) {
                  return endBookingContoller.validateName(value!);
                },
              ),
              actions: <Widget>[
                FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: const Text('CANCEL'),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
                FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: const Text('OK'),
                  onPressed: () async {
                    setState(() {
                      //  codeDialog = valueText;
                      endBookingContoller.editProf(context, valueText, id);
                      getReqBooking.fetchReqBooking(id);
                    });

                    setState(() {
                      _fetchUser();
                    });

                    // Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  getstutus(RequestedBooking? hotelData) {
    return widget.hotelData!.is_active == null
        ? Row(
            children: <Widget>[
              Container(
                width: 20.0,
                height: 20.0,
                decoration: const BoxDecoration(
                    color: Colors.yellow, shape: BoxShape.circle),
                alignment: Alignment.center,
              ),
              const SizedBox(height: 5.0),
              const SizedBox(width: 10),
              const Text(
                "We have contacted the tutor on your  behalf and waiting for confirmation",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        : widget.hotelData!.is_active != "0"
            ? Row(
                children: <Widget>[
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    alignment: Alignment.center,
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    "You have ongoing tutor",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Row(
                children: <Widget>[
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    alignment: Alignment.center,
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    "The tutor declined your request",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
  }
}
