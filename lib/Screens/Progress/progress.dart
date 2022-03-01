// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, import_of_legacy_library_into_null_safe

import 'package:addistutor_student/Screens/Welcome/welcome_screen.dart';
import 'package:addistutor_student/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:introduction_screen/introduction_screen.dart';

class MyPages extends StatelessWidget {
  const MyPages({Key? key}) : super(key: key);

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
  void _onIntroEnd(context) {
    Navigator.push(
      // ignore: prefer_const_constructors
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const WelcomeScreen(),
        transitionDuration: Duration.zero,
      ),
    );
  }

  Widget _buildImage(String assetName, [double width = 200]) {
    return Image(
      image: AssetImage(
        'assets/images/$assetName',
      ),
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 16.0,
      fontFamily: 'WorkSans',
      fontWeight: FontWeight.bold,
      letterSpacing: 0.3,
      color: Color(0xFF4A6572),
    );

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontFamily: 'Roboto',
          letterSpacing: 0.4,
          fontWeight: FontWeight.w800,
          color: kPrimaryColor),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          title: "CHOICE",
          body:
              "You can choose the best tutor for your child from our rich database as per your requirement. Depending on need, you can also select a team of specialists. Similarly, you can arrange the tutorial for a date and time that suits your child. You can either buy a short term or long term package. It is infinitely flexible.",
          image: _buildImage('t.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "CONVENIENCE",
          body:
              "You can reach us through our website, app or on the phone and booking a tutor is extremely easy.",
          image: _buildImage('p.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "SAFETY",
          body:
              "All our tutors are registered and vetted. They have signed up to our child protection and safeguarding policy.",
          image: _buildImage('b.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "COMPANY SUPPORT",
          body:
              "By working with us, you are getting more than a tutor. We support our tutors to offer the best support possible to your child.",
          image: _buildImage('t.jpg'),
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
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
