import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_master/ui/screens/nav.dart';

import '../../widgets/constants.dart';



class CongratsScreen extends StatefulWidget {
  const CongratsScreen({Key? key}) : super(key: key);

  @override
  _CongratsScreenState createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 128.w),
                child: Image.asset('assets/congrats.png',),
              ),
              Container(
                margin: EdgeInsets.only(left: 16.w, top: 12.h, bottom: 2.h),
                child: Text(
                  'Congratulations!',
                  style: TextStyle(
                    color: color2,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 32.h),
                child: Text(
                  'Your account is now ready',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'poppins',
                    color: color1,
                  ),
                ),
              ),
              SizedBox(
                
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
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => NavScreen(),),);
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
      ),
    );
  }
}
