import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../helper/shared_prefrences_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.r),
            bottomRight: Radius.circular(15.r),
          ),
        ),
        backgroundColor: Colors.black,
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            InkWell(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/profile.png',
                    width: 24.w,
                    height: 24.h,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, '/edit_profile_screen');
              },
            ),
            const SizedBox(height: 32),
            InkWell(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/wallet.png',
                    width: 24.w,
                    height: 24.h,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Text(
                      'Balance',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios),
                  const SizedBox(width: 10),
                ],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 32),
            InkWell(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/support.png',
                    width: 24.w,
                    height: 24.h,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Text(
                      'Support',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios),
                  const SizedBox(width: 10),
                ],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 32),
            InkWell(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/language.png',
                    width: 24.w,
                    height: 24.h,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Text(
                      'Language',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    width: 36.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF7A87FF),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'عربى',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 32),
            InkWell(
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logout.png',
                    width: 24.w,
                    height: 24.h,
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              onTap: () {
                SharedPrefrencesHelper.sharedPrefrencesHelper.setIsLogin(false);
                SharedPrefrencesHelper.sharedPrefrencesHelper.logout(
                    '${SharedPrefrencesHelper.sharedPrefrencesHelper.getToken()}');
                Fluttertoast.showToast(msg: 'Logged out');
                Navigator.pushReplacementNamed(context, '/Sign_in');
              },
            ),
          ],
        ),
      ),
    );
  }
}
