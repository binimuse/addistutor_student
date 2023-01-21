// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, duplicate_ignore

import 'dart:convert';

import 'package:addistutor_student/Screens/Appointment/components/appointmentscreen.dart';
import 'package:addistutor_student/Screens/Home/components/course_info_screen.dart';
import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';

import 'package:addistutor_student/constants.dart' show kPrimaryLightColor;
import 'package:addistutor_student/controller/geteducationlevelcontroller.dart';
import 'package:addistutor_student/controller/searchcontroller.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({
    Key? key,
    this.callBack,
  }) : super(key: key);

  final Function()? callBack;

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

var found;
SearchController searchController = Get.put(SearchController());

class _CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    //

    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _fetchUser();
    searchController.isfetched(true);
    super.initState();
  }

  //var ids;
  late int ran;
  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      var body = json.decode(token);

      if (body["student_id"] != null) {
        setState(() {
          // ids = int.parse(body["student_id"]);
          editprofileController.fetchPf(body["student_id"]);
        });
      } else {
        var noid = "noid";

        editprofileController.fetchPf(noid);
      }
    } else {}
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => searchController.isfetched.value
        ? Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: SizedBox(
                height: 134,
                width: double.infinity,
                child: FutureBuilder(
                    future: RemoteServices.search(
                        "", "", searchController.homepagegender, ""),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, right: 16, left: 16),
                          itemCount: snapshot.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            final int count = snapshot.data.length > 10
                                ? 10
                                : snapshot.data.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: animationController!,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn)));
                            animationController?.forward();
                            return CategoryView(
                              index: index,
                              category: snapshot.data[index],
                              animation: animation,
                              animationController: animationController,
                              callback: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) {
                                      return CourseInfoScreen(
                                        hotelData: snapshot.data[index],
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'No Recommended Tutor found',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontFamily: 'WorkSans',
                            ),
                          ),
                        );
                      }
                    })),
          )
        : const Center(
            child: Text(
            'No Recommended Tutor found',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'WorkSans',
            ),
          )));
  }
}

GetEducationlevelController getEducationlevelController =
    Get.put(GetEducationlevelController());

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key? key,
      required this.index,
      this.category,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final int index;
  final VoidCallback? callback;
  final Search? category;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return Obx(() => getEducationlevelController.isfetchededucation.value
        ? AnimatedBuilder(
            animation: animationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: animation!,
                child: Transform(
                  transform: Matrix4.translationValues(
                      100 * (1.0 - animation!.value), 0.0, 0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: callback,
                    child: SizedBox(
                      width: 230,
                      child: Stack(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16.0)),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      // ignore: unnecessary_null_comparison
                                      category!.first_name != null
                                          ? Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 16),
                                                    child: Text(
                                                      category!.first_name,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16,
                                                        fontFamily: 'WorkSans',
                                                        letterSpacing: 0.27,
                                                        color:
                                                            DesignCourseAppTheme
                                                                .darkerText,
                                                      ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    child: SizedBox(),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0,
                                                            bottom: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(children: [
                                                          Text(
                                                            ' ${category!.gender}',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'WorkSans',
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.8)),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          category!.rating !=
                                                                  null
                                                              ? Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      ' ${category!.rating}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              'WorkSans',
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.8)),
                                                                    ),
                                                                    const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color:
                                                                          kPrimaryLightColor,
                                                                      size: 20,
                                                                    ),
                                                                  ],
                                                                )
                                                              : Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              'WorkSans',
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.8)),
                                                                    ),
                                                                  ],
                                                                ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Row(children: [
                                                            Text(
                                                              ' ${category!.location.name}',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'WorkSans',
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.8)),
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .location_pin,
                                                              color:
                                                                  kPrimaryLightColor,
                                                              size: 10,
                                                            ),
                                                          ]),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 16,
                                                            right: 26),
                                                    child: Row(
                                                      children: <Widget>[
                                                        const SizedBox(
                                                            width: 10),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 16),
                                                    child: Text(
                                                      "First Name",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        letterSpacing: 0.27,
                                                        color:
                                                            DesignCourseAppTheme
                                                                .darkerText,
                                                      ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    child: SizedBox(),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 16,
                                                            bottom: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        const Text(
                                                          'Gender',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w200,
                                                            fontSize: 12,
                                                            letterSpacing: 0.27,
                                                            color:
                                                                DesignCourseAppTheme
                                                                    .grey,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            const Text(
                                                              '4',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                fontSize: 18,
                                                                letterSpacing:
                                                                    0.27,
                                                                color:
                                                                    DesignCourseAppTheme
                                                                        .grey,
                                                              ),
                                                            ),
                                                            const Icon(
                                                              Icons.star,
                                                              color:
                                                                  kPrimaryLightColor,
                                                              size: 20,
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 16,
                                                            right: 16),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color:
                                                                DesignCourseAppTheme
                                                                    .nearlyBlue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8.0)),
                                                          ),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    4.0),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://nextgeneducation.et/api/teacher-profile-picture/${category!.id}",
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : const Center(child: CircularProgressIndicator()));
  }
}
