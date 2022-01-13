import 'package:addistutor_student/Screens/Login/login_screen.dart';
import 'package:addistutor_student/Screens/Profile/help_screen.dart';
import 'package:addistutor_student/Screens/Profile/setting.dart';
import 'package:addistutor_student/Screens/Notification/notification.dart';
import 'package:addistutor_student/controller/signupcontroller.dart';
import 'package:addistutor_student/constants.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'editprofile.dart';
import 'feedback_screen.dart';
import 'help_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const String path = "lib/src/pages/profile/profile8.dart";
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              _key.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: _buildDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileHeader(
                avatar: const NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media"),
                coverImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media"),
                title: "Ramesh Mana",
                subtitle: "Secondary student",
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.white,
                    shape: CircleBorder(),
                    elevation: 0,
                    child: const Icon(
                      Icons.edit,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        // ignore: prefer_const_constructors
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              EditPage(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                  )
                ],
              ),
              const SizedBox(height: 10.0),
              UserInfo(),
            ],
          ),
        ));
  }

  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;
  _buildDrawer(BuildContext context) {
    final String image =
        "https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media";
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: active,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [kPrimaryColor, kPrimaryColor])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(image),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    "erika costell",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 30.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        // ignore: prefer_const_constructors
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              EditPage(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: _buildRow(
                      Icons.update,
                      "update profile",
                    ),
                  ),
                  _buildDivider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        // ignore: prefer_const_constructors
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const FeedbackScreen(),
                          transitionDuration: Duration.zero,
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
                        Navigator.push(
                          // ignore: prefer_const_constructors
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                SettingsFourPage(),
                            transitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: _buildRow(Icons.settings, "Settings")),
                  _buildDivider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        // ignore: prefer_const_constructors
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const Notificationclass(),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: _buildRow(Icons.notification_add, "Notification",
                        showBadge: true),
                  ),
                  _buildDivider(),
                  _buildRow(Icons.email, "Contact us"),
                  _buildDivider(),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          // ignore: prefer_const_constructors
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                HelpScreen(),
                            transitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: _buildRow(Icons.info_outline, "Help")),
                  _buildDivider(),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            elevation: 0,
                            backgroundColor: Color(0xffffffff),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            title: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 15),
                                  const Text(
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
                                children: [
                                  SizedBox(height: 15),
                                  const Text(
                                    'Are You Sure you want to Log Out',
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
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: InkWell(
                                  highlightColor: Colors.grey[200],
                                  onTap: () {
                                    Navigator.of(context).pop(true);
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

                              Divider(
                                height: 1,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: InkWell(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                  ),
                                  highlightColor: Colors.grey[200],
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Center(
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
                      child: _buildRow(Icons.logout, "Logout")),
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
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
        if (showBadge)
          Material(
            color: kPrimaryColor,
            elevation: 5.0,
            shadowColor: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                "10+",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
      ]),
    );
  }

  void _logout(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    Get.delete<SignupController>();

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => LoginScreen(),
        transitionDuration: Duration.zero,
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
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
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          const ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: kPrimaryColor,
                            ),
                            title: Text("Phone"),
                            subtitle: Text("99--99876-56"),
                          ),
                          const ListTile(
                            leading: Icon(Icons.email, color: kPrimaryColor),
                            title: Text("Email"),
                            subtitle: Text("sudeptech@gmail.com"),
                          ),
                          const ListTile(
                            leading:
                                Icon(Icons.male_sharp, color: kPrimaryColor),
                            title: Text("Gender"),
                            subtitle: Text("Male"),
                          ),
                          const ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(
                              Icons.my_location,
                              color: kPrimaryColor,
                            ),
                            title: Text("Location"),
                            subtitle: Text("Bole"),
                          ),
                          const ListTile(
                            leading: Icon(Icons.grade, color: kPrimaryColor),
                            title: Text("Educational Background"),
                            subtitle: Text("Secoundary Student"),
                          ),
                          const ListTile(
                            leading: Icon(
                              Icons.person,
                              color: kPrimaryColor,
                            ),
                            title: Text("About Me"),
                            subtitle: Text(
                                "This is a about me link and you can khow about me in this section."),
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
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: coverImage as ImageProvider<Object>, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
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
