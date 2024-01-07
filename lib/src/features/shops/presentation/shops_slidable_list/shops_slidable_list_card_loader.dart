
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_shimmer.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';

class ShopsSlidableListCardLoader extends StatelessWidget {
  const ShopsSlidableListCardLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.s331.w,
      height: Sizes.s350.h,
      decoration: BoxDecoration(
        color: GreyScaleColors.grey50,
        borderRadius: BorderRadius.all(Radius.circular(Sizes.s10.r))
      ),
      margin: EdgeInsets.symmetric(horizontal: Sizes.s6.w),
      child: Column(
        children: [
          MyShimmer(
            child: Container(
              height: Sizes.s175.h,
              decoration: BoxDecoration(
                color: OtherColors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Sizes.s10.r),topRight: Radius.circular(Sizes.s10.r)),
              ),
            ),
          ),
          Container(
            height: Sizes.s175.h,
            padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w,vertical: Sizes.s16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Sizes.s10.r),bottomRight: Radius.circular(Sizes.s10.r)),
            ),
            child: Column(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      SizedBox(
                        width: Sizes.s45.w,
                        height: Sizes.s45.w,
                      ),
                      gapW8,
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: MyShimmer(
                                child: Container(
                                  width: Sizes.s71.w,
                                  height: Sizes.s10.h,
                                  decoration: BoxDecoration(
                                    color: OtherColors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(Sizes.s10.r)),
                                  ),
                                ),
                              ),
                            ),
                            gapH8,
                            MyShimmer(
                              child: Container(
                                width: Sizes.s100.w,
                                height: Sizes.s10.h,
                                decoration: BoxDecoration(
                                  color: OtherColors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(Sizes.s10.r)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                gapH8,
                MyShimmer(
                  child: Container(
                    width: double.infinity,
                    height: Sizes.s60.h,
                    decoration: BoxDecoration(
                      color: OtherColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(Sizes.s16.r)),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
