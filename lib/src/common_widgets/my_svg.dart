
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class MySvg extends StatelessWidget {

  final Color colorFilter;
  final String imagePath;
  final double width;
  final double height;

  const MySvg({super.key, required this.colorFilter, required this.imagePath, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    /*return ClipRect(
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(colorFilter.withOpacity(0.8), BlendMode.hue),
        child: Container(
          decoration: BoxDecoration(
              color: OtherColors.white,
              border: Border.all(width: Sizes.s1.w,color: OtherColors.white)
          ),)
          child: SvgPicture.asset(
            imagePath,
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }*/
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ClipRect(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(colorFilter.withOpacity(0.8), BlendMode.hue),
              child: Container(
                color: OtherColors.white,
                width: width,
                height: height,
                child: SvgPicture.asset(
                  imagePath,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              //color: OtherColors.red,
              border: Border.all(width: Sizes.s1.w,color: OtherColors.white)
            ),
          ),
        )
      ],
    );
  }
}
