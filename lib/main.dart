import 'dart:io';

import 'package:addistutor_student/Screens/Profile/localstring.dart';
import 'package:addistutor_student/Screens/connectvity.dart';

import 'package:addistutor_student/constants.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:connectivity/connectivity.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:new_version/new_version.dart';
import 'package:sizer/sizer.dart';
import 'Screens/splash/error.dart';
import 'Screens/splash/splash_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Map _source = {ConnectivityResult.none: false};
MyConnectivity _connectivity = MyConnectivity.instance;
bool isconected = false;

class _MyHomePageState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.

    // try {
    //   if (simpleBehavior) {
    //     basicStatusCheck(newVersion);
    //   } else {
    //     advancedStatusCheck(newVersion);
    //   }
    // } on Exception catch (e) {
    //   // TODO
    // }
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'NEXTGEN student',
        dialogText: 'New Update',
      );
    }
  }

  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  @override
  Widget build(BuildContext context) {
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        setState(() {
          isconected = false;
        });

        // ignore: avoid_print

        break;
      case ConnectivityResult.mobile:
        setState(() {
          isconected = true;
        });
        // ignore: avoid_print

        break;
      case ConnectivityResult.wifi:
        setState(() {
          isconected = true;
        });

      // ignore: avoid_print

    }
    return isconected
        ? Sizer(builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              translations: LocaleString(),
              locale: const Locale('en', 'US'),
              title: 'NextGen',
              theme: ThemeData(
                primaryColor: kPrimaryColor,
                scaffoldBackgroundColor: Colors.white,
              ),
              home: const SplashScreen(),
              builder: EasyLoading.init(),
            );
          })
        : buildUnAuthScreen();
  }

  buildUnAuthScreen() {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return GetMaterialApp(
        title: 'NextGen',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const ConnectionFaildScreen(),
      );
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
