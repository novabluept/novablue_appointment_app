import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonTypes {
  filledRounded,
  filledFullyRounded,
  outlined,
}

class MyButton extends StatelessWidget {

  final ButtonTypes type;
  final String? text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;
  final double? verticalPadding;
  final Function()? onPressed;

  const MyButton({super.key, required this.type, this.text, this.backgroundColor,
    this.foregroundColor = OtherColors.white, this.width = double.infinity, this.height = Sizes.s60, this.verticalPadding = Sizes.s18,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonTypes.filledRounded:
        return mainButton(true,width!,height!,verticalPadding!,backgroundColor ?? MainColors.primary,foregroundColor!,text,Sizes.s16);
      case ButtonTypes.filledFullyRounded:
        return mainButton(true,width!,height!,verticalPadding!,backgroundColor ?? MainColors.primary,foregroundColor!,text,Sizes.s100);
      case ButtonTypes.outlined:
        return mainButton(false,width!,height!,verticalPadding!,backgroundColor ?? OtherColors.transparent,foregroundColor!,text,Sizes.s100);
      default:
        return Container();
    }
  }

  Widget mainButton(bool isFilled,double width,double height,double verticalPadding,
      Color backgroundColor,Color foregroundColor,String? text,double borderRadius){
    return SizedBox(
      width: double.infinity,
      height: height.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          //padding: EdgeInsets.symmetric(vertical: verticalPadding.h),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius).r,
          ),
          side: BorderSide(
            color: type != ButtonTypes.outlined ? backgroundColor : foregroundColor,
            width: Sizes.s1.w
          )
        ),
        onPressed: onPressed,
        child: MyText(
          type: TextTypes.bodyLarge,
          fontWeight: FontWeights.bold,
          text: text ?? '',
          color: foregroundColor,
        ),
      ),
    );
  }
}
