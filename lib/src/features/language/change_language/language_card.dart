
import 'package:flutter/material.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';

class LanguageCard extends StatelessWidget {

  final SupportedLocale language;
  final Locale? selectedValue;
  final Function(dynamic)? onChanged;

  const LanguageCard({super.key, required this.language,required this.selectedValue,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: MyText(
        type: TextTypes.bodyXLarge,
        fontWeight: FontWeights.semiBold,
        text: Locale(language.countryCode) == Locale(SupportedLocale.pt.countryCode) ? context.loc.portuguese.capitalize() : context.loc.english.capitalize(),
      ),
      trailing: Radio(
        value: Locale(language.countryCode),
        groupValue: selectedValue,
        activeColor: MainColors.primary,
        fillColor: MaterialStateProperty.all(MainColors.primary),
        onChanged: onChanged,
      ),
    );
  }
}
