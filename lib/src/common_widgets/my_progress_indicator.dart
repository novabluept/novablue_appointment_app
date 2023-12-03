
import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Container(),
        ),
        Center(
          child: SizedBox(
            width: Sizes.s60.w,
            height: Sizes.s60.w,
            child: CircularProgressIndicator(
              strokeWidth: Sizes.s8.w,
              color: MainColors.primary,
              backgroundColor: BackgroundColors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
