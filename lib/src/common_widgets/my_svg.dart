
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';

class MySvg extends StatelessWidget {

  final Color colorFilter;
  final String imagePath;
  final double width;
  final double height;

  const MySvg({super.key, required this.colorFilter, required this.imagePath, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: OtherColors.white,
      width: width,
      height: height,
      child: ClipRect(
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(MainColors.primary, BlendMode.hue),
          child: Container(
            color: OtherColors.white,
            child: SvgPicture.asset(
              imagePath,
            ),
          ),
        ),
      ),
    );
  }

}
