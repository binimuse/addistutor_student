// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison, invalid_use_of_protected_member, duplicate_ignore, unused_local_variable, unnecessary_string_interpolations

import 'package:addistutor_student/controller/geteducationlevelcontroller.dart';
import 'package:addistutor_student/controller/getlocationcontroller.dart';
import 'package:addistutor_student/controller/getsubjectcontroller.dart';
import 'package:addistutor_student/controller/searchcontroller.dart';
import 'package:addistutor_student/remote_services/service.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../constants.dart';
import 'hotel_app_theme.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  GetEducationlevelController getEducationlevelController = Get.find();
  GetSubjectController getSubjectController = Get.find();
  GetLocationController getLocationController = Get.find();

  SearchController searchController = Get.put(SearchController());

  double distValue = 50.0;
  var lid, gender;
  List<GetEducationlevel> education = [];
  List<GetSubject> subject = [];
  final List<String> _tobeSent = [];
  final List<String> sid = [];
  late var macthgender = "".obs;
  bool showsubject = false;

  @override
  void initState() {
    super.initState();
    _getall();
  }

  _getall() async {
    _geteducation();
    _getsubject();
    _getlocation();
  }

  List<GetSubject> _selectedItems2 = [];

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
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    //if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
  }

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

  _getsubject() {
    subject = getSubjectController.listsubject.value;
    if (subject != null && subject.isNotEmpty) {
      setState(() {
        //  getSubjectController.subject = subject[0];
      });
    }
  }

  List<GetLocation> location = [];
  _getlocation() async {
    getLocationController.fetchLocation();
    // ignore: invalid_use_of_protected_member
    location = getLocationController.listlocation.value;
    if (location != null && location.isNotEmpty) {
      setState(() {
        getLocationController.location = location[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => getEducationlevelController.isfetchededucation.value
        ? Container(
            color: HotelAppTheme.buildLightTheme().backgroundColor,
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,

              //cheak pull_to_refresh
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: Form(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    children: <Widget>[
                      getAppBarUI(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              gradebarfilter(),
                              const Divider(
                                height: 1,
                              ),
                              showsubject ? subjectViewUI() : Container(),
                              const Divider(
                                height: 1,
                              ),
                              LocationFilter(),
                              const Divider(
                                height: 1,
                              ),
                              genderViewUI(),
                              const Divider(
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16, top: 8),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: HotelAppTheme.buildLightTheme().primaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                blurRadius: 8,
                                offset: const Offset(4, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24.0)),
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                //   searchwidget(sid, lid, gender);
                                // searchController.fetch("1", "1", "female");

                                // Navigator.pop(context, () {
                                //   setState(() {});
                                // });

                                SizedBox(
                                  height: 200.0,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: List.generate(
                                        1,
                                        (index) => ListTile(
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Row(
                                                  children: [
                                                    FutureBuilder(
                                                        future: RemoteServices
                                                            .search("", "", ""),
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                          if (snapshot
                                                              .hasError) {
                                                            return Center(
                                                              child: Text(snapshot
                                                                  .error
                                                                  .toString()),
                                                            );
                                                          }
                                                          if (snapshot
                                                              .hasData) {
                                                            return Expanded(
                                                              child: ListView
                                                                  .builder(
                                                                shrinkWrap:
                                                                    true,
                                                                physics:
                                                                    const BouncingScrollPhysics(),
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return SearchListtag(
                                                                      tag: snapshot
                                                                              .data[
                                                                          index]);
                                                                },
                                                                itemCount:
                                                                    snapshot
                                                                        .data
                                                                        .length,
                                                              ),
                                                            );
                                                          } else {
                                                            return const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            );
                                                          }
                                                        }),
                                                  ],
                                                ),
                                              ),
                                            )),
                                  ),
                                );
                              },
                              child: const Center(
                                child: Text(
                                  'Search',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator()));
  }

  Widget subjectViewUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MultiSelectBottomSheetField<GetSubject>(
          initialChildSize: 0.7,
          maxChildSize: 0.95,
          listType: MultiSelectListType.CHIP,
          checkColor: Colors.pink,
          selectedColor: kPrimaryColor,
          selectedItemsTextStyle: const TextStyle(
            fontSize: 25,
            color: Colors.white,
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
            "Subjects avalable",
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
              sid.add("${item.id.toString()}");
            }
            setState(() {});

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
                sid.clear();
              });

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

  // ignore: non_constant_identifier_names
  Widget LocationFilter() {
    var grade;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Location :',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: DropdownButton<GetLocation>(
            hint: Text(
              getLocationController.listlocation.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            isExpanded: true,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
            items: location
                .map((e) => DropdownMenuItem(
                      child: Text(
                        e.name,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      value: e,
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                getLocationController.location = value!;
                lid = value.id;
              });

              // pop current page

              showsubject = true;
            },
            value: getLocationController.location,
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget genderViewUI() {
    var grade;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Tutor Gender:',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: DropdownButton<String>(
            value: macthgender.value,
            isExpanded: true,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
            items: <String>[
              '',
              'Male',
              'Female',
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
                macthgender.value = value!;
                gender = value;
              });
            },
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  getPList() {}

  Widget gradebarfilter() {
    var grade;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Education Level:',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
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
                      child: Text(
                        e.title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      value: e,
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                getEducationlevelController.education = value!;
              });

              _onRefresh();

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

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Filters',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }

  void searchwidget(List<String> sid, lid, gender) {
    RemoteServices.search(lid, sid, gender);
  }
}

class SearchListtag extends StatelessWidget {
  final Search? tag;
  const SearchListtag({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).cardColor,
        child: InkWell(
          child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   PageRouteBuilder(
              //     pageBuilder: (context, animation1, animation2) =>
              //         Hashtagdetail(
              //       tag: tag,
              //     ),
              //     transitionDuration: Duration.zero,
              //   ),
              // );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/hash.png'),
                        )),
                  ),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: tag!.first_name,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                          ])))),
                ],
              ),
            ),
          ),
          onTap: () {},
        ));
  }
}
