import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_minimizer/flutter_app_minimizer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helper/shared_prefrences_helper.dart';
import '../../widgets/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SharedPrefrencesHelper.sharedPrefrencesHelper.getSeen("interestSeen") ==
            null
        ? SharedPrefrencesHelper.sharedPrefrencesHelper
            .setSeen("interestSeen", false)
        : '';
    SharedPrefrencesHelper.sharedPrefrencesHelper.getSeen("genderSeen") == null
        ? SharedPrefrencesHelper.sharedPrefrencesHelper
            .setSeen("genderSeen", false)
        : '';
    SharedPrefrencesHelper.sharedPrefrencesHelper.getLogin() == null
        ? SharedPrefrencesHelper.sharedPrefrencesHelper.setIsLogin(false)
        : '';

    Future.delayed(const Duration(seconds: 3), () {
      String route;
      if (SharedPrefrencesHelper.sharedPrefrencesHelper
              .getSeen("interestSeen")! &&
          SharedPrefrencesHelper.sharedPrefrencesHelper
              .getSeen("genderSeen")!) {
        route = '/Nav_screen';
      } else {
        if (SharedPrefrencesHelper.sharedPrefrencesHelper.getLogin() != null) {
          route = SharedPrefrencesHelper.sharedPrefrencesHelper.getLogin()!
              ? '/OnBoarding'
              : '/interests_screen';
        } else {
          route = '/interests_screen';
        }
      }

      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color2,
      body: Stack(children: [
        Image.asset(
          'assets/images/stack.png',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Center(
          child: Image.asset('assets/images/logo.PNG'),
        ),
      ]),
    );
  }
}
