
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';
import 'package:novablue_appointment_app/src/utils/shared_prefrences.dart';
import 'change_language_screen_controller.dart';
import 'language_card.dart';

class LanguagesGrid extends ConsumerStatefulWidget {

  final List<SupportedLocale> items;
  final Locale selectedValue;

  const LanguagesGrid({super.key, required this.items, required this.selectedValue});

  @override
  _LanguagesGridState createState() => _LanguagesGridState();
}

class _LanguagesGridState extends ConsumerState<LanguagesGrid> {

  @override
  Widget build(BuildContext context) {
    var language = AppSharedPreference.getLocale();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return LanguageCard(
          item: widget.items[index],
          selectedValue: widget.selectedValue,
          language: language,
          onChanged: (value) {
            ref.read(changeLanguageScreenControllerProvider.notifier).changeLanguage(ref,value);
            context.pop();
          },
        );
      },
    );
  }
}