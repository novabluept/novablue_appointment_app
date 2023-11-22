import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';

class MyAvatar extends StatelessWidget {

  final double pictureSize;
  final double editSize;
  final double iconSize;

  const MyAvatar({super.key, this.pictureSize = 200, this.editSize = 40, this.iconSize = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: pictureSize.w,
      height: pictureSize.w,
      child: CircleAvatar(
        radius: 58.r,
        backgroundColor: GreyScaleColors.grey100,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: editSize.w,
                height: editSize.w,
                child: CircleAvatar(
                  radius: 18.r,
                  backgroundColor: MainColors.primary,
                  child: Icon(IconlyBold.edit,color: OtherColors.white,size: iconSize.w),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
