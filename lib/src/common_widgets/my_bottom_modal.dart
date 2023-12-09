
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';

import '../constants/app_colors.dart';
import 'my_blur_filter.dart';

class MyBottomModal extends StatelessWidget {

  final Widget content;

  const MyBottomModal({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyBlurFilter(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: 24.w,top: 12.h,right: 24.w,bottom: 48.h),
              decoration: BoxDecoration(
                color: OtherColors.white,
                borderRadius: BorderRadius.only(topLeft: const Radius.circular(48).r,topRight: const Radius.circular(48).r),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: GreyScaleColors.grey300,
                        borderRadius: BorderRadius.only(topLeft: const Radius.circular(48).r,topRight: const Radius.circular(48).r),
                      ),
                    ),
                  ),
                  gapH24,
                  content
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
