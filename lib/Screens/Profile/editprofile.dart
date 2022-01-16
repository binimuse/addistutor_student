// ignore_for_file: deprecated_member_use

/**
 * Author: Aparna Dulal
 * profile: https://github.com/ambikadulal
  */

import 'dart:convert';
import 'dart:io';

import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';

import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/controller/editprofilecontroller.dart';
import 'package:addistutor_student/controller/getlocationcontroller.dart';
import 'package:addistutor_student/remote_services/user.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final ImagePicker _picker = ImagePicker();
  ImagePicker picker = ImagePicker();

  late var areyou = "Student";
  late bool areyoubool = false;
  late bool supportbool = false;
  DateTime currentDate = DateTime.now();
  bool showPassword = false;

  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  final EditprofileController editprofileController =
      Get.put(EditprofileController());

  EditprofileController pfcontroller = Get.find();
  GetLocationController getLocationController =
      Get.put(GetLocationController());

  List<GetLocation> files = [];
  @override
  void initState() {
    super.initState();
    _getlocation();

    editprofileController.date = DateFormat.yMd().format(DateTime.now());

    _fetchUser();
  }

  _getlocation() async {
    getLocationController.fetchLocation();
    // ignore: invalid_use_of_protected_member
    files = getLocationController.listlocation.value;
    if (files != null && files.isNotEmpty) {
      setState(() {
        editprofileController.locaion = files[0];
      });
    }
  }

  var body;
  var id;
  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    if (token != null) {
      body = json.decode(token);

      if (body["student_id"] != null) {
        pfcontroller.fetchPf(int.parse(body["student_id"]));
        id = int.parse(body["student_id"]);
      }
    }
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print(getLocationController.listlocation.length);
    return Obx(() => editprofileController.isFetched.value
        ? Scaffold(
            key: editprofileController.scaffoldKey,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 1,
              leading: Material(
                color: Colors.transparent,
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
                "Edit Profile",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: 'WorkSans',
                ),
              ),
            ),
            body: Form(
              key: editprofileController.EditProf,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: kPrimaryColor,
                                child: _imageFileList != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Image.file(
                                            File(_imageFileList![0].path),
                                            width: 95,
                                            height: 95,
                                            fit: BoxFit.cover),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        width: 100,
                                        height: 100,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: kPrimaryColor,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      _showPicker(context);
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      const Text(
                        'Are you a parent or student?',
                        style: TextStyle(color: Colors.black38),
                      ),
                      DropdownButton<String>(
                        value: areyou,
                        isExpanded: true,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        items: <String>[
                          'Student',
                          'Parent',
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
                            areyou = value!;
                            if (areyou == "Parent") {
                              areyoubool = true;
                              editprofileController.is_parent.value = true;
                            } else {
                              areyoubool = false;
                              editprofileController.is_parent.value = false;
                            }
                          });
                          //  areyoubool = false;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      areyoubool
                          ? Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 35.0),
                                child: TextFormField(
                                  controller:
                                      editprofileController.parent_first_name,
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Parent First Name",
                                      focusColor: kPrimaryColor,
                                      fillColor: kPrimaryColor,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: "Parent First Name",
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                  validator: (value) {
                                    return editprofileController
                                        .validateName(value!);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 35.0),
                                child: TextFormField(
                                  controller:
                                      editprofileController.parent_last_name,
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Parent Last Name",
                                      focusColor: kPrimaryColor,
                                      fillColor: kPrimaryColor,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: "name",
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                  validator: (value) {
                                    return editprofileController
                                        .validateName(value!);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 35.0),
                                child: TextFormField(
                                  controller: editprofileController.firstname,
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Student First Name",
                                      focusColor: kPrimaryColor,
                                      fillColor: kPrimaryColor,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: "Student First Name",
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                  validator: (value) {
                                    return editprofileController
                                        .validateName(value!);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 35.0),
                                child: TextFormField(
                                  controller: editprofileController.lastname,
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Student Last Name",
                                      focusColor: kPrimaryColor,
                                      fillColor: kPrimaryColor,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: "Student Last Name",
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                  validator: (value) {
                                    return editprofileController
                                        .validateName(value!);
                                  },
                                ),
                              ),
                            ])
                          : Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 35.0),
                                child: TextFormField(
                                  controller: editprofileController.firstname,
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Student First Name",
                                      focusColor: kPrimaryColor,
                                      fillColor: kPrimaryColor,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: "Student First Name",
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                  validator: (value) {
                                    return editprofileController
                                        .validateName(value!);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 35.0),
                                child: TextFormField(
                                  controller: editprofileController.lastname,
                                  decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 3),
                                      labelText: "Student Last Name",
                                      focusColor: kPrimaryColor,
                                      fillColor: kPrimaryColor,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintText: "Student Last Name",
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                                  validator: (value) {
                                    return editprofileController
                                        .validateName(value!);
                                  },
                                ),
                              ),
                            ]),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: TextFormField(
                          controller: editprofileController.phone,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Phone Number",
                              focusColor: kPrimaryColor,
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Phone Number",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          validator: (value) {
                            return editprofileController.validateName(value!);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 35.0),
                        child: TextFormField(
                          controller: editprofileController.email,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "Email",
                              focusColor: kPrimaryColor,
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: editprofileController.email.text,
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          validator: (value) {
                            return editprofileController.validateEmail(value!);
                          },
                        ),
                      ),
                      const Text(
                        'Gender',
                        style: TextStyle(color: Colors.black38),
                      ),
                      DropdownButton<String>(
                        value: editprofileController.macthgender.value,
                        isExpanded: true,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        items: <String>[
                          'male',
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
                            editprofileController.macthgender.value = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Select BirthDate',
                        style: TextStyle(color: Colors.black38),
                      ),
                      OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Text(editprofileController.date.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Location',
                        style: TextStyle(color: Colors.black38),
                      ),
                      DropdownButton<GetLocation>(
                        hint: Text(
                          editprofileController.locaion.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                        isExpanded: true,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        items: files
                            .map((e) => DropdownMenuItem(
                                  child: Text(
                                    e.name,
                                  ),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            editprofileController.locaion = value!;
                          });
                        },
                        value: editprofileController.locaion,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      // const Text(
                      //   'Educational BackGround',
                      //   style: TextStyle(color: Colors.black38),
                      // ),
                      // DropdownButton<String>(
                      //   value: editprofileController.education.value,
                      //   isExpanded: true,
                      //   style: const TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w700),
                      //   items: <String>[
                      //     'Primary',
                      //     'Secondary',
                      //     'Preparatory',
                      //   ].map<DropdownMenuItem<String>>((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(
                      //         value,
                      //         style: const TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w700),
                      //       ),
                      //     );
                      //   }).toList(),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       editprofileController.education.value = value!;
                      //     });
                      //   },
                      // ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Study Purpose',
                        style: TextStyle(color: Colors.black38),
                      ),
                      DropdownButton<String>(
                        value: editprofileController.studyperpose.value,
                        isExpanded: true,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        items: <String>[
                          'Regular support',
                          'Exam preparation',
                          'Specific support',
                          'Other',
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
                            editprofileController.studyperpose.value = value!;
                            if (editprofileController.studyperpose.value ==
                                "Specific support") {
                              supportbool = true;
                            } else if (editprofileController
                                    .studyperpose.value ==
                                "Other") {
                              supportbool = true;
                            } else {
                              supportbool = false;
                            }
                          });
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      supportbool
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 35.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 3),
                                    labelText: "State the support you require",
                                    focusColor: kPrimaryColor,
                                    fillColor: kPrimaryColor,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Grade',
                        style: TextStyle(color: Colors.black38),
                      ),
                      DropdownButton<String>(
                        value: editprofileController.Grade.value,
                        isExpanded: true,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        items: <String>[
                          'Nersury',
                          'LKG',
                          'UKG',
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12',
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
                            editprofileController.Grade.value = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: TextFormField(
                          controller: editprofileController.About,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 3),
                              labelText: "About Me",
                              focusColor: kPrimaryColor,
                              fillColor: kPrimaryColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Describe yourself",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          validator: (value) {
                            return editprofileController.validateName(value!);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ignore: deprecated_member_use
                          OutlineButton(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {

                                   Navigator.pop(context);
                            },
                            child: const Text("CANCEL",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.black)),
                          ),
                          RaisedButton(
                            onPressed: () {
                              print(id);
                              editprofileController.editProf(id, context);

                             

                           
                            },
                            color: kPrimaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              "Next",
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
            ),
          )
        : const Center(child: CircularProgressIndicator()));
  }

  loadData() {
    setState(() {});
    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      EasyLoading.dismiss();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        editprofileController.date = DateFormat.yMd().format(currentDate);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _imgFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      );
      setState(() {
        _imageFile = pickedFile;
        var file = File(pickedFile!.path);

        editprofileController.image = file;
      });
    } catch (e) {
      setState(() {});
    }
  }

  _imgFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      setState(() {
        _imageFile = pickedFile;
        File file = File(pickedFile!.path);

        editprofileController.image = file;
      });
    } catch (e) {
      setState(() {});
    }
  }

  refresh() {
    print("object");
    Navigator.pop(context); // pop current page

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return const EditPage();
        },
      ),
    );
  }
}
