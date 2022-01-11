// ignore_for_file: deprecated_member_use

/**
 * Author: Aparna Dulal
 * profile: https://github.com/ambikadulal
  */
import 'dart:io';

import 'package:addistutor_student/Screens/Home/components/design_course_app_theme.dart';
import 'package:addistutor_student/Screens/Profile/editprofile2.dart';
import 'package:addistutor_student/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

final ImagePicker _picker = ImagePicker();
ImagePicker picker = ImagePicker();
late var macthgender = "Male";
late var locaion = "Bole";
late var education = "Primary";
late var study_purpose = "Regular support";
late var Grade = "Nersury";
late var areyou = "Parent";
late bool areyoubool = false;
late bool supportbool = false;
DateTime currentDate = DateTime.now();
var date;

class _EditPageState extends State<EditPage> {
  bool showPassword = false;

  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }

  @override
  void initState() {
    date = DateFormat.yMd().format(DateTime.now());

    super.initState();
  }

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
                                child: Image.file(File(_imageFileList![0].path),
                                    width: 95, height: 95, fit: BoxFit.cover),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
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
                              color: Theme.of(context).scaffoldBackgroundColor,
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
                  'Parent',
                  'Student',
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
                    } else {
                      areyoubool = false;
                    }
                  });
                  //  areyoubool = false;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              areyoubool
                  ? buildTextFieldparrent(
                      "Parret First Name", "Evan kutto", false)
                  : buildTextFieldstudent(
                      "Student First Name", "Evan kutto", false),
              buildTextField("Phone Number", "Evan kutto", false),
              buildTextField("E-mail", "evan@gmail.com", false),
              const Text(
                'Gender',
                style: TextStyle(color: Colors.black38),
              ),
              DropdownButton<String>(
                value: macthgender,
                isExpanded: true,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                items: <String>[
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
                    macthgender = value!;
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
                child: Text(date.toString(),
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.black)),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Location',
                style: TextStyle(color: Colors.black38),
              ),
              DropdownButton<String>(
                value: locaion,
                hint: const Text(
                  "Location",
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
                items: <String>[
                  'Bole',
                  'Yeka',
                  'Kolfe',
                  'Arada',
                  'Kirkos',
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
                    locaion = value!;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Educational BackGround',
                style: TextStyle(color: Colors.black38),
              ),
              DropdownButton<String>(
                value: education,
                isExpanded: true,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                items: <String>[
                  'Primary',
                  'Secondary',
                  'Preparatory',
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
                    education = value!;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Study Purpose',
                style: TextStyle(color: Colors.black38),
              ),
              DropdownButton<String>(
                value: study_purpose,
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
                    study_purpose = value!;
                    if (study_purpose == "Specific support") {
                      supportbool = true;
                    } else if (study_purpose == "Other") {
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
                  ? buildTextField("State the  support you require ", "", false)
                  : Container(),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Grade ',
                style: TextStyle(color: Colors.black38),
              ),
              DropdownButton<String>(
                value: Grade,
                isExpanded: true,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                items: <String>[
                  'Nersury',
                  'LKG',
                  'UKG',
                  'Grade 1',
                  'Grade 2',
                  'Grade 3',
                  'Grade 4',
                  'Grade 5',
                  'Grade 6',
                  'Grade 7',
                  'Grade 8',
                  'Grade 9',
                  'Grade 10',
                  'Grade 11',
                  'Grade 12',
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
                    Grade = value!;
                  });
                },
              ),
              const SizedBox(
                height: 25,
              ),
              buildTextField(
                  "About Me", "You really think you can read ?", false),
              const SizedBox(
                height: 35,
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
                    onPressed: () {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => EditPage2(),
                        ),
                      );
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
    );
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
        date = DateFormat.yMd().format(currentDate);
      });
    }
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: kPrimaryColor,
                    ),
                  )
                : null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            focusColor: kPrimaryColor,
            fillColor: kPrimaryColor,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget buildTextFieldstudent(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          obscureText: isPasswordTextField ? showPassword : false,
          decoration: InputDecoration(
              suffixIcon: isPasswordTextField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                        color: kPrimaryColor,
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.only(bottom: 3),
              labelText: labelText,
              focusColor: kPrimaryColor,
              fillColor: kPrimaryColor,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          obscureText: isPasswordTextField ? showPassword : false,
          decoration: InputDecoration(
              suffixIcon: isPasswordTextField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                        color: kPrimaryColor,
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.only(bottom: 3),
              labelText: "Student Last Name",
              focusColor: kPrimaryColor,
              fillColor: kPrimaryColor,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
      ),
    ]);
  }

  Widget buildTextFieldparrent(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          obscureText: isPasswordTextField ? showPassword : false,
          decoration: InputDecoration(
              suffixIcon: isPasswordTextField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                        color: kPrimaryColor,
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.only(bottom: 3),
              labelText: labelText,
              focusColor: kPrimaryColor,
              fillColor: kPrimaryColor,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          obscureText: isPasswordTextField ? showPassword : false,
          decoration: InputDecoration(
              suffixIcon: isPasswordTextField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                        color: kPrimaryColor,
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.only(bottom: 3),
              labelText: "Parent Last Name",
              focusColor: kPrimaryColor,
              fillColor: kPrimaryColor,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
      ),
    ]);
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
        File file = File(pickedFile!.path);

        //  editprofileController.image = file;
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

        //  editprofileController.image = file;
      });
    } catch (e) {
      setState(() {});
    }
  }
}
