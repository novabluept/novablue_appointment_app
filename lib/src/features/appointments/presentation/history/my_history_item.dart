
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../../common_widgets/my_text.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHistoryItem extends StatelessWidget {

  const MyHistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 142.w,
      child: Container(
        padding: EdgeInsets.all(Sizes.s16.w),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(const Radius.circular(Sizes.s24).r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: Sizes.s110.w,
                    height: Sizes.s110.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(const Radius.circular(Sizes.s24).r),
                    ),
                  ),
                  gapW16,
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Sizes.s11.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            type: TextTypes.h6,
                            text: 'Dr. Raul Zirkind',
                            overflow: TextOverflow.ellipsis,
                          ),
                          MyText(
                            type: TextTypes.bodySmall,
                            fontWeight: FontWeights.medium,
                            text: 'Voice Call',
                            overflow: TextOverflow.ellipsis,
                          ),
                          MyText(
                            type: TextTypes.bodySmall,
                            fontWeight: FontWeights.medium,
                            text: 'Nov 20, 2023 | 16:00PM',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Icon(IconlyLight.more_circle,size: Sizes.s24.w,)
            )
          ],
        )
      ),
    );
  }
}
