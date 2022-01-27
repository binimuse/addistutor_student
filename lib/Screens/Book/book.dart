// ignore_for_file: deprecated_member_use

/**
 * Author: Aparna Dulal
 * profile: https://github.com/ambikadulal
  */
import 'dart:io';

import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';
import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/controller/getsubjectcontroller.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BookScreen extends StatefulWidget {
  static List<Widget> containerList = [];
  const BookScreen({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

GetSubjectController getSubjectController = Get.find();
final ImagePicker _picker = ImagePicker();

late var sessions = "3 sessions";
late var days = "Mon";
late var wtime = '16:30';
late var time = '09:00';
late String sid = "";
late bool weakdays = false;
late bool weakdays2 = false;
late bool ispressd = false;
final List<String> _tobeSent = [];
// ignore: unused_element
String? _selectedTime = "Time";

TimeOfDay currentDate = TimeOfDay.now();
var date;
TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial;

class _EditPageState extends State<BookScreen> {
  @override
  void initState() {
    super.initState();
    _getsubject();
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {
      // _getlocation();
      // _fetchUser();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    //if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
  }

  List<GetSubject> subject = [];
  _getsubject() {
    getSubjectController.fetchLocation(" ");

    subject = getSubjectController.listsubject.value;

    if (subject != null && subject.isNotEmpty) {
      setState(() {
        getSubjectController.sub = subject![0];
      });
    }
  }

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: Material(
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
          title: const Text(
            "Book Tutor",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
        ),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,

          //cheak pull_to_refresh
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Education Level:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width > 360
                                        ? 18
                                        : 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: DropdownButton<GetSubject>(
                              hint: Text(
                                getSubjectController.sub.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              isExpanded: true,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                              items: subject
                                  .map((e) => DropdownMenuItem(
                                        child: Column(children: [
                                          Text(
                                            e.title,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ]),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  getSubjectController.sub = value!;
                                  //     sid = ("");
                                });
                              },
                              value: getSubjectController.sub),
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const Text(
                      'How many sessions do you want to buy? ',
                      style: TextStyle(color: Colors.black45),
                    ),
                    const Text(
                      'A session is 90 minutes long and you can buy starting from three sessions. ',
                      style: TextStyle(color: Colors.black38),
                    ),
                    DropdownButton<String>(
                      value: sessions,
                      isExpanded: true,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                      items: <String>[
                        '3 sessions',
                        '4 sessions',
                        '5 sessions',
                        '6 sessions',
                        '7 sessions',
                        '8 sessions',
                        '9 sessions',
                        '10 sessions',
                        '11 sessions',
                        '12 sessions',
                        '13 sessions',
                        '14 sessions',
                        '15 sessions',
                        '16 sessions',
                        '17 sessions',
                        '18 sessions',
                        '19 sessions',
                        '20 sessions',
                        '21 sessions',
                        '22 sessions',
                        '23 sessions',
                        '24 sessions',
                        '25 sessions',
                        '26 sessions',
                        '27 sessions',
                        '28 sessions',
                        '29 sessions',
                        '30 sessions',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          sessions = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Date And Time ',
                      style: TextStyle(color: Colors.black38),
                    ),
                    const Text(
                      'Preferred study date and  starting from what time? (24-hour clock)',
                      style: TextStyle(color: Colors.black38),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextFieldstudent("data and time", "Evan kutto", false),
                    buildTextFieldstudent2(
                        "data and time", "Evan kutto", false),
                    buildTextFieldstudent3(
                        "data and time", "Evan kutto", false),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ignore: deprecated_member_use
                        OutlineButton(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {},
                          child: const Text("CANCEL",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black)),
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (days.toString() == days2.toString() ||
                                days.toString() == days3.toString() ||
                                days2.toString() == days.toString() ||
                                days2.toString() == days3.toString() ||
                                days3.toString() == days.toString() ||
                                days3.toString() == days2.toString()) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    'Error Please Select diffrent Date To book',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red,
                                      fontFamily: 'WorkSans',
                                    ),
                                  ),
                                  content: const Text(
                                    'You canot book one date more than once',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontFamily: 'WorkSans',
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Center(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                                setState(() {
                                                  // isLoading = false;
                                                });
                                              },
                                              child: Center(child: Text('ok')),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              Cricular();
                            }
                          },
                          color: kPrimaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "Book",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ]),
            ),
          ),
        ));
  }

  Widget buildTextFieldstudent(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DropdownButton<String>(
              value: days,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
              items: <String>[
                'Mon',
                'Tue',
                'Wed',
                'Thu',
                'Fri',
                'Sat',
                'Sun',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  days = value!;
                  if (days == "Sat") {
                    weakdays = true;
                  } else if (days == "Sun") {
                    weakdays = true;
                  } else {
                    weakdays = false;
                  }
                });
              },
            ),
            SizedBox(width: 50), // give it width

            weakdays
                ? DropdownButton<String>(
                    value: time,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    items: <String>[
                      '09:00',
                      '10:00',
                      '11:00',
                      '12:00',
                      '13:00',
                      '14:00',
                      '15:00',
                      '16:00',
                      '17:00',
                      '18:00',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        time = value!;
                      });
                    },
                  )
                : DropdownButton<String>(
                    value: wtime,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    items: <String>[
                      '16:30',
                      '17:00',
                      '17:30',
                      '18:00',
                      '18:30',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        wtime = value!;
                      });
                    },
                  ),
          ],
        ),
      ]),
    );
  }

  late var days2 = "Mon";
  late var wtime2 = "16:30";
  late var time2 = "09:00";

  Widget buildTextFieldstudent2(
      String labelText2, String placeholder2, bool isPasswordTextField2) {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DropdownButton<String>(
              value: days2,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
              items: <String>[
                'Mon',
                'Tue',
                'Wed',
                'Thu',
                'Fri',
                'Sat',
                'Sun',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                );
              }).toList(),
              onChanged: (value2) {
                setState(() {
                  days2 = value2!;
                  if (days2 == "Sat") {
                    weakdays2 = true;
                  } else if (days2 == "Sun") {
                    weakdays2 = true;
                  } else {
                    weakdays2 = false;
                  }
                });
              },
            ),
            SizedBox(width: 50), // give it width

            weakdays2
                ? DropdownButton<String>(
                    value: time2,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    items: <String>[
                      '09:00',
                      '10:00',
                      '11:00',
                      '12:00',
                      '13:00',
                      '14:00',
                      '15:00',
                      '16:00',
                      '17:00',
                      '18:00',
                    ].map<DropdownMenuItem<String>>((String value2) {
                      return DropdownMenuItem<String>(
                        value: value2,
                        child: Text(
                          value2,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    }).toList(),
                    onChanged: (value2) {
                      setState(() {
                        time2 = value2!;
                      });
                    },
                  )
                : DropdownButton<String>(
                    value: wtime2,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    items: <String>[
                      '16:30',
                      '17:00',
                      '17:30',
                      '18:00',
                      '18:30',
                    ].map<DropdownMenuItem<String>>((String value2) {
                      return DropdownMenuItem<String>(
                        value: value2,
                        child: Text(
                          value2,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    }).toList(),
                    onChanged: (value2) {
                      setState(() {
                        wtime2 = value2!;
                      });
                    },
                  ),
          ],
        ),
      ]),
    );
  }

  late var days3 = "Mon";
  late var wtime3 = "16:30";
  late var time3 = "09:00";
  late bool weakdays3 = false;

  Widget buildTextFieldstudent3(
      String labelText3, String placeholder3, bool isPasswordTextField3) {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DropdownButton<String>(
              value: days3,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
              items: <String>[
                'Mon',
                'Tue',
                'Wed',
                'Thu',
                'Fri',
                'Sat',
                'Sun',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                );
              }).toList(),
              onChanged: (value3) {
                setState(() {
                  days3 = value3!;
                  if (days3 == "Sat") {
                    weakdays3 = true;
                  } else if (days3 == "Sun") {
                    weakdays3 = true;
                  } else {
                    weakdays3 = false;
                  }
                });
              },
            ),
            SizedBox(width: 50), // give it width

            weakdays3
                ? DropdownButton<String>(
                    value: time3,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    items: <String>[
                      '09:00',
                      '10:00',
                      '11:00',
                      '12:00',
                      '13:00',
                      '14:00',
                      '15:00',
                      '16:00',
                      '17:00',
                      '18:00',
                    ].map<DropdownMenuItem<String>>((String value3) {
                      return DropdownMenuItem<String>(
                        value: value3,
                        child: Text(
                          value3,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    }).toList(),
                    onChanged: (value3) {
                      setState(() {
                        time3 = value3!;
                      });
                    },
                  )
                : DropdownButton<String>(
                    value: wtime3,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    items: <String>[
                      '16:30',
                      '17:00',
                      '17:30',
                      '18:00',
                      '18:30',
                    ].map<DropdownMenuItem<String>>((String value3) {
                      return DropdownMenuItem<String>(
                        value: value3,
                        child: Text(
                          value3,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    }).toList(),
                    onChanged: (value3) {
                      setState(() {
                        wtime3 = value3!;
                      });
                    },
                  ),
          ],
        ),
      ]),
    );
  }

  void Cricular() async {
    // Here you can write your code for open new view
    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'booking',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.green,
              fontFamily: 'WorkSans',
            ),
          ),
          content: const Text(
            'Are You Sure you want to Book this Tutor',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          ),
          actions: <Widget>[
            Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    setState(() {
                      // isLoading = false;
                    });
                  },
                  child: Center(child: Text('No')),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    setState(() {
                      // isLoading = false;
                    });
                  },
                  child: Center(child: Text('Yes')),
                ),
              ]),
            ),
          ],
        ),
      );
      EasyLoading.dismiss();
    });
  }
}
