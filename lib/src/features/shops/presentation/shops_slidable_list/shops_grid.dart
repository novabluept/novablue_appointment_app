
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/shops/data/shops_repository.dart';
import 'package:novablue_appointment_app/src/features/shops/presentation/shops_slidable_list/shop_card.dart';

import 'browse_shops_card.dart';

class ShopsGrid extends ConsumerStatefulWidget {

  const ShopsGrid({super.key});

  @override
  _ShopsGridState createState() => _ShopsGridState();
}

class _ShopsGridState extends ConsumerState<ShopsGrid> {

  @override
  Widget build(BuildContext context) {

    //final language = AppSharedPreference.getLocale();
    final shopsListValue = ref.watch(getShopsProvider);

    return shopsListValue.when(
      data: (shops) => shops.isEmpty
      ? Text('empty')
      :
      SizedBox(
        height: Sizes.s350.h,
        child: ListView.builder(
          itemCount: shops.length + 1,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: Sizes.s12.w),
          itemBuilder: (context,index) {
            final shop = index != shops.length ? shops[index] : null;
            return index != shops.length ?
              ShopCard(
                shop: shop!
              ) :
              BrowseShopsCard();
          },
        )
      ),
      error: (e, st) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }
}