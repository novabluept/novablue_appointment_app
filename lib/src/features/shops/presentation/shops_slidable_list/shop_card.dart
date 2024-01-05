
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/shops/domain/shop_supabase.dart';

class ShopCard extends StatelessWidget {

  final ShopSupabase shop;
  final Function(Object?)? onTap;

  const ShopCard({super.key,required this.shop,this.onTap});

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
          ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(Sizes.s10.r),topRight: Radius.circular(Sizes.s10.r)),
            child: Image.network(
              width: double.infinity,
              height: Sizes.s175.h,
              'https://cdn11.bigcommerce.com/s-h7l2pcerei/product_images/uploaded_images/ssb-lakeview-2.jpg',
              fit: BoxFit.cover
            )
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(Sizes.s10.r)),
                          child: Image.network(
                            width: double.infinity,
                            height: Sizes.s175.h,
                            'https://img.freepik.com/premium-vector/barbershop-logo-design_304830-106.jpg?w=740',
                            fit: BoxFit.fitWidth
                          )
                        ),
                      ),
                      gapW8,
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: MyText(
                                type: TextTypes.bodyLarge,
                                fontWeight: FontWeights.bold,
                                text: shop.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  IconlyBold.location,
                                  size: Sizes.s12.w,
                                  color: MainColors.primary
                                ),
                                gapW4,
                                MyText(
                                  type: TextTypes.bodySmall,
                                  text: shop.state,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                gapH8,
                Flexible(
                  child: MyButton(
                    type: ButtonTypes.filledRounded,
                    text: 'Book now',
                    onPressed: (){}
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}