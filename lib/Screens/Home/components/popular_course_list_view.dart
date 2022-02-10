import 'package:addistutor_student/Screens/Home/components/course_info_screen.dart';
import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';
import 'package:addistutor_student/Screens/Home/components/homescreen.dart';
import 'package:addistutor_student/Screens/Home/models/category.dart';
import 'package:addistutor_student/controller/getpopulartutor.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularCourseListView extends StatefulWidget {
  const PopularCourseListView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  _PopularCourseListViewState createState() => _PopularCourseListViewState();
}

final GetPopularTutorController getPopularTutorController =
    Get.put(GetPopularTutorController());

class _PopularCourseListViewState extends State<PopularCourseListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    getPopularTutorController.fetchqr();
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => getPopularTutorController.isfetchedsubject.value
        ? Padding(
            padding: const EdgeInsets.only(top: 8),
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return GridView(
                    padding: const EdgeInsets.all(8),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: List<Widget>.generate(
                      getPopularTutorController.popular.length,
                      (int index) {
                        final int count =
                            getPopularTutorController.popular.length;
                        final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animationController!,
                            curve: Interval((1 / count) * index, 1.0,
                                curve: Curves.fastOutSlowIn),
                          ),
                        );
                        animationController?.forward();
                        final Search chat =
                            getPopularTutorController.popular[index];
                        return CategoryView(
                          category: getPopularTutorController.popular[index],
                          animation: animation,
                          animationController: animationController,
                          callback: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) {
                                  return CourseInfoScreen(hotelData: chat);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 32.0,
                      crossAxisSpacing: 32.0,
                      childAspectRatio: 0.8,
                    ),
                  );
                }
              },
            ),
          )
        : const Center(child: CircularProgressIndicator()));
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key? key,
      this.category,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final Search? category;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: callback,
              child: SizedBox(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: HexColor('#F8FAFB'),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              // border: new Border.all(
                              //     color: DesignCourseAppTheme.notWhite),
                            ),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16, left: 16, right: 16),
                                        child: Text(
                                          category!.first_name,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            fontFamily: 'WorkSans',
                                            letterSpacing: 0.27,
                                            color:
                                                DesignCourseAppTheme.darkerText,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8,
                                            left: 16,
                                            right: 16,
                                            bottom: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              '${category!.gender}',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 12,
                                                fontFamily: 'WorkSans',
                                                letterSpacing: 0.27,
                                                color:
                                                    DesignCourseAppTheme.grey,
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  '${category!.location.name}',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 12,
                                                    fontFamily: 'WorkSans',
                                                    letterSpacing: 0.27,
                                                    color: DesignCourseAppTheme
                                                        .grey,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.location_pin,
                                                  color: DesignCourseAppTheme
                                                      .nearlyBlue,
                                                  size: 10,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  '${category!.rating}',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 18,
                                                    letterSpacing: 0.27,
                                                    color: DesignCourseAppTheme
                                                        .grey,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: DesignCourseAppTheme
                                                      .nearlyBlue,
                                                  size: 20,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 48,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                      ],
                    ),
                    Container(
                      width: 100,
                      height: 90,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 3,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 3,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 20))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://tutor.oddatech.com/api/teacher-profile-picture/${category!.id}"))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
