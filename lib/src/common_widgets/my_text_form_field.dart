import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import 'package:iconly/iconly.dart';

class TextFormFieldTextStyles {
  static var main = TextStyle(fontFamily: FontFamilies.urbanist, fontSize: Sizes.s14.sp, fontWeight: FontWeights.medium,color: OtherColors.black);
  static var placeHolder = TextStyle(fontFamily: FontFamilies.urbanist, fontSize: Sizes.s14.sp, fontWeight: FontWeights.medium,color: GreyScaleColors.grey500);
  static var error = TextStyle(fontFamily: FontFamilies.urbanist, fontSize: Sizes.s0.sp, fontWeight: FontWeights.medium,color: OtherColors.red);
}

class TextFormFieldBorderStyles {
  static var disabled = OutlineInputBorder(borderSide: BorderSide(color: GreyScaleColors.grey50, width: Sizes.s1.w),borderRadius: BorderRadius.circular(Sizes.s16).r);
  static var info = OutlineInputBorder(borderSide: BorderSide(color: MainColors.primary, width: Sizes.s1.w),borderRadius: BorderRadius.circular(Sizes.s16).r);
  static var error = OutlineInputBorder(borderSide: BorderSide(color: OtherColors.black, width: Sizes.s1.w),borderRadius: BorderRadius.circular(Sizes.s16).r);
}

class MyTextFormField extends StatelessWidget {

  final String text;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final bool hasError;
  final bool isFieldFocused;
  final String? Function(String?)? validator;

  const MyTextFormField({super.key, required this.text, this.contentPaddingHorizontal = Sizes.s20, this.contentPaddingVertical = Sizes.s18, required this.hasError, required this.isFieldFocused, this.validator});

  @override
  Widget build(BuildContext context) {
    return generalTextFormField();
  }

  Widget generalTextFormField(){

    return Column(
      children: [
        TextFormField(
          //readOnly: true ? true : false,
          controller: TextEditingController(),
          cursorColor: MainColors.primary,
          style: TextFormFieldTextStyles.main,
          //obscureText: showObscureText,
          obscuringCharacter: '●',
          //onTap: isDate ? showDateDialog : null,
          decoration: InputDecoration(
            fillColor: isFieldFocused ? MainColors.primary : GreyScaleColors.grey50,
            filled: true,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: contentPaddingHorizontal!.w,vertical: contentPaddingVertical!.h),
            //prefixIcon: prefixIcon != null ? Icon(prefixIcon,size: 20.sp,color: GreyScaleColors.grey500) : null,
            //suffixIcon: _suffixIcon(),
            hintText: 'label',
            hintStyle: TextFormFieldTextStyles.placeHolder,
            errorStyle: TextFormFieldTextStyles.error,
            enabledBorder: TextFormFieldBorderStyles.disabled,
            focusColor: OtherColors.red,
            focusedBorder: TextFormFieldBorderStyles.info,
            focusedErrorBorder: TextFormFieldBorderStyles.info,
            errorBorder: TextFormFieldBorderStyles.error,
          ),
          validator: validator,
        ),
        hasError == true ? Row(
          children: [
            Icon(IconlyBold.danger,size: 14.sp,color: OtherColors.red),
            SizedBox(width: 8.w),
            const MyText(
              type: TextTypes.bodyMedium,
              fontWeight: FontWeights.medium,
              color: OtherColors.red,
              text: 'Error message',
            ),
          ],
        ) : Container()
      ],
    );
  }


}
