// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe, unnecessary_null_comparison, prefer_typing_uninitialized_variables, prefer_is_empty

import 'dart:convert';
import 'dart:io';

import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';

import 'package:addistutor_student/constants.dart';
import 'package:addistutor_student/controller/editprofilecontroller.dart';
import 'package:addistutor_student/controller/getlocationcontroller.dart';
import 'package:addistutor_student/controller/getmyaccount.dart';
import 'package:addistutor_student/controller/signupcontroller.dart';
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

  late var areyou = "";
  late var locationname = "";
  late var getlocation;
  late var areyoubool = "";
  late bool supportbool = false;
  DateTime currentDate = DateTime.now();
  bool showPassword = false;
  bool showsubject = false;
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  final GetmyAccount getmyAccount = Get.find();
  final EditprofileController editprofileController =
      Get.put(EditprofileController());

  final SignupController signupController = Get.put(SignupController());

  GetLocationController getLocationController =
      Get.put(GetLocationController());

  List<GetLocationforedit> location = [];
  var noid;
  @override
  void initState() {
    super.initState();
    _getlocation();

    editprofileController.date = DateFormat.yMd().format(DateTime.now());
    _getmyaccount();
    _fetchUser();
  }

  void _getmyaccount() async {
    // monitor network fetch
    // await Future.delayed(const Duration(milliseconds: 1000));
    getmyAccount.fetchqr();
    setState(() {
      editprofileController.firstname.text = getmyAccount.full_name;
      editprofileController.email.text = getmyAccount.email;
      editprofileController.phone.text = getmyAccount.phone;
    });
  }

  _getlocation() async {
    getLocationController.fetchLocation();
    // ignore: invalid_use_of_protected_member
    location = getLocationController.listlocationforedit.value;
    if (location != null && location.isNotEmpty) {
      setState(() {
        editprofileController.locaion = location[0];
        editprofileController.locaionid = location[0].id;
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
        editprofileController.fetchPf(int.parse(body["student_id"]));
        id = int.parse(body["student_id"]);
      } else {
        setState(() {
          noid = "noid";
        });

        editprofileController.fetchPf(noid);
      }
    } else {}
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => editprofileController.isFetched.value
        ? Scaffold(
            resizeToAvoidBottomInset: false,
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
                "Profile",
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
                    FocusScopeNode currentScope = FocusScope.of(context);
                    if (!currentScope.hasPrimaryFocus &&
                        currentScope.hasFocus) {
                      FocusManager.instance.primaryFocus!.unfocus();
                    }
                  },
                  child: ListView(
                    children: [
                      noid != "noid"
                          ? Center(
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
                                              borderRadius:
                                                  BorderRadius.circular(40),
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
                                                      BorderRadius.circular(
                                                          50)),
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
                            )
                          : Container(),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Are you a parent or student?',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                          fontFamily: 'WorkSans',
                        ),
                      ),
                      DropdownButton<String>(
                        value: areyou,
                        isExpanded: true,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        items: <String>[
                          '',
                          'Student',
                          'Parent',
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
                            areyou = value!;
                            if (areyou == "Parent") {
                              areyoubool = "Parent";
                              editprofileController.is_parent.value = true;
                            } else if (areyou == "Student") {
                              areyoubool = "Student";
                              editprofileController.is_parent.value = false;
                            } else {
                              areyoubool = "";
                            }
                          });
                          //  areyoubool = false;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      areyoubool == "Parent"
                          ? Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 35.0),
                                child: TextFormField(
                                  controller:
                                      editprofileController.parent_first_name,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 3),
                                    labelText: "Parent  Name",
                                    labelStyle: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: kPrimaryColor,
                                      fontFamily: 'WorkSans',
                                    ),
                                    focusColor: kPrimaryColor,
                                    fillColor: kPrimaryColor,
                                    hintText: getmyAccount.full_name,
                                    hintStyle: const TextStyle(
                                        color: DesignCourseAppTheme.nearlyBlack,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
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
                                    contentPadding: EdgeInsets.only(bottom: 3),
                                    labelText: "Parent Father's name",
                                    labelStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: kPrimaryColor,
                                      fontFamily: 'WorkSans',
                                    ),
                                    focusColor: kPrimaryColor,
                                    fillColor: kPrimaryColor,
                                    hintText: "Parent Father's name",
                                    hintStyle: TextStyle(
                                        color: DesignCourseAppTheme.nearlyBlack,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
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
                                    contentPadding: EdgeInsets.only(bottom: 3),
                                    labelText: "Student Name",
                                    labelStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: kPrimaryColor,
                                      fontFamily: 'WorkSans',
                                    ),
                                    focusColor: kPrimaryColor,
                                    fillColor: kPrimaryColor,
                                    hintText: "Student Name",
                                    hintStyle: TextStyle(
                                        color: DesignCourseAppTheme.nearlyBlack,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
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
                                    contentPadding: EdgeInsets.only(bottom: 3),
                                    labelText: "Student Father's name",
                                    labelStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: kPrimaryColor,
                                      fontFamily: 'WorkSans',
                                    ),
                                    focusColor: kPrimaryColor,
                                    fillColor: kPrimaryColor,
                                    hintText: "Student Father's name",
                                    hintStyle: TextStyle(
                                        color: DesignCourseAppTheme.nearlyBlack,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  validator: (value) {
                                    return editprofileController
                                        .validateName(value!);
                                  },
                                ),
                              ),
                            ])
                          : areyoubool == "Student"
                              ? Column(children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 35.0),
                                    child: TextFormField(
                                      controller:
                                          editprofileController.firstname,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 3),
                                        labelText: "Student Name",
                                        labelStyle: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: kPrimaryColor,
                                          fontFamily: 'WorkSans',
                                        ),
                                        focusColor: kPrimaryColor,
                                        fillColor: kPrimaryColor,
                                        hintText: "Student Name",
                                        hintStyle: TextStyle(
                                            color: DesignCourseAppTheme
                                                .nearlyBlack,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      validator: (value) {
                                        return editprofileController
                                            .validateName(value!);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 35.0),
                                    child: TextFormField(
                                      controller:
                                          editprofileController.lastname,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 3),
                                        labelText: "Student Father's Name",
                                        labelStyle: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: kPrimaryColor,
                                          fontFamily: 'WorkSans',
                                        ),
                                        focusColor: kPrimaryColor,
                                        fillColor: kPrimaryColor,
                                        hintText: "Student Father's Name",
                                        hintStyle: TextStyle(
                                            color: DesignCourseAppTheme
                                                .nearlyBlack,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      validator: (value) {
                                        return editprofileController
                                            .validateName(value!);
                                      },
                                    ),
                                  ),
                                ])
                              : Container(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: TextFormField(
                          controller: editprofileController.phone,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            labelText: "Phone Number",
                            labelStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryColor,
                              fontFamily: 'WorkSans',
                            ),
                            focusColor: kPrimaryColor,
                            fillColor: kPrimaryColor,
                            hintText: getmyAccount.phone,
                            hintStyle: const TextStyle(
                                color: DesignCourseAppTheme.nearlyBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: editprofileController.email,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 3),
                            labelText: "Email",
                            labelStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryColor,
                              fontFamily: 'WorkSans',
                            ),
                            focusColor: kPrimaryColor,
                            fillColor: kPrimaryColor,
                            hintText: getmyAccount.email,
                            hintStyle: const TextStyle(
                                color: DesignCourseAppTheme.nearlyBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      const Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                          fontFamily: 'WorkSans',
                        ),
                      ),
                      DropdownButton<String>(
                        value: editprofileController.macthgender.value,
                        isExpanded: true,
                        style: const TextStyle(
                            color: DesignCourseAppTheme.nearlyBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
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
                                  color: DesignCourseAppTheme.nearlyBlack,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
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
                        'Select Date Of birth',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                          fontFamily: 'WorkSans',
                        ),
                      ),
                      OutlineButton(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        color: kPrimaryLightColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        highlightColor: kPrimaryColor,
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Text(editprofileController.date.toString(),
                            style: const TextStyle(
                                color: DesignCourseAppTheme.nearlyBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.w300)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                          fontFamily: 'WorkSans',
                        ),
                      ),
                      Row(children: [
                        Flexible(
                          child: DropdownButton<GetLocationforedit>(
                            hint: Text(
                              editprofileController.locaion.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            isExpanded: true,
                            style: const TextStyle(
                                color: DesignCourseAppTheme.nearlyBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                            items: location
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

                                if (editprofileController
                                        .locaion!.locaion.length !=
                                    0) {
                                  showsubject = true;
                                } else {
                                  showsubject = false;
                                }
                              });
                            },
                            value: editprofileController.locaion,
                          ),
                        ),
                        Text(
                          locationname,
                          style: const TextStyle(color: Colors.black38),
                        ),
                      ]),
                      showsubject
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                height: 70,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, index) {
                                      return Column(
                                        children: [
                                          getTimeBoxUIday(
                                              editprofileController
                                                  .locaion!.locaion[index].name,
                                              editprofileController
                                                  .locaion!.locaion[index].id),
                                        ],
                                      );
                                    },
                                    itemCount: editprofileController
                                        .locaion!.locaion.length),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Grade',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                          fontFamily: 'WorkSans',
                        ),
                      ),
                      DropdownButton<String>(
                        value: editprofileController.Grade.value,
                        isExpanded: true,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        items: <String>[
                          '',
                          'Kg',
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
                                  color: DesignCourseAppTheme.nearlyBlack,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
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
                          keyboardType: TextInputType.multiline,
                          controller: editprofileController.About,
                          maxLength: 200,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: "About Me",
                            labelStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryColor,
                              fontFamily: 'WorkSans',
                            ),
                            focusColor: kPrimaryColor,
                            fillColor: kPrimaryColor,
                            hintText: "tell us your study objective",
                            hintStyle: TextStyle(
                                color: DesignCourseAppTheme.nearlyBlack,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            onPressed: () {
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

  Widget getTimeBoxUIday(String txt2, int id) {
    return GestureDetector(
      onTap: () {
        setState(() {
          //  print(lid);
          //  lid = id.toString();
          locationname = txt2;
          editprofileController.locaionid = id;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: DesignCourseAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: DesignCourseAppTheme.grey.withOpacity(0.2),
                  offset: const Offset(1.1, 1.1),
                  blurRadius: 8.0),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  txt2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
        firstDate: DateTime(1990),
        lastDate: currentDate);
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
