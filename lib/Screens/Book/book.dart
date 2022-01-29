// ignore_for_file: deprecated_member_use

/**
 * Author: Aparna Dulal
 * profile: https://github.com/ambikadulal
  */
import 'dart:io';

import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';
import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/controller/bookingcontroller.dart';
import 'package:addistutor_student/controller/getsubjectcontroller.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weekday_selector/weekday_selector.dart';

class BookScreen extends StatefulWidget {
  static List<String> containerList = [];
  const BookScreen({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

GetSubjectController getSubjectController = Get.find();
final ImagePicker _picker = ImagePicker();

late var wtime = '16:30';
late var time = '09:00';
late String sid = "";
late bool weakdays = false;
late bool weakdays2 = false;
late bool ispressd = false;
late bool ispressd2 = false;
late bool ispressd3 = false;
final List<String> _tobeSent = [];
// ignore: unused_element
String? _selectedTime = "Time";

TimeOfDay currentDate = TimeOfDay.now();
var date;

final values = <bool?>[false, false, false, false, false, false, false];
bool ismonday = false;
bool istue = false;
bool iswen = false;
bool isthe = false;
bool isfri = false;
bool issat = false;
bool issun = false;
TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial;

class _EditPageState extends State<BookScreen> {
  final BookingeController bookingeController = Get.put(BookingeController());
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
        getSubjectController.sub = subject[0];
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool _autovalidate = false;

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
        body: Form(
          key: bookingeController.book,
          child: SmartRefresher(
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
                        value: bookingeController.sessions.value,
                        isExpanded: true,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        items: <String>[
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12',
                          '13',
                          '14',
                          '15',
                          '16',
                          '17',
                          '18',
                          '19',
                          '20',
                          '21',
                          '22',
                          '23',
                          '24',
                          '25',
                          '26',
                          '27',
                          '28',
                          '29',
                          '30',
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
                            bookingeController.sessions.value = value!;
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
                      WeekdaySelector(
                          selectedFillColor: kPrimaryColor,
                          onChanged: (v) {
                            printIntAsDay(v);

                            setState(() {
                              values[v % 7] = !values[v % 7]!;
                              //    mon;
                            });

                            print(values);

                            if (values[1] == true) {
                              ismonday = true;

                              bookingeController.Mon.text = "Monday";
                            } else if (values[1] == false) {
                              ismonday = false;
                              bookingeController.Mon.text = "";
                            }

                            //    thu;
                            if (values[2] == true) {
                              istue = true;

                              bookingeController.Tue.text = "Tuesday";
                            } else if (values[2] == false) {
                              istue = false;
                              bookingeController.Tue.text = "";
                            }

                            //    Wen;
                            if (values[3] == true) {
                              iswen = true;

                              bookingeController.Wed.text = "Wednesday";
                            } else if (values[3] == false) {
                              iswen = false;
                              bookingeController.Wed.text = "";
                            }

                            //    The;
                            if (values[4] == true) {
                              isthe = true;

                              bookingeController.Thu.text = "Thursday";
                            } else if (values[4] == false) {
                              isthe = false;
                              bookingeController.Thu.text = "";
                            }
                            //    fri;
                            if (values[5] == true) {
                              isfri = true;

                              bookingeController.Fri.text = "Friday";
                            } else if (values[5] == false) {
                              isfri = false;
                              bookingeController.Fri.text = "";
                            }

                            //    sat;
                            if (values[6] == true) {
                              issat = true;

                              bookingeController.Sat.text = "Saturday";
                            } else if (values[6] == false) {
                              issat = false;
                              bookingeController.Sat.text = "";
                            }

                            if (values[0] == true) {
                              issun = true;

                              bookingeController.Sun.text = "Sunday";
                            } else if (values[0] == false) {
                              issun = false;
                              bookingeController.Sun.text = "";
                            }
                          },
                          values: values,
                          selectedElevation: 15,
                          elevation: 5,
                          disabledElevation: 0,
                          shortWeekdays: const [
                            'Sun', // Sunday
                            'Mon', // MOONday
                            'Tue', // https://en.wikipedia.org/wiki/Names_of_the_days_of_the_week
                            'Wed', // I ran out of ideas...
                            'Thur', // Thirst-day
                            'Fri', // It's Friday, Friday, Gotta get down on Friday!
                            'Sat', // Everybody's lookin' forward to the weekend, weekend
                          ]),
                      const SizedBox(height: 20),
                      ismonday
                          ? Row(children: [
                              const Text("Monday time:-  "),
                              DropdownButton<String>(
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
                            ])
                          : Container(),
                      istue
                          ? Row(children: [
                              const Text("Tuesday time:-  "),
                              DropdownButton<String>(
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
                                ].map<DropdownMenuItem<String>>(
                                    (String value2) {
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
                            ])
                          : Container(),
                      iswen
                          ? Row(children: [
                              const Text("Wednesday time:-  "),
                              DropdownButton<String>(
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
                                ].map<DropdownMenuItem<String>>(
                                    (String value3) {
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
                            ])
                          : Container(),
                      isthe
                          ? Row(children: [
                              const Text("Thursday time:-  "),
                              DropdownButton<String>(
                                value: wtime4,
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
                                ].map<DropdownMenuItem<String>>(
                                    (String value4) {
                                  return DropdownMenuItem<String>(
                                    value: value4,
                                    child: Text(
                                      value4,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value4) {
                                  setState(() {
                                    wtime4 = value4!;
                                  });
                                },
                              ),
                            ])
                          : Container(),
                      isfri
                          ? Row(children: [
                              const Text("Friday time:-  "),
                              DropdownButton<String>(
                                value: wtime5,
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
                                ].map<DropdownMenuItem<String>>(
                                    (String value4) {
                                  return DropdownMenuItem<String>(
                                    value: value4,
                                    child: Text(
                                      value4,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value4) {
                                  setState(() {
                                    wtime5 = value4!;
                                  });
                                },
                              ),
                            ])
                          : Container(),
                      issat
                          ? Row(children: [
                              const Text("Saturday time:-  "),
                              DropdownButton<String>(
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
                            ])
                          : Container(),
                      issun
                          ? Row(children: [
                              const Text("Sunday time:-  "),
                              DropdownButton<String>(
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
                                    time2 = value!;
                                  });
                                },
                              )
                            ])
                          : Container(),
                      // buildTextFieldstudent(
                      //     "data and time", "Evan kutto", false),
                      // ispressd
                      //     ? buildTextFieldstudent2(
                      //         "data and time", "Evan kutto", false)
                      //     : Container(),
                      // ispressd2
                      //     ? buildTextFieldstudent3(
                      //         "data and time", "Evan kutto", false)
                      //     : Container(),

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
                              var value;
                              value =
                                  values.where((item) => item == true).length;
                              if (value != 0) {
                                if (value > 3) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                        'Error Please Select only 3 days',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                          fontFamily: 'WorkSans',
                                        ),
                                      ),
                                      content: const Text(
                                        'You canot book one date more than 3 days /weak',
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
                                                    Navigator.of(context)
                                                        .pop(true);
                                                    setState(() {
                                                      // isLoading = false;
                                                    });
                                                  },
                                                  child:
                                                      Center(child: Text('ok')),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  Cricular();
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      'Error Please Select  3 days',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                        fontFamily: 'WorkSans',
                                      ),
                                    ),
                                    content: const Text(
                                      'You canot book one date more than 3 days /weak',
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
                                                  Navigator.of(context)
                                                      .pop(true);
                                                  setState(() {
                                                    // isLoading = false;
                                                  });
                                                },
                                                child:
                                                    Center(child: Text('ok')),
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                );
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
              value: bookingeController.days.value,
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
                  bookingeController.days.value = value!;

                  bookingeController.daylist.add(value);

                  if (bookingeController.days.value == "Sat") {
                    weakdays = true;
                  } else if (bookingeController.days.value == "Sun") {
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
            ispressd
                ? Container()
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        ispressd = true;
                      });
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                  ),
          ],
        ),
      ]),
    );
  }

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
              value: bookingeController.days2.value,
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
                  bookingeController.days2.value = value2!;

                  bookingeController.daylist.add(value2);
                  if (bookingeController.days2.value == "Sat") {
                    weakdays2 = true;
                  } else if (bookingeController.days2.value == "Sun") {
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

            GestureDetector(
              onTap: () {
                setState(() {
                  ispressd = false;
                  bookingeController.daylist
                      .remove(bookingeController.days2.value);
                });
              },
              child: const Icon(
                Icons.minimize,
                color: Colors.red,
              ),
            ),
            ispressd2
                ? Container()
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        ispressd2 = true;
                      });
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                  ),
          ],
        ),
      ]),
    );
  }

  late var wtime3 = "16:30";
  late var wtime4 = "16:30";
  late var wtime5 = "16:30";
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
              value: bookingeController.days3.value,
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
                  bookingeController.days3.value = value3!;

                  bookingeController.daylist.add(value3);
                  if (bookingeController.days3.value == "Sat") {
                    weakdays3 = true;
                  } else if (bookingeController.days3.value == "Sun") {
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

            GestureDetector(
              onTap: () {
                setState(() {
                  ispressd2 = false;
                  bookingeController.daylist
                      .remove(bookingeController.days3.value);
                });
              },
              child: const Icon(
                Icons.minimize,
                color: Colors.red,
              ),
            ),
            ispressd3
                ? Container()
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        ispressd3 = true;
                      });
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
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
                    bookingeController.Booking(context);
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

  printIntAsDay(int day) {
    print(
        'Received integer: $day. Corresponds to day: ${intDayToEnglish(day)}');
    // if (intDayToEnglish(day) == "Monday") {

    // }

    // a.add(intDayToEnglish(day));

    // // ignore: avoid_print
    // print(a.length);
  }

  String intDayToEnglish(int day) {
    if (day % 7 == DateTime.monday % 7) return 'Monday';
    if (day % 7 == DateTime.tuesday % 7) return 'Tuesday';
    if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
    if (day % 7 == DateTime.thursday % 7) return 'Thursday';
    if (day % 7 == DateTime.friday % 7) return 'Friday';
    if (day % 7 == DateTime.saturday % 7) return 'Saturday';
    if (day % 7 == DateTime.sunday % 7) return 'Sunday';
    throw '🐞 This should never have happened: $day';
  }
}
