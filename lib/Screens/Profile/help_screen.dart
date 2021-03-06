// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, import_of_legacy_library_into_null_safe

import 'package:addistutor_student/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:introduction_screen/introduction_screen.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return const Scaffold(
      body: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pop(context);
  }

  Widget _buildImage(String assetName, [double width = 250]) {
    return SvgPicture.asset(
      'assets/icons/$assetName',
      width: width,
      color: kPrimaryLightColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 16.0,
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.bold,
      letterSpacing: 0.4,
      height: 0.9,
      color: Colors.white,
    );

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontFamily: 'Roboto',
          letterSpacing: 0.4,
          fontWeight: FontWeight.w800,
          color: Colors.white),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: kPrimaryColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: kPrimaryColor,

      pages: [
        PageViewModel(
          title: "Register",
          body: "Complete all the fields in the registration page.",
          image: _buildImage('test.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tutor Selection",
          body:
              "The system will generate a selection of tutors as per your requirement. You can select one of your choice.",
          image: _buildImage('test2.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Make Payment",
          body:
              "Pay for the number of sessions you want to buy using the multiple payment options and upload the deposit slip.",
          image: _buildImage('test3.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "QR Code",
          body:
              "As soon as payment is received, you will receive a QR code. The QR code needs to be scanned at the end of each session to confirm service delivery.",
          image: _buildImage('test4.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tutor Confirmation",
          body: "Your chosen tutor will contact you to resume service.",
          image: _buildImage('test5.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Review Tutor",
          body: "Rate your tutor at the end of any session.",
          image: _buildImage('test6.svg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white,
        activeColor: kPrimaryColor,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: kPrimaryLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
