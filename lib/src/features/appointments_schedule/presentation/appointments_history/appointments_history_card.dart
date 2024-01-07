
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';

class AppointmentsHistoryCard extends StatelessWidget {

  const AppointmentsHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Sizes.s140.w,
      child: Container(
        padding: EdgeInsets.all(Sizes.s16.w),
        decoration: BoxDecoration(
          color: GreyScaleColors.grey50,
          borderRadius: BorderRadius.all(const Radius.circular(Sizes.s24).r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Sizes.s16.r),
                    child: Image.asset(
                      'images/main/girl.png',
                      width: Sizes.s110.w,
                      height: Sizes.s110.w,
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
                          Row(
                            children: [
                              Icon(
                                IconlyBold.category,
                                size: Sizes.s12.w,
                                color: MainColors.primary,
                              ),
                              gapW4,
                              MyText(
                                type: TextTypes.bodySmall,
                                fontWeight: FontWeights.medium,
                                text: 'Voice Call',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                IconlyBold.calendar,
                                size: Sizes.s12.w,
                                color: MainColors.primary,
                              ),
                              gapW4,
                              MyText(
                                type: TextTypes.bodySmall,
                                fontWeight: FontWeights.medium,
                                text: 'Nov 20, 2023 | 16:00 PM',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                child: Icon(IconlyLight.more_circle,size: Sizes.s24.w),
                onTapDown: (TapDownDetails details) {
                  var offset = details.globalPosition;
                  double left = offset.dx;
                  double top = offset.dy;
                  context.showPopupMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(left, top, Sizes.s24.w, Sizes.s0),
                    items: [
                      PopupMenuItem(
                        value: 1,
                        height: kMinInteractiveDimension.h,
                        padding: EdgeInsets.symmetric(horizontal: Sizes.s12.w),
                        child: Row(
                          children: [
                            Icon(IconlyLight.document, size: Sizes.s12.w, color: OtherColors.black),
                            gapW8,
                            MyText(
                              type: TextTypes.bodySmall,
                              fontWeight: FontWeights.medium,
                              text: 'Details',
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        height: kMinInteractiveDimension.h,
                        child: Row(
                          children: [
                            Icon(IconlyLight.edit_square, size: Sizes.s12.w, color: OtherColors.black),
                            gapW8,
                            MyText(
                              type: TextTypes.bodySmall,
                              fontWeight: FontWeights.medium,
                              text: 'Edit',
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        height: kMinInteractiveDimension.h,
                        child: Row(
                          children: [
                            Icon(IconlyLight.delete, size: Sizes.s12.w, color: OtherColors.red),
                            gapW8,
                            MyText(
                              type: TextTypes.bodySmall,
                              fontWeight: FontWeights.medium,
                              text: 'Delete',
                              color: OtherColors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        )
      ),
    );
  }
}

