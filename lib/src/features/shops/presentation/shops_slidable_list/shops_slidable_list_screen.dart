
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
    /*return MyScaffold(
      state: state,
      edgeInsets: EdgeInsets.zero,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Sizes.s350.h,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: Sizes.s12.w),
              itemBuilder: (context,index) => Container(
                width: Sizes.s331.w,
                height: Sizes.s350.h,
                decoration: BoxDecoration(
                  color: GreyScaleColors.grey300,
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
                                Container(
                                  width: Sizes.s45.w,
                                  height: Sizes.s45.w,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(Radius.circular(Sizes.s10.r))),
                                ),
                              ],
                            ),
                          ),
                          gapH8,
                          Flexible(child: MyButton(type: ButtonTypes.filledRounded, onPressed: (){}))
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
          gapH24
        ],
      )
    );
  }*/
}