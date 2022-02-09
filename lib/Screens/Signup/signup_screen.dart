import 'package:flutter/material.dart';
import 'package:addistutor_student/Screens/Signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: Body(),
    );
  }
}
