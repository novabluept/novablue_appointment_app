
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookAppointmentWorkerServicesCard extends StatelessWidget {
  const BookAppointmentWorkerServicesCard({super.key});

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
                              text: 'Simão Bessa',
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
                                  text: 'Cabeleireiro e Estetica',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  IconlyBold.location,
                                  size: Sizes.s12.w,
                                  color: MainColors.primary,
                                ),
                                gapW4,
                                MyText(
                                  type: TextTypes.bodySmall,
                                  fontWeight: FontWeights.medium,
                                  text: 'Porta 54',
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
            ],
          )
      ),
    );
  }
}
