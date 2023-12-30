
import 'package:flutter/material.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {

  final Widget child;

  const MyShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: GreyScaleColors.grey300,
      highlightColor: GreyScaleColors.grey100,
      child: child,
    );
  }
}
