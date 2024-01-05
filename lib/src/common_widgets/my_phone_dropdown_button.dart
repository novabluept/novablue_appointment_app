
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'my_text.dart';

class CountryCode {
  final String code;
  final String icon;

  const CountryCode({required this.code,required this.icon});
}

class PhoneCountryCode {
  static const pt = CountryCode(code: '+351',icon: '🇵🇹');
  static const fr = CountryCode(code: '+33',icon: '🇫🇷');
  static const es = CountryCode(code: '+34',icon: '🇪🇸');
}

class MyPhoneDropdownButton extends StatelessWidget {

  final CountryCode value;
  final String valueTextIcon;
  final Widget? icon;
  final Function()? onTapPt;
  final Function()? onTapEs;
  final Function()? onTapFr;

  MyPhoneDropdownButton({super.key,required this.value,required this.valueTextIcon,this.icon,required this.onTapPt,required this.onTapEs,required this.onTapFr});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          child: MyText(
            type: TextTypes.bodyMedium,
            fontWeight: FontWeights.semiBold,
            text: valueTextIcon,
          ),
          onTapDown: (TapDownDetails details) {
            var offset = details.globalPosition;
            double right = offset.dx;
            double top = offset.dy;
            context.showPopupMenu(
              context: context,
              position: RelativeRect.fromLTRB(Sizes.s24.w, top, right, Sizes.s0),
              items: [
                PopupMenuItem(
                  value: 1,
                  height: kMinInteractiveDimension.h,
                  padding: EdgeInsets.symmetric(horizontal: Sizes.s12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MyText(
                        type: TextTypes.bodyMedium,
                        fontWeight: FontWeights.semiBold,
                        text: PhoneCountryCode.pt.icon,
                      ),
                      gapW4,
                      MyText(
                        type: TextTypes.bodyMedium,
                        fontWeight: FontWeights.semiBold,
                        text: PhoneCountryCode.pt.code,
                      ),
                    ],
                  ),
                  onTap: onTapPt,
                ),
                PopupMenuItem(
                  value: 2,
                  height: kMinInteractiveDimension.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MyText(
                        type: TextTypes.bodyMedium,
                        fontWeight: FontWeights.semiBold,
                        text: PhoneCountryCode.es.icon,
                      ),
                      gapW4,
                      MyText(
                        type: TextTypes.bodyMedium,
                        fontWeight: FontWeights.semiBold,
                        text: PhoneCountryCode.es.code,
                      ),
                    ],
                  ),
                  onTap: onTapEs,
                ),
                PopupMenuItem(
                  value: 3,
                  height: kMinInteractiveDimension.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MyText(
                        type: TextTypes.bodyMedium,
                        fontWeight: FontWeights.semiBold,
                        text: PhoneCountryCode.fr.icon,
                      ),
                      gapW4,
                      MyText(
                        type: TextTypes.bodyMedium,
                        fontWeight: FontWeights.semiBold,
                        text: PhoneCountryCode.fr.code,
                      ),
                    ],
                  ),
                  onTap: onTapFr,
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
