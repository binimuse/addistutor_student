// ignore_for_file: prefer_final_fields, unused_field, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors, duplicate_ignore, import_of_legacy_library_into_null_safe, unnecessary_null_comparison, prefer_adjacent_string_concatenation

import 'dart:convert';
import 'dart:io';

import 'package:addistutor_student/Screens/Home/components/course_info_screen_rating.dart';
import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';
import 'package:addistutor_student/Screens/Home/components/ongoingtutors.dart';
import 'package:addistutor_student/Wallet/wallet.dart';

import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/controller/editprofilecontroller.dart';
import 'package:addistutor_student/controller/getreqestedbookingcpntroller.dart';
import 'package:addistutor_student/remote_services/user.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final EditprofileController editprofileController =
    Get.put(EditprofileController());

final GetReqBooking getReqBooking = Get.put(GetReqBooking());

class _HomePageState extends State<Appointment>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _fetchUser();
    super.initState();
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      // var id = editprofileController.fetchPf(body["student_id"]);
      // print(body["student_id"]);
      walletContoller.getbalance(body["student_id"]);

      getReqBooking.fetchReqBooking(body["student_id"]);
    }
  }

  int _tabIndex = 0;

  CategoryType categoryType = CategoryType.ui;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {
      // _getlocation();
      _fetchUser();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: DesignCourseAppTheme.nearlyWhite,
        child: Obx(() => getReqBooking.isfetchedsubject.value
            ? SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,

                //cheak pull_to_refresh
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: WillPopScope(
                  onWillPop: _onBackPressed,
                  child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).padding.top,
                          ),
                          getAppBarUI(),
                          _buildDivider(),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  children: <Widget>[
                                    getCategoryUI(),
                                    Flexible(
                                      child: getPopularCourseUI(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ))
            : Center(
                child: Padding(
                padding: const EdgeInsets.only(top: 406),
                child: Column(children: [
                  CircularProgressIndicator(),
                  Center(child: Text("No Booked Tutors"))
                ]),
              ))));
  }

  loadData() {
    // Here you can write your code for open new view
    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      EasyLoading.dismiss();
    });
  }

  final Color divider = Colors.grey.shade600;
  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text(
              'Exit',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.green,
                fontFamily: 'WorkSans',
              ),
            ),
            content: const Text(
              'Are You Sure you want to Exit This App',
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
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () {
                      //Navigator.of(context).pop(true);
                      Navigator.pop(context);
                    },
                    child: const Center(child: Text('No')),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () async {
                      //

                      exit(0);
                      //  Navigator.of(context).pop(true);
                    },
                    child: const Center(child: Text('Yes')),
                  ),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // ignore: prefer_const_constructors
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: const Text(
            'OnGoing Tutors',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        OnGoingTutors(
          callBack: () {
            moveTo();
          },
        ),
      ],
    );
  }

  Widget getPopularCourseUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Reqested Tutor List',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 0.27,
                color: DesignCourseAppTheme.darkerText,
              ),
            ),
            SizedBox(
              child: ListView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: getReqBooking.listsubject.length,
                itemBuilder: (BuildContext context, int index) {
                  final RequestedBooking chat =
                      getReqBooking.listsubject[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              CourseInfoScreenRating(hotelData: chat),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 5.0, bottom: 5.0, right: 20.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Stack(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 4,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: const Offset(0, 10))
                                        ],
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(
                                                "https://tutor.oddatech.com/api/teacher-profile-picture/${chat.teacher.id}"))),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    chat.teacher.first_name +
                                        " " +
                                        chat.teacher.last_name,
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    chat.teacher.gender,
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(0.5),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Row(children: [
                                    Icon(
                                      Icons.star,
                                      color: kPrimaryColor,
                                      size: 10,
                                    ),
                                    Text(
                                      chat.teacher.rating,
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ],
                          ),
                          chat.is_active == null
                              ? Column(
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
                                    Text(
                                      "Pending",
                                      style: TextStyle(
                                        color: Colors.grey.withOpacity(0.5),
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              : chat.is_active != "0"
                                  ? Column(
                                      children: <Widget>[
                                        Container(
                                          width: 20.0,
                                          height: 20.0,
                                          decoration: const BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle),
                                          alignment: Alignment.center,
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          "Accepted",
                                          style: TextStyle(
                                            color: Colors.grey.withOpacity(0.5),
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: <Widget>[
                                        Container(
                                          width: 20.0,
                                          height: 20.0,
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle),
                                          alignment: Alignment.center,
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          "Declined",
                                          style: TextStyle(
                                            color: Colors.grey.withOpacity(0.5),
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void moveTo() {
    // Navigator.push<dynamic>(
    //   context,
    //   MaterialPageRoute<dynamic>(
    //     builder: (BuildContext context) => CourseInfoScreen(),
    //   ),
    // );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Ui/Ux';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Coding';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'Basic UI';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? DesignCourseAppTheme.nearlyBlue
                : DesignCourseAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: DesignCourseAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? DesignCourseAppTheme.nearlyWhite
                        : DesignCourseAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Student',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                Text(
                  'Dashbord',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                // ignore: prefer_const_constructors
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const WalletPage(),
                  transitionDuration: Duration.zero,
                ),
              );
            },
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    walletContoller.wallet.toString() + ' birr',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                      letterSpacing: 0.2,
                      color: kPrimaryColor,
                    ),
                  ),
                  Text(
                    'Available Balance',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: 0.2,
                      color: DesignCourseAppTheme.grey,
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
