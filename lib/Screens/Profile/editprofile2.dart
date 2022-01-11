// ignore_for_file: deprecated_member_use

/**
 * Author: Aparna Dulal
 * profile: https://github.com/ambikadulal
  */
import 'dart:io';

import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';
import 'package:addistutor_student/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditPage2 extends StatefulWidget {
  static List<Widget> containerList = [];
  const EditPage2({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

final ImagePicker _picker = ImagePicker();

late var sessions = "3 sessions";
late var days = "Mon";
late var wtime = "4:30pm - 5:30pm";
late var time = "9:00am - 10:00am";

late bool weakdays = false;
late bool weakdays2 = false;
late bool ispressd = false;

// ignore: unused_element
String? _selectedTime = "Time";

TimeOfDay currentDate = TimeOfDay.now();
var date;
TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial;

class _EditPageState extends State<EditPage2> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
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
          "Edit Profile",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: 'WorkSans',
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 35,
              ),
              const Text(
                'How many sessions do you want to buy? ',
                style: TextStyle(color: Colors.black45),
              ),
              const Text(
                'A session is 90 minutes long and you can buy starting from three sessions. ',
                style: TextStyle(color: Colors.black38),
              ),
              DropdownButton<String>(
                value: sessions,
                isExpanded: true,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                items: <String>[
                  '3 sessions',
                  '4 sessions',
                  '5 sessions',
                  '6 sessions',
                  '7 sessions',
                  '8 sessions',
                  '9 sessions',
                  '10 sessions',
                  '11 sessions',
                  '12 sessions',
                  '13 sessions',
                  '14 sessions',
                  '15 sessions',
                  '16 sessions',
                  '17 sessions',
                  '18 sessions',
                  '19 sessions',
                  '20 sessions',
                  '21 sessions',
                  '22 sessions',
                  '23 sessions',
                  '24 sessions',
                  '25 sessions',
                  '26 sessions',
                  '27 sessions',
                  '28 sessions',
                  '29 sessions',
                  '30 sessions',
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
                    sessions = value!;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Date And Time ',
                style: TextStyle(color: Colors.black38),
              ),
              const Text(
                'Preferred study date and  starting from what time?',
                style: TextStyle(color: Colors.black38),
              ),
              const SizedBox(
                height: 10,
              ),
              buildTextFieldstudent("data and time", "Evan kutto", false),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  height: 400,
                  width: double.infinity,
                  child: Column(children: EditPage2.containerList),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ignore: deprecated_member_use
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {},
                    child: const Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldstudent(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DropdownButton<String>(
              value: days,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
              items: <String>[
                'Mon',
                'Tue',
                'Wed',
                'Thu',
                'Fri',
                'Sat',
                'Sun',
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
                  days = value!;
                  if (days == "Sat") {
                    weakdays = true;
                  } else if (days == "Sun") {
                    weakdays = true;
                  } else {
                    weakdays = false;
                  }
                });
              },
            ),
            SizedBox(width: 50), // give it width

            weakdays
                ? DropdownButton<String>(
                    value: time,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    items: <String>[
                      '9:00am - 10:00am',
                      '11:00am - 12:00pm',
                      '1:00pm - 2:00pm',
                      '3:00pm - 4:00pm',
                      '5:00pm - 6:00pm',
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
                        time = value!;
                      });
                    },
                  )
                : DropdownButton<String>(
                    value: wtime,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    items: <String>[
                      '4:30pm - 5:30pm',
                      '5:30pm - 6:30pm',
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
                        wtime = value!;
                      });
                    },
                  ),

            ispressd
                ? Container()
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        EditPage2.containerList.add(
                          dynamicWidget(),
                        );
                        ispressd = true;
                      });
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                  )
          ],
        ),
      ]),
    );
  }
}

// ignore: camel_case_types
class dynamicWidget extends StatefulWidget {
  const dynamicWidget({Key? key}) : super(key: key);

  @override
  _EditPageState5 createState() => _EditPageState5();
}

late bool ispressd2 = false;

class _EditPageState5 extends State<dynamicWidget> {
  late var days2 = "Mon";
  late var wtime2 = "4:30pm - 5:30pm";
  late var time2 = "9:00am - 10:00am";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DropdownButton<String>(
              value: days2,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
              items: <String>[
                'Mon',
                'Tue',
                'Wed',
                'Thu',
                'Fri',
                'Sat',
                'Sun',
              ].map<DropdownMenuItem<String>>((String value2) {
                return DropdownMenuItem<String>(
                  value: value2,
                  child: Text(
                    value2,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                );
              }).toList(),
              onChanged: (value2) {
                setState(() {
                  days2 = value2!;
                  if (days2 == "Sat") {
                    weakdays2 = true;
                  } else if (days2 == "Sun") {
                    weakdays2 = true;
                  } else {
                    weakdays2 = false;
                  }
                });
              },
            ),
            const SizedBox(width: 50), // give it width

            weakdays2
                ? DropdownButton<String>(
                    value: time2,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    items: <String>[
                      '9:00am - 10:00am',
                      '11:00am - 12:00pm',
                      '1:00pm - 2:00pm',
                      '3:00pm - 4:00pm',
                      '5:00pm - 6:00pm',
                    ].map<DropdownMenuItem<String>>((String value2) {
                      return DropdownMenuItem<String>(
                        value: value2,
                        child: Text(
                          value2,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    }).toList(),
                    onChanged: (value2) {
                      setState(() {
                        time2 = value2!;
                      });
                    },
                  )
                : DropdownButton<String>(
                    value: wtime2,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    items: <String>[
                      '4:30pm - 5:30pm',
                      '5:30pm - 6:30pm',
                    ].map<DropdownMenuItem<String>>((String value2) {
                      return DropdownMenuItem<String>(
                        value: value2,
                        child: Text(
                          value2,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      );
                    }).toList(),
                    onChanged: (value2) {
                      setState(() {
                        wtime2 = value2!;
                      });
                    },
                  ),

            ispressd2
                ? Container()
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        EditPage2.containerList.add(
                          dynamicWidget3(),
                        );
                      });
                      ispressd2 = true;
                      refresh();
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                  )
          ],
        ),
      ]),
    );
  }

  void refresh() {
    Navigator.pop(context); // pop current page
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const EditPage2(),
      ),
    );
  }
}

class dynamicWidget3 extends StatefulWidget {
  const dynamicWidget3({Key? key}) : super(key: key);

  @override
  _EditPageState3 createState() => _EditPageState3();
}

class _EditPageState3 extends State<dynamicWidget3> {
  @override
  void initState() {
    super.initState();
    ispressd2 = true;
  }

  late var days3 = "Mon";
  late var wtime3 = "4:30pm - 5:30pm";
  late var time3 = "9:00am - 10:00am";
  late bool weakdays3 = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DropdownButton<String>(
            value: days3,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
            items: <String>[
              'Mon',
              'Tue',
              'Wed',
              'Thu',
              'Fri',
              'Sat',
              'Sun',
            ].map<DropdownMenuItem<String>>((String value2) {
              return DropdownMenuItem<String>(
                value: value2,
                child: Text(
                  value2,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              );
            }).toList(),
            onChanged: (value2) {
              setState(() {
                days3 = value2!;
                if (days3 == "Sat") {
                  weakdays3 = true;
                } else if (days3 == "Sun") {
                  weakdays3 = true;
                } else {
                  weakdays3 = false;
                }
              });
            },
          ),
          const SizedBox(width: 50), // give it width

          weakdays3
              ? DropdownButton<String>(
                  value: time3,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                  items: <String>[
                    '9:00am - 10:00am',
                    '11:00am - 12:00pm',
                    '1:00pm - 2:00pm',
                    '3:00pm - 4:00pm',
                    '5:00pm - 6:00pm',
                  ].map<DropdownMenuItem<String>>((String value2) {
                    return DropdownMenuItem<String>(
                      value: value2,
                      child: Text(
                        value2,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    );
                  }).toList(),
                  onChanged: (value2) {
                    setState(() {
                      time3 = value2!;
                    });
                  },
                )
              : DropdownButton<String>(
                  value: wtime3,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                  items: <String>[
                    '4:30pm - 5:30pm',
                    '5:30pm - 6:30pm',
                  ].map<DropdownMenuItem<String>>((String value2) {
                    return DropdownMenuItem<String>(
                      value: value2,
                      child: Text(
                        value2,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    );
                  }).toList(),
                  onChanged: (value2) {
                    setState(() {
                      wtime3 = value2!;
                    });
                  },
                ),
          Container()
        ],
      ),
    ]);
  }
}
