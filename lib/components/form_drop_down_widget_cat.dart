// ignore_for_file: use_key_in_widget_constructors, prefer_null_aware_operators

import 'package:addistutor_student/components/custom_sizes.dart';
import 'package:addistutor_student/components/screen_utils.dart';
import 'package:addistutor_student/remote_services/user.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class FormDropDownWidgetCat extends StatelessWidget {
  const FormDropDownWidgetCat({
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.value,
    required this.onChanged,
    this.isZone,
  });

  ///ADDITIONAL  PARAMS
  final String hintText;
  final List<GetCategory> options;
  final GetCategory? value;
  final void Function(GetCategory) onChanged;

  ///DEBUG
  final bool? isZone;

  @override
  Widget build(BuildContext context) {


    return buildDefaultDropDown(context);
  }

  Padding buildDefaultDropDown(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil().isPhone() ? CustomSizes.mp_v_2 : CustomSizes.mp_v_2,
      ),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: value != null ? value!.id : null,
              isExpanded: true,
              menuMaxHeight: 60.h,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                contentPadding:
                    Theme.of(context).inputDecorationTheme.contentPadding,
                labelText: hintText,
              ),
              hint: Text(
                hintText,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              isDense: true,
              onChanged: (String? val) {
                onChanged(options.where((element) => element.id == val!).first);
              },
              icon: Icon(
                FontAwesomeIcons.chevronDown,
                color: Colors.grey,
                size: CustomSizes.icon_size_4,
              ),
              items: options.map((GetCategory value) {
                return DropdownMenuItem<String>(
                  value: value.id,
                  child: Text(
                    value.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
