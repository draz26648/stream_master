import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stream_master/ui/screens/auth/email_login.dart';
import 'package:stream_master/ui/screens/auth/email_signup.dart';
import 'package:stream_master/ui/screens/auth/phone_signup.dart';
import 'package:stream_master/ui/screens/auth/sign_up_method.dart';
import 'package:stream_master/ui/screens/edit_profile_screen.dart';
import 'package:stream_master/ui/screens/nav.dart';
import 'package:stream_master/ui/screens/out_bording/gender_screen.dart';
import 'package:stream_master/ui/screens/out_bording/go_watching.dart';
import 'package:stream_master/ui/screens/out_bording/interests_screen.dart';
import 'package:stream_master/ui/screens/out_bording/splash_screen.dart';
import 'controllers/general_controller.dart';
import 'controllers/profile_controller.dart';
import 'helper/shared_prefrences_helper.dart';
import 'ui/screens/out_bording/birth_date.dart';
import 'ui/screens/out_bording/congrats_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefrencesHelper.sharedPrefrencesHelper.initSharedPrefrences();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GeneralDataController _controller =
      Get.put<GeneralDataController>(GeneralDataController());
  final ProfileController _controller1 =
      Get.put<ProfileController>(ProfileController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      builder: (context) {
        return MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/splash_screen',
            routes: {
              '/splash_screen': (context) => const SplashScreen(),
              '/interests_screen': (context) => const InterestsScreen(),
              '/gender_screen': (context) => const GenderScreen(),
              '/go_watching': (context) => const GoWatching(),
              '/signUp_method': (context) => const SignUpMethods(),
              '/email_signUp': (context) => const EmailSignUp(),
              '/phone_signUp': (context) => const PhoneSignUp(),
              '/congrats_screen': (context) => const CongratsScreen(),
              '/birth_date': (context) => const birthDate(),
              '/Sign_in': (context) => const EmailSignIn(),
              '/Nav_screen': (context) => const NavScreen(),
              '/edit_profile_screen': (context) => const EditProfileScreen(),
            },
          ),
        );
      },
    );
  }
}
