
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../../common_widgets/my_text.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProfileItem extends StatelessWidget {

  final Color? color;
  final IconData iconPrefix;
  final String label;
  final IconData iconSuffix;
  final double iconSize;
  final Function()? onTap;

  const MyProfileItem({super.key,this.color = OtherColors.black, required this.iconPrefix, required this.label, this.iconSuffix = IconlyLight.arrow_right_2,this.iconSize = Sizes.s24,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStateProperty.all(OtherColors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(iconPrefix,size: iconSize.w,color: color),
              gapW24,
              MyText(
                type: TextTypes.bodyXLarge,
                fontWeight: FontWeights.semiBold,
                text: label,
                color: color,
              ),
            ],
          ),
          Icon(iconSuffix,size: iconSize.w,color: color),
        ],
      ),
    );
  }
}
