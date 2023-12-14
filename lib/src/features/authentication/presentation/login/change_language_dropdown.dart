
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_dropdown_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novablue_appointment_app/src/localization/app_locale_notifier.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';
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
  }
}
