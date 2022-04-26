import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/general_controller.dart';
import '../../widgets/constants.dart';
import '../auth/selected_method.dart';

class birthDate extends StatefulWidget {
  const birthDate({Key? key}) : super(key: key);

  @override
  _birthDateState createState() => _birthDateState();
}

class _birthDateState extends State<birthDate> {
  DateTime date = DateTime(2022, 03, 26);
  SelectedMethod? _method;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color2,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/stack.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Container(
              margin: EdgeInsets.only(top: 50.h, left: 19),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.keyboard_backspace,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 110.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14.r),
                  topLeft: Radius.circular(14.r),
                ),
              ),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24.h, left: 16.w),
                    child: Text(
                      'When’s your birthday?',
                      style: TextStyle(
                        color: color2,
                        fontFamily: 'poppins',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 24.h, left: 16.w, right: 122.w),
                    child: Text(
                      'Your birthday won’t be shown publicly',
                      style: TextStyle(
                        color: color1,
                        fontFamily: 'poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 24.h, left: 16.w, bottom: 10.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text('Day'),
                            Text('Month'),
                            Text('Year'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (newDate == null) return;
                      setState(() {
                        date = newDate;
                        GeneralDataController.to.date.value =
                            "${date.day}-${date.month}-${date.year}";
                      });
                    },
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: color1.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      margin: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('     ${date.day}              |'),
                          Text('${date.month}            |'),
                          Text('${date.year}'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    width: 343.w,
                    height: 48.h,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(0, 126.h),
                        backgroundColor: const Color(0xff242424),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/signUp_method');
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
