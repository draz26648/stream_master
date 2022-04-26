import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_master/ui/widgets/constants.dart';

import '../../controllers/general_controller.dart';
import '../../helper/shared_prefrences_helper.dart';

class GenderBtn extends StatelessWidget {
  IconData? icon;
  int? value;
  int? groupValue;
  ValueChanged? onChanged;

  GenderBtn({this.icon, this.value, this.groupValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return Container(
      margin: EdgeInsets.all(10.w),
      width: 135.w,
      height: 135.h,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          minimumSize: Size(0, 135.h),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0.r),
          ),
        ),
        onPressed: () {
          GeneralDataController.to.gender.value = value!;
          SharedPrefrencesHelper.sharedPrefrencesHelper
              .setData("gender", value.toString());
          onChanged!(value);
        },
        child: Icon(
          icon,
          size: 55,
          color: !isSelected
              ? color1
              : icon == Icons.female
                  ? Colors.pink
                  : Colors.blue[500],
        ),
      ),
    );
  }
}
