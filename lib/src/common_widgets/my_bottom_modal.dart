
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'my_blur_filter.dart';
import 'my_button.dart';
import 'my_divider.dart';
import 'my_text.dart';

class MyBottomModal extends StatelessWidget {

  final String title;
  final Color titleColor;
  final Widget content;
  final String negativeButtonTitle;
  final Function() negativeButtonOnPressed;
  final String positiveButtonTitle;
  final Function() positiveButtonOnPressed;

  const MyBottomModal({super.key, required this.title, this.titleColor = OtherColors.black, required this.content, required this.negativeButtonTitle, required this.negativeButtonOnPressed, required this.positiveButtonTitle, required this.positiveButtonOnPressed,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyBlurFilter(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: 24.w,top: 12.h,right: 24.w,bottom: 48.h),
              decoration: BoxDecoration(
                color: OtherColors.white,
                borderRadius: BorderRadius.only(topLeft: const Radius.circular(48).r,topRight: const Radius.circular(48).r),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: GreyScaleColors.grey300,
                        borderRadius: BorderRadius.only(topLeft: const Radius.circular(48).r,topRight: const Radius.circular(48).r),
                      ),
                    ),
                  ),
                  gapH24,
                  Column(
                    children: [
                      MyText(
                        type: TextTypes.h4,
                        text: title,
                        color: titleColor,
                      ),
                      gapH24,
                      MyDivider(),
                      gapH24,
                      content,
                      gapH48,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: MyButton(
                              type: ButtonTypes.filledFullyRounded,
                              backgroundColor: BackgroundColors.blue,
                              foregroundColor: MainColors.primary,
                              text: negativeButtonTitle,
                              onPressed: negativeButtonOnPressed
                            ),
                          ),
                          gapW12,
                          Expanded(
                            child: MyButton(
                              type: ButtonTypes.filledFullyRounded,
                              text: positiveButtonTitle,
                              onPressed: positiveButtonOnPressed
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
