
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/localization/app_locale_notifier.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/utils/shared_prefrences.dart';

class ChangeLanguageDropdown extends ConsumerStatefulWidget {
  const ChangeLanguageDropdown({super.key});

  @override
  _ChangeLanguageDropdownState createState() => _ChangeLanguageDropdownState();
}

class _ChangeLanguageDropdownState extends ConsumerState<ChangeLanguageDropdown> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          MyText(
            type: TextTypes.bodyMedium,
            fontWeight: FontWeights.semiBold,
            text: AppSharedPreference.getLocale() == Locale(SupportedLocale.pt.countryCode) ? SupportedLocale.pt.icon : SupportedLocale.en.icon,
          ),
          gapW4,
          Icon(IconlyBold.arrow_down_2,size: Sizes.s12.w,color: GreyScaleColors.grey500)
        ],
      ),
      onTapDown: (TapDownDetails details) {
        var offset = details.globalPosition;
        double left = offset.dx;
        double top = offset.dy;
        context.showPopupMenu(
          context: context,
          position: RelativeRect.fromLTRB(left, top, Sizes.s28.w, 0),
          items: [
            PopupMenuItem(
              value: 1,
              height: kMinInteractiveDimension.h,
              padding: EdgeInsets.symmetric(horizontal: Sizes.s12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  MyText(
                    type: TextTypes.bodyMedium,
                    fontWeight: FontWeights.semiBold,
                    text: SupportedLocale.pt.icon,
                  ),
                  gapW4,
                  MyText(
                    type: TextTypes.bodyMedium,
                    fontWeight: FontWeights.semiBold,
                    text: context.loc.portuguese.capitalize(),
                  ),
                ],
              ),
              onTap: (){
                ref.read(localeProvider.notifier).changeLanguage(SupportedLocale.pt);
              },
            ),
            PopupMenuItem(
              value: 2,
              height: kMinInteractiveDimension.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  MyText(
                    type: TextTypes.bodyMedium,
                    fontWeight: FontWeights.semiBold,
                    text: SupportedLocale.en.icon,
                  ),
                  gapW4,
                  MyText(
                    type: TextTypes.bodyMedium,
                    fontWeight: FontWeights.semiBold,
                    text: context.loc.english.capitalize(),
                  ),
                ],
              ),
              onTap: (){
                ref.read(localeProvider.notifier).changeLanguage(SupportedLocale.en);
              },
            ),
          ],
        );
      },
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return MyDropdownButton<SupportedLocale>(
      items: SupportedLocale.values,
      icon: Row(
        children: [
          SvgPicture.asset(
            AppSharedPreference.getLocale() == Locale(SupportedLocale.pt.countryCode) ? 'images/flags/portugal.svg' : 'images/flags/united_kingdom.svg',
            width: Sizes.s24.w,
            height: Sizes.s18.h
          ),
          gapW4,
          Icon(IconlyBold.arrow_down_2,size: Sizes.s12.w,color: GreyScaleColors.grey500)
        ],
      ),
      dropDownMenuItem: SupportedLocale.values.map<DropdownMenuItem<SupportedLocale>>((e) => DropdownMenuItem<SupportedLocale>(
        value: e,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SvgPicture.asset(e.path,width: Sizes.s24.w,height: Sizes.s18.h),
            gapW4,
            MyText(
              type: TextTypes.bodyMedium,
              fontWeight: FontWeights.semiBold,
              text: e.nameEn == SupportedLocale.pt.nameEn ? context.loc.portuguese.capitalize() : context.loc.english.capitalize(),
            ),
          ],
        ),
      )).toList(),
      onChanged: (SupportedLocale? value) {
        setState(() {
          ref.read(localeProvider.notifier).changeLanguage(value ?? SupportedLocale.pt);
        });
      },
    );
  }*/
}
