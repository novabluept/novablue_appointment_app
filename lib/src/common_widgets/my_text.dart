
import 'package:flutter/cupertino.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';


class FontFamilies {
  static const urbanist = 'Urbanist';
}

class FontWeights {
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
}

enum TextTypes{
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  bodyXLarge,
  bodyLarge,
  bodyMedium,
  bodySmall,
  bodyXSmall,
}

class MyText extends StatelessWidget {

  final TextTypes type;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const MyText({super.key, required this.type, required this.text, this.fontSize, this.fontWeight, this.color = OtherColors.black, this.textAlign = TextAlign.start, this.overflow});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case TextTypes.h1:
        return mainText(text,textAlign,FontFamilies.urbanist,fontSize ?? Sizes.s48,fontWeight ?? FontWeights.bold,color,overflow);
      case TextTypes.h2:
        return mainText(text,textAlign,FontFamilies.urbanist,fontSize ?? Sizes.s40,fontWeight ?? FontWeights.bold,color,overflow);
      case TextTypes.h3:
        return mainText(text,textAlign,FontFamilies.urbanist,fontSize ?? Sizes.s32,fontWeight ?? FontWeights.bold,color,overflow);
      case TextTypes.h4:
        return mainText(text,textAlign,FontFamilies.urbanist,fontSize ?? Sizes.s24,fontWeight ?? FontWeights.bold,color,overflow);
      case TextTypes.h5:
        return mainText(text,textAlign,FontFamilies.urbanist,fontSize ?? Sizes.s20,fontWeight ?? FontWeights.bold,color,overflow);
      case TextTypes.h6:
        return mainText(text,textAlign,FontFamilies.urbanist,fontSize ?? Sizes.s18,fontWeight ?? FontWeights.bold,color,overflow);
      case TextTypes.bodyXLarge:
        return mainText(text,textAlign,FontFamilies.urbanist,fontSize ?? Sizes.s18,fontWeight ?? FontWeights.regular,color,overflow);
      case TextTypes.bodyLarge:
        return mainText(text,textAlign,FontFamilies.urbanist,fontSize ?? Sizes.s16,fontWeight ?? FontWeights.regular,color,overflow);
      case TextTypes.bodyMedium:
        return mainText(text,textAlign,FontFamilies.urbanist,fontSize ?? Sizes.s14,fontWeight ?? FontWeights.regular,color,overflow);
      case TextTypes.bodySmall:
        return mainText(text,textAlign,FontFamilies.urbanist,fontSize ?? Sizes.s12,fontWeight ?? FontWeights.regular,color,overflow);
      case TextTypes.bodyXSmall:
        return mainText(text,textAlign,FontFamilies.urbanist,fontSize ?? Sizes.s10,fontWeight ?? FontWeights.regular,color,overflow);
      default:
        return const SizedBox();
    }
  }

  Widget mainText(String text,TextAlign? textAlign,String fontFamily,double fontSize,FontWeight fontWeight,Color? color,TextOverflow? overflow){
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
        color: color,
      ),
      overflow: overflow,
    );
  }
}
