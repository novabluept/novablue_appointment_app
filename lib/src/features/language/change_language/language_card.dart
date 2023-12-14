
import 'package:flutter/material.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';

class LanguageCard extends StatefulWidget {

  final SupportedLocale item;
  final Locale? selectedValue;
  final Locale language;
  final Function(dynamic)? onChanged;

  const LanguageCard({super.key, required this.item,required this.selectedValue, required this.language,required this.onChanged});

  @override
  State<LanguageCard> createState() => _LanguageCardState();
}

class _LanguageCardState extends State<LanguageCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: MyText(
        type: TextTypes.bodyXLarge,
        fontWeight: FontWeights.semiBold,
        text: widget.language == Locale(SupportedLocale.pt.countryCode) ? widget.item.namePt : widget.item.nameEn,
      ),
      trailing: Radio(
        value: Locale(widget.item.countryCode),
        groupValue: widget.selectedValue,
        activeColor: MainColors.primary,
        fillColor: MaterialStateProperty.all(MainColors.primary),
        onChanged: widget.onChanged,
      ),
    );
  }
}
