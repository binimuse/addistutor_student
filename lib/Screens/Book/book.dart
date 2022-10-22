// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe, invalid_use_of_protected_member, prefer_typing_uninitialized_variables, unnecessary_null_comparison, unnecessary_brace_in_string_interps, non_constant_identifier_names, duplicate_ignore

import 'dart:convert';

import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';
import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/controller/bookingcontroller.dart';
import 'package:addistutor_student/controller/editprofilecontroller.dart';
import 'package:addistutor_student/controller/getsubjectcontroller.dart';
import 'package:addistutor_student/controller/getutoravlblitycontroller.dart';
import 'package:addistutor_student/controller/walletcontroller.dart';

import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
late bool canbook = false;

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
    _fetchUser();
    _getsubject();
    _initForLang();
    // getTutorAvlblityController.fetchDay("2");
    bookingeController.isFetched(true);
    super.initState();
  }

  late var motime;
  late var tuetime2;
  late var wentime3;
  late var thetime4;
  late var fritime5;
  late var sattime;
  late var suntime2;

  void _initForLang() {
    setState(() {
      motime = "10:30 (Afternoon)";
      tuetime2 = "10:30 (Afternoon)";
      wentime3 = "10:30 (Afternoon)";
      thetime4 = "10:30 (Afternoon)";
      fritime5 = "10:30 (Afternoon)";
      suntime2 = "03:00 (Morning)";
      sattime = "03:00 (Morning)";
    });
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

  final WalletContoller walletContoller = Get.find();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {
      _fetchUser();
      _getsubject();
      _initForLang();
      // getTutorAvlblityController.fetchDay("2");
      bookingeController.isFetched(true);
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

  final EditprofileController editprofileController = Get.find();
  String date = "";
  var totalprice;

  DateTime selectedDate = DateTime.now();
  DateTime now = DateTime.now();
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

  var ids;
  void _fetchUser() async {
    await Future.delayed(const Duration(seconds: 1));
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      if (body["student_id"] != null) {
        setState(() {
          ids = int.parse(body["student_id"]);
          walletContoller.getbalance(ids);
          //  walletContoller.gettransaction(ids);
          editprofileController.fetchPf(int.parse(body["student_id"]));
        });
      } else {}
    } else {}
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
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'How many sessions do you want to buy? ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            'A session is 60 minutes long and you can buy starting from one session. ',
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
                              '1',
                              '2',
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
                              var new_price;
                              var new_value;
                              setState(() {
                                bookingeController.sessionsd.value = value!;

                                var selected_session = int.parse(value);

                                var old_price =
                                    int.parse(widget.hotelData!.price);

                                if (widget.hotelData!.employment_category!
                                        .additional_price !=
                                    null) {
                                  new_price = int.parse(widget.hotelData!
                                      .employment_category!.additional_price);
                                } else {
                                  new_price = 0;
                                }

                                new_value = selected_session * new_price;
                                totalprice = old_price + new_value;

                                int wallet = totalprice as int;

                                int wallet2 = int.parse(walletContoller.wallet);

                                if (wallet > wallet2) {
                                  canbook = false;
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      elevation: 0,
                                      backgroundColor: const Color(0xffffffff),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      title: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            SizedBox(height: 15),
                                            Text(
                                              'Insufficient balance',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                            SizedBox(height: 15),
                                            Divider(
                                              height: 1,
                                              color: kPrimaryColor,
                                            ),
                                          ]),
                                      content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            SizedBox(height: 15),
                                            Text(
                                              'Your balance is insufficient. Please make a deposit.',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                          ]),
                                      actions: <Widget>[
                                        // ignore: deprecated_member_use
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                          child: InkWell(
                                            highlightColor: Colors.grey[200],
                                            onTap: () {
                                              Navigator.of(context).pop(true);
                                              // _logout(context);
                                            },
                                            child: Center(
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  canbook = true;
                                }
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          totalprice != null
                              ? Text(
                                  "Total price: ${totalprice} \n",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              : Container(),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            'Date and time ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            'Preferred study day and time ',
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
                                              margin: const EdgeInsets.all(5),
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
                                                    style: const TextStyle(
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
                                  const Text("Monday time:  "),
                                  DropdownButton<String>(
                                    value: motime,
                                    hint: Text("Choose a date"),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                    items: <String>[
                                      "10:30 (Afternoon)",
                                      "11:00 (Afternoon)",
                                      "11:30 (Afternoon)",
                                      "12:00 (Afternoon)",
                                      "12:30 (Afternoon)",
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
                                        //        "4:30 pm",
                                        // "5:00 pm",
                                        // "5:30 pm",
                                        // "6:00 pm",
                                        // "6:30 pm",

                                        motime = value;
                                        if (value!
                                            .contains("10:30 (Afternoon)")) {
                                          bookingeController.motime = "4:30 pm";
                                          bookingeController.Mon = "monday";
                                        } else if (value
                                            .contains("11:00 (Afternoon)")) {
                                          bookingeController.motime = "5:00 pm";
                                          bookingeController.Mon = "monday";
                                        } else if (value
                                            .contains("11:30 (Afternoon)")) {
                                          bookingeController.motime = "5:30 pm";
                                          bookingeController.Mon = "monday";
                                        } else if (value
                                            .contains("12:00 (Afternoon)")) {
                                          bookingeController.motime = "6:00 pm";
                                          bookingeController.Mon = "monday";
                                        } else if (value
                                            .contains("12:30 (Afternoon)")) {
                                          bookingeController.motime = "6:30 pm";
                                          bookingeController.Mon = "monday";
                                        }
                                      });
                                    },
                                  ),
                                ])
                              : Container(),
                          bookingeController.istue
                              ? Row(children: [
                                  const Text("Tuesday time:  "),
                                  DropdownButton<String>(
                                    hint: Text("Choose a date"),
                                    value: tuetime2,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                    items: <String>[
                                      "10:30 (Afternoon)",
                                      "11:00 (Afternoon)",
                                      "11:30 (Afternoon)",
                                      "12:00 (Afternoon)",
                                      "12:30 (Afternoon)",
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
                                        //        "4:30 pm",
                                        // "5:00 pm",
                                        // "5:30 pm",
                                        // "6:00 pm",
                                        // "6:30 pm",
                                        tuetime2 = value;
                                        if (value!
                                            .contains("10:30 (Afternoon)")) {
                                          bookingeController.tuetime2 =
                                              "4:30 pm";
                                          bookingeController.Tue = "tuesday";
                                        } else if (value
                                            .contains("11:00 (Afternoon)")) {
                                          bookingeController.tuetime2 =
                                              "5:00 pm";
                                          bookingeController.Tue = "tuesday";
                                        } else if (value
                                            .contains("11:30 (Afternoon)")) {
                                          bookingeController.tuetime2 =
                                              "5:30 pm";
                                          bookingeController.Tue = "tuesday";
                                        } else if (value
                                            .contains("12:00 (Afternoon)")) {
                                          bookingeController.tuetime2 =
                                              "6:00 pm";
                                          bookingeController.Tue = "tuesday";
                                        } else if (value
                                            .contains("12:30 (Afternoon)")) {
                                          bookingeController.tuetime2 =
                                              "6:30 pm";
                                          bookingeController.Tue = "tuesday";
                                        }
                                      });
                                    },
                                  ),
                                ])
                              : Container(),
                          bookingeController.iswen
                              ? Row(children: [
                                  const Text("Wednesday time:  "),
                                  DropdownButton<String>(
                                    hint: Text("Choose a date"),
                                    value: wentime3,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                    items: <String>[
                                      "10:30 (Afternoon)",
                                      "11:00 (Afternoon)",
                                      "11:30 (Afternoon)",
                                      "12:00 (Afternoon)",
                                      "12:30 (Afternoon)",
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
                                        //        "4:30 pm",
                                        // "5:00 pm",
                                        // "5:30 pm",
                                        // "6:00 pm",
                                        // "6:30 pm",
                                        wentime3 = value;
                                        if (value!
                                            .contains("10:30 (Afternoon)")) {
                                          bookingeController.wentime3 =
                                              "4:30 pm";
                                          bookingeController.Wed = "wednesday";
                                        } else if (value
                                            .contains("11:00 (Afternoon)")) {
                                          bookingeController.wentime3 =
                                              "5:00 pm";
                                          bookingeController.Wed = "wednesday";
                                        } else if (value
                                            .contains("11:30 (Afternoon)")) {
                                          bookingeController.wentime3 =
                                              "5:30 pm";
                                          bookingeController.Wed = "wednesday";
                                        } else if (value
                                            .contains("12:00 (Afternoon)")) {
                                          bookingeController.wentime3 =
                                              "6:00 pm";
                                          bookingeController.Wed = "wednesday";
                                        } else if (value
                                            .contains("12:30 (Afternoon)")) {
                                          bookingeController.wentime3 =
                                              "6:30 pm";
                                          bookingeController.Wed = "wednesday";
                                        }
                                      });
                                    },
                                  ),
                                ])
                              : Container(),
                          bookingeController.isthe
                              ? Row(children: [
                                  const Text("Thursday time:  "),
                                  DropdownButton<String>(
                                    hint: Text("Choose a date"),
                                    value: thetime4,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                    items: <String>[
                                      "10:30 (Afternoon)",
                                      "11:00 (Afternoon)",
                                      "11:30 (Afternoon)",
                                      "12:00 (Afternoon)",
                                      "12:30 (Afternoon)",
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
                                        //        "4:30 pm",
                                        // "5:00 pm",
                                        // "5:30 pm",
                                        // "6:00 pm",
                                        // "6:30 pm",
                                        thetime4 = value;
                                        if (value!
                                            .contains("10:30 (Afternoon)")) {
                                          bookingeController.thetime4 =
                                              "4:30 pm";
                                          bookingeController.Thu = "thursday";
                                        } else if (value
                                            .contains("11:00 (Afternoon)")) {
                                          bookingeController.thetime4 =
                                              "5:00 pm";
                                          bookingeController.Thu = "thursday";
                                        } else if (value
                                            .contains("11:30 (Aternoon)")) {
                                          bookingeController.thetime4 =
                                              "5:30 pm";
                                          bookingeController.Thu = "thursday";
                                        } else if (value
                                            .contains("12:00 (Afternoon)")) {
                                          bookingeController.thetime4 =
                                              "6:00 pm";
                                          bookingeController.Thu = "thursday";
                                        } else if (value
                                            .contains("12:30 (Afternoon)")) {
                                          bookingeController.thetime4 =
                                              "6:30 pm";
                                          bookingeController.Thu = "thursday";
                                        }
                                      });
                                    },
                                  ),
                                ])
                              : Container(),
                          bookingeController.isfri
                              ? Row(children: [
                                  const Text("Friday time:  "),
                                  DropdownButton<String>(
                                    hint: Text("Choose a date"),
                                    value: fritime5,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                    items: <String>[
                                      "10:30 (Afternoon)",
                                      "11:00 (Afternoon)",
                                      "11:30 (Afternoon)",
                                      "12:00 (Afternoon)",
                                      "12:30 (Afternoon)",
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
                                        //        "4:30 pm",
                                        // "5:00 pm",
                                        // "5:30 pm",
                                        // "6:00 pm",
                                        // "6:30 pm",
                                        fritime5 = value;
                                        if (value!
                                            .contains("10:30 (Afternoon)")) {
                                          bookingeController.fritime5 =
                                              "4:30 pm";
                                          bookingeController.Fri = "friday";
                                        } else if (value
                                            .contains("11:00 (Afternoon)")) {
                                          bookingeController.fritime5 =
                                              "5:00 pm";
                                          bookingeController.Fri = "friday";
                                        } else if (value
                                            .contains("11:30 (Afternoon)")) {
                                          bookingeController.fritime5 =
                                              "5:30 pm";
                                          bookingeController.Fri = "friday";
                                        } else if (value
                                            .contains("12:00 (Afternoon)")) {
                                          bookingeController.fritime5 =
                                              "6:00 pm";
                                          bookingeController.Fri = "friday";
                                        } else if (value
                                            .contains("12:30 (Afternoon)")) {
                                          bookingeController.fritime5 =
                                              "6:30 pm";
                                          bookingeController.Fri = "friday";
                                        }
                                      });
                                    },
                                  ),
                                ])
                              : Container(),
                          bookingeController.issat
                              ? Row(children: [
                                  const Text("Saturday time:  "),
                                  DropdownButton<String>(
                                    value: sattime,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                    items: <String>[
                                      "03:00 (Morning)",
                                      "04:00 (Morning)",
                                      "05:00 (Morning)",
                                      "06:00 (Morning)",
                                      "07:00 (Afternoon)",
                                      "08:00 (Afternoon)",
                                      "09:00 (Afternoon)",
                                      "10:00 (Afternoon)",
                                      "11:00 (Afternoon)",
                                      "12:00 (Afternoon)",
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
                                      //       "09:00 am",
                                      // "10:00 am",
                                      // "11:00 am",
                                      // "12:00 pm",
                                      // "1:00 pm",
                                      // "2:00 pm",
                                      // "3:00 pm",
                                      // "4:00 pm",
                                      // "5:00 pm",
                                      // "6:00 pm",
                                      setState(() {
                                        sattime = value!;

                                        if (value.contains("03:00 (Morning)")) {
                                          bookingeController.sattime =
                                              "09:00 am";
                                          bookingeController.Sat = "saturday";
                                        } else if (value
                                            .contains("04:00 (Morning)")) {
                                          bookingeController.sattime =
                                              "10:00 am";
                                          bookingeController.Sat = "saturday";
                                        } else if (value
                                            .contains("05:00 (Morning)")) {
                                          bookingeController.sattime =
                                              "11:00 am";
                                          bookingeController.Sat = "saturday";
                                        } else if (value
                                            .contains("06:00 (Morning)")) {
                                          bookingeController.sattime =
                                              "12:00 am";
                                          bookingeController.Sat = "saturday";
                                        } else if (value
                                            .contains("07:00 (Afternoon)")) {
                                          bookingeController.sattime =
                                              "1:00 am";
                                          bookingeController.Sat = "saturday";
                                        } else if (value
                                            .contains("08:00 (Afternoon)")) {
                                          bookingeController.sattime =
                                              "2:00 pm";
                                          bookingeController.Sat = "saturday";
                                        } else if (value
                                            .contains("09:00 (Afternoon)")) {
                                          bookingeController.sattime =
                                              "3:00 pm";
                                          bookingeController.Sat = "saturday";
                                        } else if (value
                                            .contains("10:00 (Afternoon)")) {
                                          bookingeController.sattime =
                                              "4:00 pm";
                                          bookingeController.Sat = "saturday";
                                        } else if (value
                                            .contains("11:00 (Afternoon)")) {
                                          bookingeController.sattime =
                                              "5:00 pm";
                                          bookingeController.Sat = "saturday";
                                        } else if (value
                                            .contains("12:00( Afternoon)")) {
                                          bookingeController.sattime =
                                              "6:00 pm";
                                          bookingeController.Sat = "saturday";
                                        }
                                      });
                                    },
                                  )
                                ])
                              : Container(),
                          bookingeController.issun
                              ? Row(children: [
                                  const Text("Sunday time:  "),
                                  DropdownButton<String>(
                                    value: suntime2,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                    items: <String>[
                                      "03:00 (Morning)",
                                      "04:00 (Morning)",
                                      "05:00 (Morning)",
                                      "06:00 (Morning)",
                                      "07:00 (Afternoon)",
                                      "08:00 (Afternoon)",
                                      "09:00 (Afternoon)",
                                      "10:00 (Afternoon)",
                                      "11:00 (Afternoon)",
                                      "12:00 (Afternoon)",
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
                                      //       "09:00 am",
                                      // "10:00 am",
                                      // "11:00 am",
                                      // "12:00 pm",
                                      // "1:00 pm",
                                      // "2:00 pm",
                                      // "3:00 pm",
                                      // "4:00 pm",
                                      // "5:00 pm",
                                      // "6:00 pm",
                                      setState(() {
                                        suntime2 = value!;

                                        if (value.contains("03:00 (Morning)")) {
                                          bookingeController.suntime2 =
                                              "09:00 am";
                                          bookingeController.Sun = "sunday";
                                        } else if (value
                                            .contains("04:00 (Morning)")) {
                                          bookingeController.suntime2 =
                                              "10:00 am";
                                          bookingeController.Sun = "sunday";
                                        } else if (value
                                            .contains("05:00 (Morning)")) {
                                          bookingeController.suntime2 =
                                              "11:00 am";
                                          bookingeController.Sun = "sunday";
                                        } else if (value
                                            .contains("06:00 (Morning)")) {
                                          bookingeController.sattime =
                                              "12:00 am";
                                          bookingeController.Sun = "sunday";
                                        } else if (value
                                            .contains("07:00 (Afternoon)")) {
                                          bookingeController.suntime2 =
                                              "1:00 am";
                                          bookingeController.Sun = "sunday";
                                        } else if (value
                                            .contains("08:00 (Afternoon)")) {
                                          bookingeController.suntime2 =
                                              "2:00 pm";
                                          bookingeController.Sun = "sunday";
                                        } else if (value
                                            .contains("09:00 (Afternoon)")) {
                                          bookingeController.suntime2 =
                                              "3:00 pm";
                                          bookingeController.Sun = "sunday";
                                        } else if (value
                                            .contains("10:00 (Afternoon)")) {
                                          bookingeController.suntime2 =
                                              "4:00 pm";
                                          bookingeController.Sun = "Sunday";
                                        } else if (value
                                            .contains("11:00 (Afternoon)")) {
                                          bookingeController.suntime2 =
                                              "5:00 pm";
                                          bookingeController.Sun = "sunday";
                                        } else if (value
                                            .contains("12:00 (Afternoon)")) {
                                          bookingeController.suntime2 =
                                              "6:00 pm";
                                          bookingeController.Sun = "sunday";
                                        }
                                      });
                                    },
                                  )
                                ])
                              : Container(),
                          const Text(
                            'Start date:',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            'Preferred start date',
                            style: TextStyle(color: Colors.black38),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: kPrimaryColor,
                                    primary: kPrimaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _selectDate(context);
                                    });
                                  },
                                  child: Text(
                                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          canbook
                              ? Center(
                                  child: RaisedButton(
                                    onPressed: () async {
                                      if (avalbledate2.isNotEmpty) {
                                        Cricular();
                                        //clear();
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text(
                                              'Error',
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
                                                        MainAxisAlignment
                                                            .center,
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
                                                            child: Text('OK')),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Text(
                                      "Book",
                                      style: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 2.2,
                                          color: Colors.white),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: RaisedButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const AlertDialog(
                                        title: Text(
                                          'Error',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red,
                                            fontFamily: 'WorkSans',
                                          ),
                                        ),
                                        content: Text(
                                          'Balance is insufficient',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontFamily: 'WorkSans',
                                          ),
                                        ),
                                      ),
                                    );
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50),
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
                                )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Center(),
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
          content: const Text(
            'Are you sure you want to make the booking?',
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
                  child: const Center(child: Text('Cancel')),
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: kPrimaryColor,
                  onPressed: () async {
                    //
                    bookingeController.Booking(context, widget.hotelData!.id);

                    await Future.delayed(const Duration(seconds: 1));
                    //  Navigator.of(context).pop(true);
                  },
                  child: Container(
                      width: 30,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
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
    // ignore: avoid_print
    print(
        'Received integer: $day. Corresponds to day: ${intDayToEnglish(day)}');
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

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: now,
        lastDate: DateTime(2025),
        helpText: "Select Tutor starting date",
        cancelText: "NOT NOW",
        confirmText: "BOOK NOW",
        errorFormatText: "Enter a Valid Date",
        fieldHintText: "DATE/MONTH/YEAR",
        fieldLabelText: "BOOKING DATE",
        initialDatePickerMode: DatePickerMode.day,
        errorInvalidText: "Date Out of Range");
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        bookingeController.startdate = selected.toString();
      });
    }
  }

  void clear() async {
    EasyLoading.show();

    Future.delayed(const Duration(milliseconds: 2000), () {
// Here you can write your code
      bookingeController.ismonday = false;
      bookingeController.istue = false;
      bookingeController.iswen = false;
      bookingeController.isthe = false;
      bookingeController.isfri = false;
      bookingeController.issat = false;
      bookingeController.issun = false;
      EasyLoading.dismiss();
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
    if (widget.day!.day != null) {
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
