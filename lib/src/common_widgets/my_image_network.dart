
import 'package:flutter/material.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'my_shimmer.dart';

class MyImageNetwork extends StatelessWidget {

  final String url;
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;

  const MyImageNetwork({super.key,required this.url, required this.width, required this.height, required this.borderRadius});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: MyShimmer(
                child: Container(
                  color: OtherColors.white,
                ),
              ),
            );
          },
          errorBuilder: (context, exception, stackTrace) {
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: GreyScaleColors.grey300,
                borderRadius: borderRadius,
              ),
            );
          },
        ),
      ),
    );
  }
}



