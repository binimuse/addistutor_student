// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe, invalid_use_of_protected_member

import 'package:addistutor_student/Screens/Book/getavalablity.dart';
import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';
import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/controller/bookingcontroller.dart';
import 'package:addistutor_student/controller/getsubjectcontroller.dart';
import 'package:addistutor_student/controller/getutoravlblitycontroller.dart';
import 'package:addistutor_student/controller/getutoravlblitycontroller.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weekday_selector/weekday_selector.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({
    Key? key,
    this.hotelData,
  }) : super(key: key);

  final Search? hotelData;
  static List<String> containerList = [];

  @override
  _EditPageState createState() => _EditPageState();
}

GetSubjectController getSubjectController = Get.find();
GetTutorAvlblityController getTutorAvlblityController =
    Get.put(GetTutorAvlblityController());
late bool weakdays3 = false;

late String sid = "";
late bool weakdays = false;
late bool weakdays2 = false;
late bool ispressd = false;
late bool ispressd2 = false;
late bool ispressd3 = false;

// ignore: unused_element
String? _selectedTime = "Time";

TimeOfDay currentDate = TimeOfDay.now();

var values = <bool?>[false, false, false, false, false, false, false];

TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial;

class _EditPageState extends State<BookScreen> {
  final BookingeController bookingeController = Get.put(BookingeController());
  @override
  void initState() {
    super.initState();
    _getsubject();
    getTutorAvlblityController.fetchDay("2");
  }

  List<String> avalbledate = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: bookingeController.scaffoldKey,
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
              padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
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
                              'Subject:',
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
                                    bookingeController.subjectid = value.id;
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
                        value: bookingeController.sessionsd.value,
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
                            bookingeController.sessionsd.value = value!;
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
                            bookingeController.selecteddate.clear();
                            printIntAsDay(v);

                            setState(() {
                              values[v % 7] = !values[v % 7]!;
                              //    mon;
                            });

                            if (values[1] == true) {
                              bookingeController.ismonday = true;
                            } else if (values[1] == false) {
                              bookingeController.ismonday = false;
                              bookingeController.Mon = "";
                            }

                            //    thu;
                            if (values[2] == true) {
                              bookingeController.istue = true;
                            } else if (values[2] == false) {
                              bookingeController.istue = false;
                              bookingeController.Tue = "";
                            }

                            //    Wen;
                            if (values[3] == true) {
                              bookingeController.iswen = true;
                            } else if (values[3] == false) {
                              bookingeController.iswen = false;
                              bookingeController.Wed = "";
                            }

                            //    The;
                            if (values[4] == true) {
                              bookingeController.isthe = true;
                            } else if (values[4] == false) {
                              bookingeController.isthe = false;
                              bookingeController.Thu = "";
                            }
                            //    fri;
                            if (values[5] == true) {
                              bookingeController.isfri = true;
                            } else if (values[5] == false) {
                              bookingeController.isfri = false;
                              bookingeController.Fri = "";
                            }

                            //    sat;
                            if (values[6] == true) {
                              bookingeController.issat = true;
                            } else if (values[6] == false) {
                              bookingeController.issat = false;
                              bookingeController.Sat = "";
                            }

                            if (values[0] == true) {
                              bookingeController.issun = true;
                            } else if (values[0] == false) {
                              bookingeController.issun = false;
                              bookingeController.Sun = "";
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
                      bookingeController.ismonday
                          ? Row(children: [
                              const Text("Monday time:-  "),
                              DropdownButton<String>(
                                value: bookingeController.motime,
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
                                    bookingeController.motime = value!;
                                    bookingeController.Mon = "Monday";
                                  });
                                },
                              ),
                            ])
                          : Container(),
                      bookingeController.istue
                          ? Row(children: [
                              const Text("Tuesday time:-  "),
                              DropdownButton<String>(
                                value: bookingeController.tuetime2,
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
                                    bookingeController.tuetime2 = value2!;
                                    bookingeController.Tue = "Tuesday";
                                  });
                                },
                              ),
                            ])
                          : Container(),
                      bookingeController.iswen
                          ? Row(children: [
                              const Text("Wednesday time:-  "),
                              DropdownButton<String>(
                                value: bookingeController.wentime3,
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
                                    bookingeController.wentime3 = value3!;
                                    bookingeController.Wed = "Wednesday";
                                  });
                                },
                              ),
                            ])
                          : Container(),
                      bookingeController.isthe
                          ? Row(children: [
                              const Text("Thursday time:-  "),
                              DropdownButton<String>(
                                value: bookingeController.thetime4,
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
                                    bookingeController.thetime4 = value4!;
                                    bookingeController.Thu = "Thursday";
                                  });
                                },
                              ),
                            ])
                          : Container(),
                      bookingeController.isfri
                          ? Row(children: [
                              const Text("Friday time:-  "),
                              DropdownButton<String>(
                                value: bookingeController.fritime5,
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
                                    bookingeController.fritime5 = value4!;
                                    bookingeController.Fri = "Friday";
                                  });
                                },
                              ),
                            ])
                          : Container(),
                      bookingeController.issat
                          ? Row(children: [
                              const Text("Saturday time:-  "),
                              DropdownButton<String>(
                                value: bookingeController.sattime,
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
                                    bookingeController.sattime = value!;
                                    bookingeController.Sat = "Saturday";
                                  });
                                },
                              )
                            ])
                          : Container(),
                      bookingeController.issun
                          ? Row(children: [
                              const Text("Sunday time:-  "),
                              DropdownButton<String>(
                                value: bookingeController.suntime2,
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
                                    bookingeController.suntime2 = value!;
                                    bookingeController.Sun = "Sunday";
                                  });
                                },
                              )
                            ])
                          : Container(),
                      Row(
                        children: [
                          Center(
                            child: RaisedButton(
                              onPressed: () {
                                var value;
                                value =
                                    values.where((item) => item == true).length;
                                if (value != 0) {
                                  Cricular();
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                        'Error ',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                          fontFamily: 'WorkSans',
                                        ),
                                      ),
                                      content: const Text(
                                        'Please Select  days',
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
                                                  child: const Center(
                                                      child: Text('ok')),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                setState(() {
                                  values = <bool?>[
                                    false,
                                    false,
                                    false,
                                    false,
                                    false,
                                    false,
                                    false
                                  ];
                                });
                              },
                              color: kPrimaryColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
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
                            ),
                          ),
                          FutureBuilder(
                              future: RemoteServices.getAvalbledate("1"),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                }
                                if (snapshot.hasData) {
                                  return Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return FollowedList(
                                            day: snapshot.data[index]);
                                      },
                                      itemCount: snapshot.data.length,
                                    ),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ));
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
                  child: const Center(child: Text('No')),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    bookingeController.Booking(context, widget.hotelData!.id);
                  },
                  child: const Center(child: Text('Yes')),
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
  }

  String intDayToEnglish(int day) {
    if (day % 7 == DateTime.monday % 7) return 'monday';
    if (day % 7 == DateTime.tuesday % 7) return 'Tuesday';
    if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
    if (day % 7 == DateTime.thursday % 7) return 'Thursday';
    if (day % 7 == DateTime.friday % 7) return 'Friday';
    if (day % 7 == DateTime.saturday % 7) return 'Saturday';
    if (day % 7 == DateTime.sunday % 7) return 'Sunday';
    throw '🐞 This should never have happened: $day';
  }
}

class FollowedList extends StatefulWidget {
  final Day? day;

  const FollowedList({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  _SettingsScreenState2 createState() => _SettingsScreenState2();
}

final BookingeController bookingeController = Get.find();

class _SettingsScreenState2 extends State<FollowedList> {
  @override
  void initState() {
    // TODO: implement initState

    if (widget.day!.day != null) {
      print(widget.day!.day);
      bookingeController.daylist.add(widget.day!.day);
      // values.clear();
    } else {}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: Container());
  }
}
