// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe, invalid_use_of_protected_member

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

class _EditPageState extends State<BookScreen>
    with SingleTickerProviderStateMixin {
  final BookingeController bookingeController = Get.put(BookingeController());
  @override
  void initState() {
    super.initState();
    _getsubject();
    // getTutorAvlblityController.fetchDay("2");
    bookingeController.isFetched(true);
  }

  List<String> avalbledate = [];
  List<String> avalbledate2 = [];
  final selectedIndexes = [];

  List<String> monday = [
    "monday",
  ];
  List<String> tuesday = [
    "tuesday",
  ];
  List<String> wednesday = [
    "wednesday",
  ];
  List<String> thursday = [
    "thursday",
  ];
  List<String> friday = [
    "friday",
  ];

  List<String> saturday = [
    "saturday",
  ];

  List<String> sunday = [
    "sunday",
  ];
  String isselected = "";
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

  String date = "";
  DateTime selectedDate = DateTime.now();
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

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() => bookingeController.isFetched.value
        ? Scaffold(
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
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 18.0),
                              //   child: DropdownButton<GetSubject>(
                              //       hint: Text(
                              //         getSubjectController.sub.toString(),
                              //         style: const TextStyle(
                              //             color: Colors.black,
                              //             fontSize: 16,
                              //             fontWeight: FontWeight.w400),
                              //       ),
                              //       isExpanded: true,
                              //       style: const TextStyle(
                              //           color: Colors.black,
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w700),
                              //       items: subject
                              //           .map((e) => DropdownMenuItem(
                              //                 child: Column(children: [
                              //                   Text(
                              //                     e.title,
                              //                     textAlign: TextAlign.left,
                              //                     style: const TextStyle(
                              //                         color: Colors.black,
                              //                         fontSize: 16,
                              //                         fontWeight:
                              //                             FontWeight.w400),
                              //                   ),
                              //                 ]),
                              //                 value: e,
                              //               ))
                              //           .toList(),
                              //       onChanged: (value) {
                              //         setState(() {
                              //           getSubjectController.sub = value!;
                              //           bookingeController.subjectid = value.id;
                              //           //     sid = ("");
                              //         });
                              //       },
                              //       value: getSubjectController.sub),
                              // ),
                              Container(
                                height: 100,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, index) {
                                      return Column(
                                        children: [
                                          getTimeBoxUIday(
                                            widget
                                                .hotelData!
                                                .preferred_tutoring_subjects[
                                                    index]
                                                .title,
                                            widget
                                                .hotelData!
                                                .preferred_tutoring_subjects[
                                                    index]
                                                .id,
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: widget.hotelData!
                                        .preferred_tutoring_subjects.length),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Selected Subject:' + " " + isselected,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  360
                                              ? 18
                                              : 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
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
                          FutureBuilder(
                              future: RemoteServices.getAvalbledate(
                                  widget.hotelData!.id),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                }
                                if (snapshot.hasData) {
                                  return SizedBox(
                                      height: 100,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (_, index) {
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Checkbox(
                                                    value: selectedIndexes
                                                        .contains(index),
                                                    onChanged: (value) {
                                                      if (selectedIndexes
                                                          .contains(index)) {
                                                        selectedIndexes
                                                            .remove(index);
                                                        avalbledate2.remove(
                                                            snapshot
                                                                .data[index]!
                                                                .day);
                                                        // unselect
                                                      } else {
                                                        selectedIndexes.add(
                                                            index); // select

                                                        avalbledate2.add(
                                                            snapshot
                                                                .data[index]!
                                                                .day);
                                                      }
                                                      setState(() {
                                                        print(avalbledate2);
                                                        if (avalbledate2.any(
                                                            (element) =>
                                                                monday.contains(
                                                                    element))) {
                                                          bookingeController
                                                              .ismonday = true;
                                                        } else {
                                                          bookingeController
                                                              .ismonday = false;
                                                          bookingeController
                                                              .Mon = "";
                                                        }

                                                        if (avalbledate2.any(
                                                            (element) => tuesday
                                                                .contains(
                                                                    element))) {
                                                          bookingeController
                                                              .istue = true;
                                                        } else {
                                                          bookingeController
                                                              .istue = false;
                                                          bookingeController
                                                              .Tue = "";
                                                        }

                                                        if (avalbledate2.any(
                                                            (element) => wednesday
                                                                .contains(
                                                                    element))) {
                                                          bookingeController
                                                              .iswen = true;
                                                        } else {
                                                          bookingeController
                                                              .iswen = false;
                                                          bookingeController
                                                              .Wed = "";
                                                        }

                                                        if (avalbledate2.any(
                                                            (element) => thursday
                                                                .contains(
                                                                    element))) {
                                                          bookingeController
                                                              .isthe = true;
                                                        } else {
                                                          bookingeController
                                                              .isthe = false;
                                                          bookingeController
                                                              .Thu = "";
                                                        }

                                                        if (avalbledate2.any(
                                                            (element) =>
                                                                friday.contains(
                                                                    element))) {
                                                          bookingeController
                                                              .isfri = true;
                                                        } else {
                                                          bookingeController
                                                              .isfri = false;
                                                          bookingeController
                                                              .Fri = "";
                                                        }

                                                        if (avalbledate2.any(
                                                            (element) => saturday
                                                                .contains(
                                                                    element))) {
                                                          bookingeController
                                                              .issat = true;
                                                        } else {
                                                          bookingeController
                                                              .issat = false;
                                                          bookingeController
                                                              .Sat = "";
                                                        }
                                                        if (avalbledate2.any(
                                                            (element) =>
                                                                sunday.contains(
                                                                    element))) {
                                                          bookingeController
                                                              .issun = true;
                                                        } else {
                                                          bookingeController
                                                              .issun = false;
                                                          bookingeController
                                                              .Sun = "";
                                                        }
                                                      });
                                                    },
                                                    checkColor: Colors.white,
                                                    activeColor: kPrimaryColor,
                                                  ),
                                                  Text(
                                                    snapshot.data[index]!.day,
                                                    style: TextStyle(
                                                        fontSize: 12.0),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          itemCount: snapshot.data.length));
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
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
                                      "4:30 pm",
                                      "5:00 pm",
                                      "5:30 pm",
                                      "6:00 pm",
                                      "6:30 pm",
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
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
                                        bookingeController.Mon = "monday";
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
                                      "4:30 pm",
                                      "5:00 pm",
                                      "5:30 pm",
                                      "6:00 pm",
                                      "6:30 pm",
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
                                        bookingeController.Tue = "tuesday";
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
                                      "4:30 pm",
                                      "5:00 pm",
                                      "5:30 pm",
                                      "6:00 pm",
                                      "6:30 pm",
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
                                        bookingeController.Wed = "wednesday";
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
                                      "4:30 pm",
                                      "5:00 pm",
                                      "5:30 pm",
                                      "6:00 pm",
                                      "6:30 pm",
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
                                        bookingeController.Thu = "thursday";
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
                                      "4:30 pm",
                                      "5:00 pm",
                                      "5:30 pm",
                                      "6:00 pm",
                                      "6:30 pm",
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
                                        bookingeController.Fri = "friday";
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
                                      "09:00 am",
                                      "10:00 am",
                                      "11:00 am",
                                      "12:00 pm",
                                      "1:00 pm",
                                      "2:00 pm",
                                      "3:00 pm",
                                      "4:00 pm",
                                      "5:00 pm",
                                      "6:00 pm",
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
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
                                        bookingeController.Sat = "saturday";
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
                                      "09:00 am",
                                      "10:00 am",
                                      "11:00 am",
                                      "12:00 pm",
                                      "1:00 pm",
                                      "2:00 pm",
                                      "3:00 pm",
                                      "4:00 pm",
                                      "5:00 pm",
                                      "6:00 pm",
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
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
                                        bookingeController.Sun = "sunday";
                                      });
                                    },
                                  )
                                ])
                              : Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shadowColor: kPrimaryColor,
                                  primary: Colors.teal,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14,
                                    letterSpacing: 0.27,
                                    color: Colors.teal,
                                  ),
                                ),
                                onPressed: () {
                                  _selectDate(context);
                                },
                                child: Text("Choose tutor Start  Date"),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: RaisedButton(
                              onPressed: () async {
                                var value;
                                value =
                                    values.where((item) => item == true).length;
                                if (avalbledate2.isNotEmpty) {
                                  Cricular();
                                  await Future.delayed(
                                      const Duration(seconds: 3));
                                  bookingeController.ismonday = false;
                                  bookingeController.istue = false;
                                  bookingeController.iswen = false;
                                  bookingeController.isthe = false;
                                  bookingeController.isfri = false;
                                  bookingeController.issat = false;
                                  bookingeController.issun = false;
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(),
                              FutureBuilder(
                                  future: RemoteServices.getAvalbledate(
                                      widget.hotelData!.id),
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
                                          physics:
                                              const BouncingScrollPhysics(),
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
            ))
        : const Center(child: CircularProgressIndicator()));
  }

  Widget getTimeBoxUIday(String txt2, id) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isselected = txt2;
          //  getSubjectController.sub = txt2! as GetSubject?;
          bookingeController.subjectid = id;
        });
      },
      child: Padding(
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
      ),
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
                  child: const Center(child: Text('No')),
                ),
                FlatButton(
                  onPressed: () async {
                    //
                    bookingeController.Booking(context, widget.hotelData!.id);

                    await Future.delayed(const Duration(seconds: 1));
                    //  Navigator.of(context).pop(true);
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

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(selectedDate.day),
        lastDate: DateTime(2025),
        helpText: "Select Tutor starting date",
        cancelText: "NOT NOW",
        confirmText: "BOOK NOW",
        errorFormatText: "Enter a Valid Date",
        fieldHintText: "DATE/MONTH/YEAR",
        fieldLabelText: "BOOKING DATE",
        initialDatePickerMode: DatePickerMode.day,
        errorInvalidText: "Date Out of Range");
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        bookingeController.startdate = selected.day.toString();
        print(selected.toString());
      });
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
