// ignore_for_file: import_of_legacy_library_into_null_safe, invalid_use_of_protected_member, unnecessary_null_comparison, duplicate_ignore, deprecated_member_use, non_constant_identifier_names

import 'dart:io';

import 'package:addistutor_student/Screens/Home/components/course_info_screen.dart';
import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';
import 'package:addistutor_student/Screens/search/components/hotel_list_view.dart';
import 'package:addistutor_student/Screens/search/components/model/hotel_list_data.dart';
import 'package:addistutor_student/components/form_drop_down_widget.dart';
import 'package:addistutor_student/components/form_drop_down_widget_cat.dart';
import 'package:addistutor_student/controller/getcategorycontroller.dart';
import 'package:addistutor_student/controller/geteducationlevelcontroller.dart';
import 'package:addistutor_student/controller/getlocationcontroller.dart';
import 'package:addistutor_student/controller/getsubjectcontroller.dart';
import 'package:addistutor_student/controller/searchcontroller.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants.dart';
import 'hotel_app_theme.dart';

class SerachPage extends StatefulWidget {
  const SerachPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SerachPage> with TickerProviderStateMixin {
  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  AnimationController? animationController;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();
  SearchController searchController = Get.put(SearchController());

  GetEducationlevelController getEducationlevelController = Get.find();
  GetSubjectController getSubjectController = Get.find();
  GetLocationController getLocationController = Get.find();

  final GetCatgroryContoller getCatgrory = Get.put(GetCatgroryContoller());
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  List<GetSubject> subject = [];

  final List<String> _tobeSent = [];
  late String sid = "";
  late var macthgender = "Any".obs;
  late var profecncy = "Teacher".obs;
  var lid = "", gender = "", catagId = "";
  RxInt found = 0.obs;
  bool showsubject = false;
  bool searched = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    _getall();
  }

  _getall() async {
    _geteducation();
    _getsubject();
    _getlocation();
    _getCategory();
  }

  _getCategory() async {
    getCatgrory.fetchLocation();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    setState(() {
      _getsubject();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    _refreshController.loadComplete();
  }

  _getlocation() async {
    getLocationController.fetchLocationfor();
  }

  List<GetEducationlevel> education = [];

  _geteducation() async {
    getEducationlevelController.fetchLocation();
    // ignore: invalid_use_of_protected_member
    education = getEducationlevelController.listeducation.value;

    if (education != null && education.isNotEmpty) {
      setState(() {
        getEducationlevelController.education = education[0];
      });
    }
  }

  List<GetSubject> _selectedItems2 = [];
  _getsubject() {
    subject = getSubjectController.listsubject.value;
    if (subject != null && subject.isNotEmpty) {
      setState(() {
        //  getSubjectController.subject = subject[0];
      });
    }
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
    return Obx(() => getEducationlevelController.isfetchededucation.value
        ? Theme(
            data: HotelAppTheme.buildLightTheme(),
            child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,

                //cheak pull_to_refresh
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: WillPopScope(
                  onWillPop: _onBackPressed,
                  child: Scaffold(
                      body: NestedScrollView(
                    controller: _scrollController,
                    physics: const ScrollPhysics(parent: PageScrollPhysics()),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Column(
                              children: <Widget>[
                                getAppBarUI(),
                                gradebarfilter(),
                                showsubject ? subjectViewUI() : Container(),
                                LocationFilter(),
                                genderViewUI(),
                                ProfecencyViewUI(),
                                getSearchBarUI(),
                              ],
                            );
                          }, childCount: 1),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          floating: true,
                          delegate: ContestTabHeader(
                            getFilterBarUI(),
                          ),
                        ),
                      ];
                    },
                    body: searched
                        ? Container(
                            color:
                                HotelAppTheme.buildLightTheme().backgroundColor,
                            child: FutureBuilder(
                                future: RemoteServices.search(lid.toString(),
                                    sid, gender.toString(), catagId.toString()),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      itemCount: snapshot.data.length,
                                      padding: const EdgeInsets.only(top: 8),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return HotelListView(
                                          callback: () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                    animation1, animation2) {
                                                  return CourseInfoScreen(
                                                    hotelData:
                                                        snapshot.data[index],
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          hotelData: snapshot.data[index],
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }))
                        : Center(
                            child: Container(),
                          ),
                  )),
                )))
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

  Widget genderViewUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Tutor Gender:',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor,
              fontFamily: 'WorkSans',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: DropdownButton<String>(
            value: macthgender.value,
            isExpanded: true,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
            items: <String>[
              'Any',
              'Male',
              'Female',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                      color: DesignCourseAppTheme.nearlyBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                macthgender.value = value!;
              });

              gender = macthgender.value;

              if (macthgender.value == "Any") {
                gender = "";
              }
            },
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget ProfecencyViewUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Tutor Type:',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor,
              fontFamily: 'WorkSans',
            ),
          ),
        ),
        FormDropDownWidgetCat(
          hintText: "Select Category".trArgs(),
          options: getCatgrory.listCategory.value,
          value: getCatgrory.listlistCategoryvalue.value,
          onChanged: (GetCategory subcitymodel) {
            getCatgrory.setSubectStatus(subcitymodel);
            catagId = subcitymodel.id;

            print("hvhv" + subcitymodel.id);

            setState(() {
              if (subcitymodel.id.toString() == "1") {
                catagId = "";
              }
            });
          },
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget LocationFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Location :',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor,
              fontFamily: 'WorkSans',
            ),
          ),
        ),
        FormDropDownWidget(
          hintText: "Select location".trArgs(),
          options: getLocationController.listlocation.value,
          value: getLocationController.listLOcationvalue.value,
          onChanged: (GetLocationforedit subcitymodel) {
            getLocationController.setLocationStatus(subcitymodel);
            lid = subcitymodel.id.toString();

            print(lid);
          },
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget subjectViewUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MultiSelectBottomSheetField<GetSubject>(
          initialChildSize: 0.6,
          maxChildSize: 0.95,
          listType: MultiSelectListType.LIST,
          checkColor: Colors.pink,
          selectedColor: kPrimaryColor,
          selectedItemsTextStyle: const TextStyle(
            fontSize: 20,
            color: kPrimaryColor,
          ),
          unselectedColor: kPrimaryColor.withOpacity(.08),
          buttonIcon: const Icon(
            Icons.add,
            color: Colors.pinkAccent,
          ),
          searchHintStyle: const TextStyle(
            fontSize: 12,
          ),
          searchable: true,
          buttonText: const Text(
            "Select Subject:", //"????",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
          title: const Text(
            "Available subjects",
            style: TextStyle(
              fontSize: 20,
              color: kPrimaryColor,
            ),
          ),
          items: getSubjectController.hobItem,
          onConfirm: (values) {
            setState(() {
              _selectedItems2 = values.cast<GetSubject>();
            });

            for (var item in _selectedItems2) {
              // ignore: unnecessary_string_interpolations
              _tobeSent.add("${item.title.toString()}");
              // sid.add("${item.id.toString()}");
              setState(() {
                sid = item.id.toString();
              });
            }

            /*senduserdata(
                      'partnerreligion', '${_selectedItems2.toString()}');*/
          },
          chipDisplay: MultiSelectChipDisplay(
            textStyle: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            onTap: (value) {
              setState(() {
                _selectedItems2.remove(value);
                _tobeSent.remove(value.toString());
                //   sid.clear();
                //     sid = ("");
              });
              //  sid.clear();
              // ignore: avoid_print

              for (var item in _selectedItems2) {
                _tobeSent.add(item.title.toString());
              }
            },
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  loadData() {
    // Here you can write your code for open new view
    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 1000), () {
// Here you can write your code

      EasyLoading.dismiss();
    });
  }

  Widget gradebarfilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Education Level:',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor,
              fontFamily: 'WorkSans',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: DropdownButton<GetEducationlevel>(
            hint: Text(
              getEducationlevelController.education.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            isExpanded: true,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
            items: education
                .map((e) => DropdownMenuItem(
                      child: Column(children: [
                        Text(
                          e.title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: DesignCourseAppTheme.nearlyBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                      ]),
                      value: e,
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                getEducationlevelController.education = value!;

                print(lid);
                //     sid = ("");
              });

              _onRefresh();
              loadData();

              getSubjectController.fetchLocation(value!.id.toString());

              // pop current page

              showsubject = true;
            },
            value: getEducationlevelController.education,
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget getSearchBarUI() {
    return Material(
      color: kPrimaryColor,
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(32.0),
        ),
        onTap: () {
          setState(() {
            searched = true;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(FontAwesomeIcons.search,
              size: 20, color: HotelAppTheme.buildLightTheme().backgroundColor),
        ),
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: HotelAppTheme.buildLightTheme().backgroundColor,
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Search results",
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              height: AppBar().preferredSize.height,
            ),
            const Center(
              child: Text(
                'Search for tutors',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
