import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import 'package:iconly/iconly.dart';

import 'my_text.dart';

class TextFormFieldTextStyles {
  static var main = TextStyle(fontFamily: FontFamilies.urbanist, fontSize: Sizes.s14.sp, fontWeight: FontWeights.medium,color: OtherColors.black);
  static var placeHolder = TextStyle(fontFamily: FontFamilies.urbanist, fontSize: Sizes.s14.sp, fontWeight: FontWeights.medium,color: GreyScaleColors.grey500);
  static var error = TextStyle(fontFamily: FontFamilies.urbanist, fontSize: Sizes.s0.sp,color: MainColors.primary,height: 0);
}

class TextFormFieldBorderStyles {
  static var disabled = OutlineInputBorder(borderSide: BorderSide(color: GreyScaleColors.grey50, width: Sizes.s1.w),borderRadius: BorderRadius.circular(Sizes.s16).r);
  static var info = OutlineInputBorder(borderSide: BorderSide(color: MainColors.primary, width: Sizes.s1.w),borderRadius: BorderRadius.circular(Sizes.s16).r);
  static var error = OutlineInputBorder(borderSide: BorderSide(color: OtherColors.red, width: Sizes.s1.w),borderRadius: BorderRadius.circular(Sizes.s16).r);
}

class TextFormFieldCustomCharacter {
  static const circle = '●';
}

class MyTextFormField extends StatelessWidget {

  final TextEditingController textEditingController;
  final String text;
  final String? errorText;
  final Widget? prefixWidget; // used mainly for phone textformfield
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function()? onSuffixIconTap;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final bool fieldHasError;
  final bool isFieldFocused;
  final bool isTextObscure;
  final Function(bool) onFocusChange;
  final String? Function(String?)? validator;

  const MyTextFormField({super.key,required this.textEditingController, required this.text, this.errorText,this.prefixWidget,this.prefixIcon,this.suffixIcon,this.onSuffixIconTap,
    this.contentPaddingHorizontal = Sizes.s20, this.contentPaddingVertical = Sizes.s20,
    required this.fieldHasError, required this.isFieldFocused, this.isTextObscure = false,required this.onFocusChange, this.validator});

  @override
  Widget build(BuildContext context) {
    return mainTextFormField();
  }

  Color _iconColor(){
    if(isFieldFocused){
      return MainColors.primary;
    }else if(fieldHasError){
      return OtherColors.red;
    }
    return GreyScaleColors.grey500;
  }

  Widget? _prefixIcon(){

    if(prefixIcon != null){
      return Padding(padding: EdgeInsets.only(left: Sizes.s20.w,right: Sizes.s12.w),child: Icon(prefixIcon,size: Sizes.s20.w,color: _iconColor()));
    }

    if(prefixWidget != null){
      return Padding(
        padding: EdgeInsets.only(left: Sizes.s20.w,right: Sizes.s12.w),
        child: prefixWidget
      );
    }

    return null;
  }

  Widget? _suffixIcon(){

    if(suffixIcon != null){
      return Padding(padding: EdgeInsets.only(right: Sizes.s20.w),child: GestureDetector(onTap: onSuffixIconTap,child: Icon(suffixIcon,size: Sizes.s20.w,color: _iconColor())));
    }

    return null;
  }

  Widget mainTextFormField(){
    return Column(
      children: [
        Focus(
          onFocusChange: onFocusChange,
          child: TextFormField(
            //readOnly: true ? true : false,
            controller: textEditingController,
            cursorColor: MainColors.primary,
            style: TextFormFieldTextStyles.main,
            obscureText: isTextObscure,
            obscuringCharacter: TextFormFieldCustomCharacter.circle,
            //onTap: isDate ? showDateDialog : null,
            decoration: InputDecoration(
              fillColor: isFieldFocused ? BackgroundColors.blue : GreyScaleColors.grey100,
              filled: true,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: contentPaddingVertical!.h),
              prefixIcon: _prefixIcon(),
              suffixIcon: _suffixIcon(),
              hintText: text,
              focusColor: Colors.green,
              errorStyle: TextFormFieldTextStyles.error,
              hintStyle: TextFormFieldTextStyles.placeHolder,
              enabledBorder: TextFormFieldBorderStyles.disabled,
              focusedBorder: TextFormFieldBorderStyles.info,
              focusedErrorBorder: TextFormFieldBorderStyles.info,
              errorBorder: TextFormFieldBorderStyles.error,
            ),
            validator: validator,
          ),
        ),
        fieldHasError == true ? Row(
          children: [
            Icon(IconlyBold.danger,size: Sizes.s14.w,color: OtherColors.red),
            gapW8,
            MyText(
              type: TextTypes.bodyMedium,
              fontWeight: FontWeights.medium,
              color: OtherColors.red,
              text: errorText ?? '',
            ),
          ],
        ) : Container()
      ],
    );
  }


}
