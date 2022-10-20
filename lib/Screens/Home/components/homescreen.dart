// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison, duplicate_ignore, deprecated_member_use, empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:addistutor_student/Screens/Appointment/components/appointmentscreen.dart';
import 'package:addistutor_student/Screens/Home/components/category_list_view.dart';

import 'package:addistutor_student/Screens/Home/components/popular_course_list_view.dart';
import 'package:addistutor_student/Screens/search/components/searchscreen.dart';
import 'package:addistutor_student/Wallet/wallet.dart';
import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/controller/geteducationlevelcontroller.dart';
import 'package:addistutor_student/controller/getlocationcontroller.dart';
import 'package:addistutor_student/controller/getsubjectcontroller.dart';
import 'package:addistutor_student/controller/searchcontroller.dart';
import 'package:addistutor_student/controller/walletcontroller.dart';
import 'package:addistutor_student/remote_services/user.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'design_course_app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

late var gender = "";

class _HomePageState extends State<Home> with SingleTickerProviderStateMixin {
  GetEducationlevelController getEducationlevelController =
      Get.put(GetEducationlevelController());
  GetLocationController getLocationController =
      Get.put(GetLocationController());
  WalletContoller walletContoller = Get.put(WalletContoller());
  SearchController searchController = Get.put(SearchController());
  GetSubjectController getSubjectController = Get.put(GetSubjectController());
  @override
  void initState() {
    super.initState();
    _getall();
  }

  _getall() async {
    _geteducation();
    _getsubject();
    _getlocation();
    _fetchUser();
  }

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      // var id = editprofileController.fetchPf(body["student_id"]);
      // print(body["student_id"]);
      setState(() {
        walletContoller.getbalance(body["student_id"]);
        _cheakwallet();
      });
    }
  }

  void _cheakwallet() async {
    await Future.delayed(const Duration(milliseconds: 5000));

    try {
      int wallet2 = int.parse(walletContoller.wallet.toString());

      if (wallet2 < 100) {
        ScaffoldMessenger.of(editprofileController.keyforall.currentContext!)
            .showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 10.0),
          content: const Text('Your wallet has insufficient balance.'),
          duration: const Duration(days: 1),
          backgroundColor: kPrimaryColor,
          action: SnackBarAction(
              label: 'Press here to top up',
              textColor: kPrimaryLightColor,
              onPressed: () {
                Get.to(const WalletPage());
              }),
        ));
      } else {
        ScaffoldMessenger.of(editprofileController.keyforall.currentContext!)
            .hideCurrentSnackBar();
      }
    } catch (e) {}
  }

  List<GetSubject> subject = [];
  _getsubject() {
    subject = getSubjectController.listsubject.value;
    if (subject != null && subject.isNotEmpty) {
      setState(() {
        //  getSubjectController.subject = subject[0];
      });
    }
  }

  _geteducation() async {
    getEducationlevelController.fetchLocation();
    getSubjectController.fetchLocation("1");
    getLocationController.fetchLocation();
  }

  List<GetLocation> location = [];
  _getlocation() async {
    getLocationController.fetchLocationfor();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    //if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
  }

  CategoryType categoryType = CategoryType.ui;
  @override
  Widget build(BuildContext context) {
    return Obx(() => getEducationlevelController.isfetchededucation.value
        ? Container(
            color: DesignCourseAppTheme.nearlyWhite,
            child: SmartRefresher(
              enablePullUp: true,

              //cheak pull_to_refresh
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: WillPopScope(
                onWillPop: _onBackPressed,
                child: Scaffold(
                  key: editprofileController.keyforall,
                  backgroundColor: Colors.transparent,
                  body: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      getAppBarUI(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 190,
                            child: Column(
                              children: <Widget>[
                                // getSearchBarUI(),
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
                  ),
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator()));
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
              'Are you sure you want to exit this app?',
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
        const Padding(
          padding: EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Recommended Tutors',
            textAlign: TextAlign.left,
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
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(CategoryType.ui, categoryType == CategoryType.ui),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(
                  CategoryType.coding, categoryType == CategoryType.coding),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(
                  CategoryType.basic, categoryType == CategoryType.basic),
            ],
          ),
        ),
        CategoryListView(
          callBack: () {
            moveTo();
          },
        ),
      ],
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Popular Tutors',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: PopularCourseListView(
              callBack: () {
                moveTo();
              },
            ),
          )
        ],
      ),
    );
  }

  void moveTo() {
    // Navigator.push<dynamic>(
    //   context,
    //   MaterialPageRoute<dynamic>(
    //     builder: (BuildContext context) => CourseInfoScreen(hotelData: null),
    //   ),
    // );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';

    if (CategoryType.ui == categoryTypeData) {
      txt = 'All';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Female';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'Male';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color:
                isSelected ? kPrimaryColor : DesignCourseAppTheme.nearlyWhite,
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

              if (txt == "Female") {
                setState(() {
                  searchController.homepagegender = "female";
                  // print(gender);
                });
              } else if (txt == "Male") {
                setState(() {
                  searchController.homepagegender = "male";
                  //   print(gender);
                });
              } else if (txt == "All") {
                setState(() {
                  searchController.homepagegender = "";
                  //   print(gender);
                });
              }
              //  refresh();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 10, right: 10),
              child: Center(
                child: Row(children: [
                  txt == "Female"
                      ? const Icon(Icons.female, color: kPrimaryLightColor)
                      : txt == "Male"
                          ? const Icon(Icons.male, color: kPrimaryLightColor)
                          : const Icon(Icons.all_inbox,
                              color: kPrimaryLightColor),
                  Text(
                    txt,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      letterSpacing: 0.27,
                      color: isSelected
                          ? DesignCourseAppTheme.nearlyWhite
                          : DesignCourseAppTheme.nearlyBlue,
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: GestureDetector(
                          onTap: () {},
                          child: TextFormField(
                            style: const TextStyle(
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: DesignCourseAppTheme.nearlyBlue,
                            ),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Search ',
                              border: InputBorder.none,
                              helperStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: HexColor('#B9BABC'),
                              ),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                letterSpacing: 0.2,
                                color: HexColor('#B9BABC'),
                              ),
                            ),
                            onEditingComplete: () {},
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const SearchScreen()),
                              // );
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) {
                                    return const SerachPage();
                                  },
                                ),
                              );

                              // Navigator.of(context, rootNavigator: true).push(
                              //   new CupertinoPageRoute<bool>(
                              //     fullscreenDialog: true,
                              //     builder: (BuildContext context) =>
                              //         new SearchScreen(),
                              //   ),
                              // );
                              //  Navigator.pushNamed(context, '/search');
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: HexColor('#B9BABC')),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'WELCOME TO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                Text(
                  'NEXTGEN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 120,
            height: 120,
            child: Image.asset(
              'assets/images/lg3.png',
            ),
          )
        ],
      ),
    );
  }

  refresh() {
    // Navigator.pop(context); // pop current page

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return const HomeScreen();
        },
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
