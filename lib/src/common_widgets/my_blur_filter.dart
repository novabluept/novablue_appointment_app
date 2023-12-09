
import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

class MyBlurFilter extends StatelessWidget {

  final double sigmaX;
  final double sigmaY;

  const MyBlurFilter({super.key, this.sigmaX = Sizes.s5, this.sigmaY = Sizes.s5});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: sigmaX,
        sigmaY: sigmaY,
      ),
      child: const SizedBox(),
    );
  }
}
