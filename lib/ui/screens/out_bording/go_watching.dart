import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/constants.dart';


class GoWatching extends StatefulWidget {
  const GoWatching({Key? key}) : super(key: key);

  @override
  _GoWatchingState createState() => _GoWatchingState();
}

class _GoWatchingState extends State<GoWatching> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16.w, top: 46.3.h, bottom: 2.h),
              child: Row(
                children: [
                  Text(
                    'Lets go ',
                    style: TextStyle(
                      color: color1,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 32.sp,
                    ),
                  ),
                  Text(
                    'watching',
                    style: TextStyle(
                      color: color2,
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 32.sp,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Swipe up to to start watch, like, comment, and share your favorite content',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'poppins',
                  color: color1,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15.h),
              child: Image.asset('assets/images/watch.png'),
            ),
            SizedBox(
              // margin: EdgeInsets.only(top: 177.h, bottom: 12.h),
              width: 343.w,
              height: 48.h,
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(0, 126.h),
                  backgroundColor: const Color(0xff242424),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0.r),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Nav_screen' );
                },
                child: Text(
                  'Start Watching',
                  style: TextStyle(fontSize: 16.sp, fontFamily: 'poppins', color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
