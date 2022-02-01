// import 'package:addistutor_student/Screens/Book/book.dart';
// import 'package:addistutor_student/remote_services/user.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ReportScreen extends StatefulWidget {
//   @override
//   _SettingsScreenState createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<ReportScreen> {
//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () async {});
//     print("object");
//     super.initState();
//   }

//   bool lockInBackground = true;
//   bool notificationsEnabled = true;
//   late String strTitle;
//   List<ReportScreen> arrSongList = [];
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: getTutorAvlblityController.isfetchedlocation.isTrue
//               ? ListView.builder(
//                   physics: const BouncingScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     return FollowedList(
//                       day: getTutorAvlblityController.listdate[index],
//                     );
//                   },
//                   itemCount: getTutorAvlblityController.listdate.length,
//                 )
//               : const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//         ));
//   }
// }


// }
