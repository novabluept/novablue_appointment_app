
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_image_network.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_supabase.dart';
import 'package:novablue_appointment_app/src/routing/app_routing.dart';

class BookAppointmentWorkersListCard extends StatelessWidget {

  final String shopId;
  final String shopName;
  final UserSupabase worker;

  const BookAppointmentWorkersListCard({super.key, required this.shopId, required String this.shopName, required this.worker});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.goNamed(
          AppRoute.shopWorkerServices.name,
          pathParameters: {
            'shopId': shopId,
            'workerId': worker.id
          },
          extra: {
            'shopName': shopName,
          }
        );
      },
      child: SizedBox(
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
                      SizedBox(
                        child: MyImageNetwork(
                          url: worker.userImageUrl!,
                          width: Sizes.s110.h,
                          height: Sizes.s110.h,
                          borderRadius: BorderRadius.all(Radius.circular(Sizes.s16.r)),
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
                                text: '${worker.firstname} ${worker.lastname}',
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
                                    text: 'Placeholder',
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
                                    text: shopName,
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
      ),
    );
  }
}
