// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_typing_uninitialized_variables, unused_element, prefer_if_null_operators, deprecated_member_use, duplicate_ignore

import 'dart:convert';
import 'dart:io';

import 'package:addistutor_student/Screens/Login/login_screen.dart';
import 'package:addistutor_student/Screens/Profile/contactus.dart';
import 'package:addistutor_student/Screens/Profile/help_screen.dart';
import 'package:addistutor_student/Screens/Profile/setting.dart';
import 'package:addistutor_student/Screens/Notification/notification.dart';
import 'package:addistutor_student/Screens/Profile/termsodservice.dart';
import 'package:addistutor_student/Wallet/wallet.dart';
import 'package:addistutor_student/controller/bookingcontroller.dart';
import 'package:addistutor_student/controller/contactuscontroller.dart';
import 'package:addistutor_student/controller/editprofilecontroller.dart';
import 'package:addistutor_student/controller/endbookingcontroller.dart';
import 'package:addistutor_student/controller/feedbackcontroller.dart';
import 'package:addistutor_student/controller/geteducationlevelcontroller.dart';
import 'package:addistutor_student/controller/getlocationcontroller.dart';
import 'package:addistutor_student/controller/getmyaccount.dart';
import 'package:addistutor_student/controller/getnotificationcontoller.dart';
import 'package:addistutor_student/controller/getqrcontroller.dart';
import 'package:addistutor_student/controller/getreqestedbookingcpntroller.dart';
import 'package:addistutor_student/controller/getsubjectcontroller.dart';
import 'package:addistutor_student/controller/getutoravlblitycontroller.dart';
import 'package:addistutor_student/controller/searchcontroller.dart';
import 'package:addistutor_student/controller/signupcontroller.dart';
import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'editprofile.dart';
import 'feedback_screen.dart';
import 'help_screen.dart';
import 'dart:math';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfileS(),
    );
  }
}

bool _isLoggedIn = false;
GoogleSignIn _googleSignIn = GoogleSignIn();

class ProfileS extends StatefulWidget {
  const ProfileS({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileS> {
  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  final GetLocationController getLocationController =
      Get.put(GetLocationController());

  final EditprofileController editprofileController =
      Get.put(EditprofileController());

  final GetmyAccount getmyAccount = Get.put(GetmyAccount());
  @override
  void initState() {
    super.initState();

    _fetchUser();
    _getlocation();
    _getmyaccount();
  }

  List<GetLocationforedit> location = [];
  _getlocation() async {
    getLocationController.fetchLocation();
    // ignore: invalid_use_of_protected_member
    location = getLocationController.listlocationforedit.value;
    if (location.isNotEmpty) {
      setState(() {
        editprofileController.locaion = location[0];
      });
    }
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    // if failed,use refreshFailed()

    setState(() {
      _getlocation();
      _fetchUser();
      _getmyaccount();
    });
    _refreshController.refreshCompleted();
  }

  void _getmyaccount() async {
    // monitor network fetch
    // await Future.delayed(const Duration(milliseconds: 1000));
    getmyAccount.fetchqr();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  var ids;
  late int ran;
  void _fetchUser() async {
    ran = Random().nextInt(100);

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      if (body["student_id"] != null) {
        setState(() {
          ids = int.parse(body["student_id"]);
          editprofileController.fetchPf(int.parse(body["student_id"]));
        });
      } else {
        var noid = "noid";

        editprofileController.fetchPf(noid);
      }
    } else {}
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return editprofileController.obx(
        (editForm) => WillPopScope(
            onWillPop: _onBackPressed,
            child: Scaffold(
              key: editprofileController.keyforall,
              backgroundColor: Colors.grey.shade100,
              extendBodyBehindAppBar: true,
              extendBody: true,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    key:
                    editprofileController.keyforall.currentState!.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: kPrimaryLightColor,
                    size: 30,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              drawer: _buildDrawer(
                context,
                editprofileController.firstname.text.toString(),
                editprofileController.lastname.text.toString(),
                ids,
              ),
              body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,

                //cheak pull_to_refresh
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ProfileHeader(
                        avatar: NetworkImage(
                            "https://tutor.oddatech.com/api/student-profile-picture/$ids?$ran"),
                        coverImage: const NetworkImage(
                            "https://tutor.oddatech.com/lg3.png"),
                        title: editprofileController.firstname.text.toString() +
                            " " +
                            editprofileController.lastname.text.toString(),
                        subtitle: "Grade" " " +
                            editprofileController.Grade.toString(),
                        actions: <Widget>[
                          MaterialButton(
                            color: Colors.white,
                            shape: const CircleBorder(),
                            elevation: 0,
                            child: const Icon(
                              Icons.edit,
                              color: kPrimaryColor,
                            ),
                            onPressed: () {
                              Navigator.push<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      const EditPage(),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      UserInfo(
                        phone: editprofileController.phone.text.toString(),
                        email: editprofileController.email.text.toString(),
                        gender:
                            editprofileController.macthgender.value.toString(),
                        about: editprofileController.About.text.toString(),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        onLoading: Center(child: loadData()),
        onEmpty: const Text("Can't fetch data"),
        onError: (error) => Center(child: Text(error.toString())));
  }

  loadData() {
    // Here you can write your code for open new view
    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      EasyLoading.dismiss();
    });
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
              'Are You Sure you want to exit This app',
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

  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;
  _buildDrawer(BuildContext context, String fname, String lastname, ids) {
    final String image =
        "https://tutor.oddatech.com/api/student-profile-picture/$ids?$ran";

    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary,
              boxShadow: const [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [kPrimaryColor, kPrimaryColor])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(image),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    fname.toString() + " " + lastname.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 30.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => const EditPage(),
                        ),
                      );
                    },
                    child: _buildRow(
                      Icons.update,
                      "Update profile",
                    ),
                  ),
                  _buildDivider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              const FeedbackScreen(),
                        ),
                      );
                    },
                    child: _buildRow(
                      Icons.notifications,
                      "Give feedback",
                    ),
                  ),
                  _buildDivider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const SettingsFourPage(),
                          ),
                        );
                      },
                      child: _buildRow(Icons.settings, "Settings")),
                  _buildDivider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => const WalletPage(),
                        ),
                      );
                    },
                    child: _buildRow(Icons.money, "Wallet ", showBadge: true),
                  ),
                  _buildDivider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) =>
                              const Notificationclass(),
                        ),
                      );
                    },
                    child: _buildRow(Icons.notification_add, "Notifications",
                        showBadge: true),
                  ),
                  _buildDivider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const ContactDetailsView(),
                          ),
                        );
                      },
                      child: _buildRow(Icons.email, "Contact us")),
                  _buildDivider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const ProductDescriptionPage(),
                          ),
                        );
                      },
                      child: _buildRow(Icons.rule, "Terms of Service")),
                  _buildDivider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) =>
                                const HelpScreen(),
                          ),
                        );
                      },
                      child: _buildRow(
                          Icons.info_outline, "How the system works")),
                  _buildDivider(),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            elevation: 0,
                            backgroundColor: const Color(0xffffffff),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            title: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  SizedBox(height: 15),
                                  Text(
                                    'Message',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                  Text(
                                    'Are you sure you want to log out?',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                            actions: <Widget>[
                              // ignore: deprecated_member_use
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 30,
                                child: InkWell(
                                  highlightColor: Colors.grey[200],
                                  onTap: () {
                                    Navigator.of(context).pop(true);
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    });
                                    _logout(context);
                                  },
                                  child: Center(
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const Divider(
                                height: 1,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 30,
                                child: InkWell(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                  ),
                                  highlightColor: Colors.grey[200],
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: _buildRow(Icons.logout, "Log out")),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
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

  void _logout(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.remove('user');
    Get.delete<SignupController>();
    Get.delete<EditprofileController>();
    Get.delete<GetLocationController>();
    Get.delete<GetSubjectController>();
    Get.delete<SearchController>();
    Get.delete<BookingeController>();
    Get.delete<ContactUSContolller>();
    Get.delete<FeedBackScreencontroller>();
    Get.delete<GetEducationlevelController>();
    Get.delete<GetLocationController>();
    Get.delete<GetReqBooking>();
    Get.delete<GetTutorAvlblityController>();
    Get.delete<GetQrCode>();
    Get.delete<GetNotigicationController>();
    Get.delete<EndBookingContoller>();
    Get.delete<GetmyAccount>();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );

    _googleSignIn.signOut().then((value) {
      setState(() {
        _isLoggedIn = false;
      });
    }).catchError((e) {});
  }
}

class UserInfo extends StatelessWidget {
  final String? phone;
  final String? email;
  final String? gender;

  final String? about;
  const UserInfo({
    Key? key,
    required this.phone,
    required this.email,
    required this.gender,
    required this.about,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: const Text(
              "Student Information  \n ",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            leading: const Icon(
                              Icons.phone,
                              color: kPrimaryColor,
                            ),
                            title: const Text("Phone"),
                            subtitle: Text(phone.toString()),
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.email, color: kPrimaryColor),
                            title: const Text("Email"),
                            subtitle: Text(email.toString()),
                          ),
                          ListTile(
                            leading: const Icon(Icons.male_sharp,
                                color: kPrimaryColor),
                            title: const Text("Gender"),
                            subtitle: Text(gender.toString()),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.person,
                              color: kPrimaryColor,
                            ),
                            title: const Text("About Me"),
                            subtitle: Text(about.toString()),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  const ProfileHeader(
      {Key? key,
      required this.coverImage,
      required this.avatar,
      required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 170,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: coverImage as ImageProvider<Object>,
                fit: BoxFit.contain),
          ),
        ),
        Ink(
          height: 200,
          decoration: const BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 40,
                backgroundColor: kPrimaryColor,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle!,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color? backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key? key,
      required this.image,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image as ImageProvider<Object>?,
        ),
      ),
    );
  }
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 40, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
