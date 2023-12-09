
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'my_blur_filter.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Sizes.s1.sh ,
      height: Sizes.s1.sh ,
      child: Stack(
        alignment: Alignment.center,
        children: [
          MyBlurFilter(),
          SizedBox(
            width: Sizes.s60.w,
            height: Sizes.s60.w,
            child: CircularProgressIndicator(
              strokeWidth: Sizes.s8.w,
              color: MainColors.primary,
              backgroundColor: BackgroundColors.blue,
            ),
          )
        ],
      ),
    );
  }
}
