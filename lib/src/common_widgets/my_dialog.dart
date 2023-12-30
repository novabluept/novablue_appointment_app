
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_blur_filter.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'my_button.dart';

enum DialogTypes {
  success,
  error
}

class MyDialog extends StatelessWidget {

  final DialogTypes type;
  final String label;
  final Function() positiveButtonOnPressed;

  const MyDialog({super.key, required this.type, required this.label, required this.positiveButtonOnPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyBlurFilter(),
        PopScope(
          canPop: false,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Sizes.s45.w),
                  padding: EdgeInsets.all(Sizes.s24.w),
                  decoration: BoxDecoration(
                    color: OtherColors.white,
                    borderRadius: BorderRadius.all(const Radius.circular(Sizes.s48).r),
                  ),
                  child: Material(
                    child: Column(
                      children: [
                        SvgPicture.asset(type == DialogTypes.success ? 'images/main/success_image.svg' : 'images/main/failure_image.svg',width: Sizes.s180.w,height: Sizes.s185.h),
                        SizedBox(height: Sizes.s32.h),
                        MyText(
                          type: TextTypes.h4,
                          text: type == DialogTypes.success ? context.loc.successMessage.capitalize() : context.loc.errorMessage.capitalize(),
                        ),
                        gapH16,
                        MyText(
                          type: TextTypes.bodyLarge,
                          text: label,
                          textAlign: TextAlign.center,
                        ),
                        gapH32,
                        MyButton(
                            type: ButtonTypes.filledFullyRounded,
                            text: context.loc.ok.capitalize(),
                            onPressed: positiveButtonOnPressed
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Future<void> showAlertDialog({barrierDismissible = false,required BuildContext context,required DialogTypes type,required String label,required Function() positiveButtonOnPressed}) async {
  showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) {
      return MyDialog(
        type: type,
        label: label,
        positiveButtonOnPressed: positiveButtonOnPressed,
      );
    },
  );
}