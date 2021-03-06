// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison, deprecated_member_use

import 'package:addistutor_student/Screens/Appointment/components/appointmentscreen.dart';

import 'package:addistutor_student/controller/getqrcontroller.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../constants.dart';
import 'design_course_app_theme.dart';

class CourseInfoQr extends StatefulWidget {
  const CourseInfoQr({Key? key, this.hotelData, this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final RequestedBooking? hotelData;

  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoQr>
    with TickerProviderStateMixin {
  final double _initialRating = 0.0;
  bool rating = false;
  final bool _isVertical = false;
  IconData? _selectedIcon;
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  final GetQrCode getQrCode = Get.put(GetQrCode());
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    getqr();
    // _getsubject();
    super.initState();
  }

  getqr() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    getQrCode.fetchqr(widget.hotelData!.id);
  }

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
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Obx(() => getQrCode.isfetchedsubject.value
        ? Container(
            color: DesignCourseAppTheme.nearlyWhite,
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
                    top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
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
                              widget.hotelData!.teacher.first_name != null
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          top: 32.0, left: 18, right: 16),
                                      child: Text(
                                        widget.hotelData!.teacher.first_name +
                                            " " +
                                            widget.hotelData!.teacher.last_name,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22,
                                          letterSpacing: 0.27,
                                          color:
                                              DesignCourseAppTheme.darkerText,
                                        ),
                                      ),
                                    )
                                  : const Padding(
                                      padding:
                                          EdgeInsets.only(left: 18, right: 16),
                                      child: Text(
                                        "first_name",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22,
                                          letterSpacing: 0.27,
                                          color:
                                              DesignCourseAppTheme.darkerText,
                                        ),
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Center(
                                  child: Row(children: [
                                    const Icon(
                                      Icons.leak_add_rounded,
                                      color: kPrimaryLightColor,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(widget.hotelData!.sessiontaken
                                            .toString() +
                                        " "
                                            "sessions taken"),
                                  ]),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    bottom: 8,
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 50),
                                                child: Center(
                                                  child: QrImage(
                                                    data: '{"code":"' +
                                                        getQrCode.getqr +
                                                        '", "booking_id": "' +
                                                        widget.hotelData!.id
                                                            .toString() +
                                                        '"}',
                                                    version: QrVersions.auto,
                                                    size: 200.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: opacity3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, bottom: 16, right: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            giverating();
                                          });
                                        },
                                        child: Center(
                                          child: Row(children: const [
                                            Icon(
                                              Icons.star,
                                              color: kPrimaryLightColor,
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              "Rate Tutor",
                                            ),
                                          ]),
                                        ),
                                      ),
                                      rating ? giverating() : Container(),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).padding.bottom,
                              )
                            ],
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
                                  "https://nextgeneducation.et/api/teacher-profile-picture/${widget.hotelData!.teacher.id}",
                                )))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
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
          )
        : const Center(child: CircularProgressIndicator()));
  }

  giverating() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: RatingBar.builder(
            initialRating: _initialRating,
            minRating: 1,
            direction: _isVertical ? Axis.vertical : Axis.horizontal,
            allowHalfRating: true,
            unratedColor: Colors.amber.withAlpha(50),
            itemCount: 5,
            itemSize: 20.0,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              _selectedIcon ?? Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                getReqBooking.ratings = rating.toString();

                //    print(widget.hotelData!.booking_schedule[0].booking_id);
              });
            },
            updateOnDrag: true,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              getReqBooking.rating(context, widget.hotelData!.id);
              Navigator.of(context).pop(true);
              // Navigator.pop(context);
            },
            child: const Center(child: Text('ok')),
          ),
        ],
      ),
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
}
