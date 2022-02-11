// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:addistutor_student/Screens/Appointment/components/appointmentscreen.dart';
import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
    super.initState();
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
    animationController?.dispose();
    super.dispose();
  }

  final Color divider = Colors.grey.shade600;
  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Image.asset('assets/design_course/webInterFace.png'),
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
                  child: SingleChildScrollView(
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
                            padding:
                                EdgeInsets.only(top: 32.0, left: 18, right: 16),
                            child: Text(
                              "Tutor info",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    Text(
                                      widget.hotelData!.teacher.rating,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 15,
                                        fontFamily: 'WorkSans',
                                        letterSpacing: 0.27,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: DesignCourseAppTheme.nearlyBlue,
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
                                letterSpacing: 0.27,
                                color: DesignCourseAppTheme.grey,
                              ),
                            ),
                          ),
                          _buildDivider(),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10.0, left: 18, right: 16),
                            child: Row(children: [
                              const Text(
                                "Booking info",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  fontFamily: 'WorkSans',
                                  letterSpacing: 0.27,
                                  color: DesignCourseAppTheme.darkerText,
                                ),
                              ),
                              SizedBox(width: 20),
                              widget.hotelData!.is_active == null
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: 20.0,
                                          height: 20.0,
                                          decoration: const BoxDecoration(
                                              color: Colors.yellow,
                                              shape: BoxShape.circle),
                                          alignment: Alignment.center,
                                        ),
                                        const SizedBox(height: 5.0),
                                        const SizedBox(width: 10),
                                        const Text(
                                          " we have contacted the tutor on your \n behalf and waiting for confirmation",
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
                                                  color: Colors.green,
                                                  shape: BoxShape.circle),
                                              alignment: Alignment.center,
                                            ),
                                            const SizedBox(width: 20),
                                            const Text(
                                              "you have ongoing tutor",
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
                                                  color: Colors.red,
                                                  shape: BoxShape.circle),
                                              alignment: Alignment.center,
                                            ),
                                            const SizedBox(width: 20),
                                            const Text(
                                              "the tutor declined your request",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        )
                            ]),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  getTimeBoxUI(
                                      widget.hotelData!.booking_schedule.length
                                          .toString(),
                                      'Subject'),
                                  getTimeBoxUI(
                                      widget.hotelData!.session.toString(),
                                      'session'),
                                  widget.hotelData!.subject.title != null
                                      ? getTimeBoxUIday(
                                          widget.hotelData!.subject.title +
                                              "subject ")
                                      : getTimeBoxUIday(
                                          "subject not defind" " "),
                                ],
                              ),
                            ),
                          ),
                          const Center(
                            child: Text(
                              "Days Booked",
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
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
                                itemCount:
                                    widget.hotelData!.booking_schedule.length),
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
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
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
    );
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
              });
            },
            updateOnDrag: true,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              getReqBooking.rating(
                  context, widget.hotelData!.booking_schedule[0].booking_id);
              Navigator.of(context).pop(true);
              // Navigator.pop(context);
            },
            child: const Center(child: Text('ok')),
          ),
        ],
      ),
    );
  }
}
