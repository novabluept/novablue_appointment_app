
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';

class ChangeLanguageCard extends StatelessWidget {

  final SupportedLocale language;
  final Locale? selectedValue;
  final Function(dynamic)? onChanged;

  const ChangeLanguageCard({super.key, required this.language,required this.selectedValue,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.s80.h,
      decoration: BoxDecoration(
        color: GreyScaleColors.grey50,
        borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: Center(
        child: ListTile(
          title: Row(
            children: [
              MyText(
                type: TextTypes.bodyMedium,
                fontWeight: FontWeights.semiBold,
                text: Locale(language.countryCode) == Locale(SupportedLocale.pt.countryCode) ? SupportedLocale.pt.icon : SupportedLocale.en.icon,
              ),
              gapW12,
              MyText(
                type: TextTypes.bodyMedium,
                fontWeight: FontWeights.semiBold,
                text: Locale(language.countryCode) == Locale(SupportedLocale.pt.countryCode) ? context.loc.portuguese.capitalize() : context.loc.english.capitalize(),
              )
            ],
          ),
          trailing: Radio(
            value: Locale(language.countryCode),
            groupValue: selectedValue,
            activeColor: MainColors.primary,
            fillColor: MaterialStateProperty.all(MainColors.primary),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
