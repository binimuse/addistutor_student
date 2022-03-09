// ignore_for_file: constant_identifier_names

import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';
import 'package:addistutor_student/controller/getnotificationcontoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'activity_item_widget.dart';

class Notificationclass extends StatefulWidget {
  static const ROUTE_NAME = 'ActivityPage';

  const Notificationclass({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<Notificationclass> {
  GetNotigicationController getNotigicationController =
      Get.put(GetNotigicationController());
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      getNotigicationController.fetchNotfication();
    });

    super.initState();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      getNotigicationController.fetchNotfication();
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

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Obx(
      () => getNotigicationController.isfetchedlocation.value
          ? Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: Material(
                  color: Colors.white,
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
                  "Notification",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'WorkSans',
                  ),
                ),
              ),
              body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,

                //cheak pull_to_refresh
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: getNotigicationController.isfetchedlocation.isTrue
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ActivityItemWidget(
                            data: getNotigicationController.listdate[index],
                          );
                        },
                        itemCount: getNotigicationController.listdate.length,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            )
          : const Center(
              child: Text(
                'No notifications found',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'WorkSans',
                  decoration: TextDecoration.none,
                ),
              ),
            ),
    );
  }
}
