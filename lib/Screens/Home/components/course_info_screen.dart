// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:addistutor_student/Screens/Book/book.dart';
import 'package:addistutor_student/Screens/Profile/editprofile.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'design_course_app_theme.dart';

class CourseInfoScreen extends StatefulWidget {
  const CourseInfoScreen({Key? key, this.hotelData, this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final Search? hotelData;

  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();

    _getsubject();
    super.initState();
  }

  List<GetSubject> subject = [];
  _getsubject() {
    getSubjectController.fetchLocation(" ");

    subject = getSubjectController.listsubject.value;

    if (subject != null && subject.isNotEmpty) {
      setState(() {
        getSubjectController.sub = subject[0];
      });
    }
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
                          widget.hotelData!.first_name != null
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: 32.0, left: 18, right: 16),
                                  child: Text(
                                    widget.hotelData!.first_name +
                                        " " +
                                        widget.hotelData!.last_name,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      letterSpacing: 0.27,
                                      color: DesignCourseAppTheme.darkerText,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                      top: 32.0, left: 18, right: 16),
                                  child: Text(
                                    "first_name",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      letterSpacing: 0.27,
                                      color: DesignCourseAppTheme.darkerText,
                                    ),
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                widget.hotelData!.gender != null
                                    ? Text(
                                        widget.hotelData!.gender,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 22,
                                          letterSpacing: 0.27,
                                          color:
                                              DesignCourseAppTheme.nearlyBlue,
                                        ),
                                      )
                                    : Text(
                                        "gender",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 22,
                                          letterSpacing: 0.27,
                                          color:
                                              DesignCourseAppTheme.nearlyBlue,
                                        ),
                                      ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      widget.hotelData!.rating,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 22,
                                        letterSpacing: 0.27,
                                        color: DesignCourseAppTheme.grey,
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: DesignCourseAppTheme.nearlyBlue,
                                      size: 24,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  getTimeBoxUI("location",
                                      widget.hotelData!.location.name),
                                  getTimeBoxUI(
                                      widget.hotelData!
                                          .preferred_tutoring_subjects.length
                                          .toString(),
                                      'Subject'),
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
                                      getTimeBoxUIday(widget
                                          .hotelData!
                                          .preferred_tutoring_subjects[index]
                                          .title),
                                    ],
                                  );
                                },
                                itemCount: widget.hotelData!
                                    .preferred_tutoring_subjects.length),
                          ),
                          widget.hotelData!.about != null
                              ? Expanded(
                                  child: AnimatedOpacity(
                                    duration: Duration(milliseconds: 500),
                                    opacity: opacity2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16, bottom: 18),
                                      child: Center(
                                          child: Text(
                                        widget.hotelData!.about,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16,
                                          fontFamily: 'WorkSans',
                                          color: DesignCourseAppTheme.grey,
                                        ),
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: AnimatedOpacity(
                                    duration: Duration(milliseconds: 500),
                                    opacity: opacity2,
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 16, right: 16, bottom: 18),
                                      child: Center(
                                          child: Text(
                                        "No About",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16,
                                          fontFamily: 'WorkSans',
                                          color: DesignCourseAppTheme.grey,
                                        ),
                                        maxLines: 10,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ),
                                  ),
                                ),
                          GestureDetector(
                            onTap: () async {
                              SharedPreferences localStorage =
                                  await SharedPreferences.getInstance();
                              localStorage.setBool('isupdated', true);
                              var token = localStorage.getString('user');
                              var body;

                              if (token != null) {
                                body = json.decode(token);

                                if (body["student_id"] != null) {
                                  Navigator.pop(context);

                                  Navigator.push<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          BookScreen(
                                              hotelData: widget.hotelData!),
                                    ),
                                  );
                                } else {
                                  //  isLoading(false);

                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                        'Booking',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontFamily: 'WorkSans',
                                        ),
                                      ),
                                      content: const Text(
                                        'Please update profile before booking a tutor',
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
                                            Navigator.of(context).pop(true);

                                            Navigator.push<dynamic>(
                                              context,
                                              MaterialPageRoute<dynamic>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const EditPage(),
                                              ),
                                            );
                                          },
                                          child: const Text('ok'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, bottom: 16, right: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color:
                                              DesignCourseAppTheme.nearlyBlue,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0),
                                          ),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: DesignCourseAppTheme
                                                    .nearlyBlue
                                                    .withOpacity(0.5),
                                                offset: const Offset(1.1, 1.1),
                                                blurRadius: 10.0),
                                          ],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Book',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              letterSpacing: 0.0,
                                              color: DesignCourseAppTheme
                                                  .nearlyWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
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
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
              right: 35,
              child: ScaleTransition(
                  alignment: Alignment.center,
                  scale: CurvedAnimation(
                      parent: animationController!,
                      curve: Curves.fastOutSlowIn),
                  child: Card(
                    color: DesignCourseAppTheme.nearlyBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    elevation: 10.0,
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: Image.network(
                            "https://tutor.oddatech.com/api/teacher-profile-picture/${widget.hotelData!.id}",
                            height: 100.0,
                            width: 110.0,
                          )),
                    ),
                  )),
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
                style: TextStyle(
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
