
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/shops/data/shops_repository.dart';
import 'package:novablue_appointment_app/src/features/shops/presentation/shops_slidable_list/shops_slidable_list_card.dart';
import 'package:novablue_appointment_app/src/features/shops/presentation/shops_slidable_list/shops_slidable_list_card_loader.dart';
import 'shops_slidable_list_browse_card.dart';

class ShopsSlidableListGrid extends ConsumerStatefulWidget {

  const ShopsSlidableListGrid({super.key});

  @override
  _ShopsSlidableListGridState createState() => _ShopsSlidableListGridState();
}

class _ShopsSlidableListGridState extends ConsumerState<ShopsSlidableListGrid> {

  @override
  Widget build(BuildContext context) {

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
              ShopsSlidableListCard(
                shop: shop!
              ) :
              ShopsSlidableListBrowseCard();
          },
        )
      ),
      error: (e, st) => const SizedBox(),
      loading: () => SizedBox(
        height: Sizes.s350.h,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: Sizes.s12.w),
          itemBuilder: (context,index) {
            return ShopsSlidableListCardLoader();
          },
        )
      ),
    );
  }
}