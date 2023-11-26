
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import '../localization/app_supported_locale.dart';
import 'package:flutter/material.dart';

class AppSharedPreference {
  static SharedPreferences? sharedPreference; // Use "?" to indicate it can be null

  static const localKey = 'locale';

  static Future<void> init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static void saveLocale(SupportedLocale locale) {
    if (sharedPreference != null) {
      sharedPreference!.setString(localKey, locale.countryCode);
    } else {
      debugPrint('SharedPreferences not initialized. Call init() first.');
    }
  }

  static Locale getLocale() {
    if (sharedPreference != null) {
      final String localeCode = sharedPreference!.getString(localKey) ?? SupportedLocale.pt.countryCode;
      if (localeCode.isEmpty) {
        throw Exception('Locale not found');
      }
      return Locale(localeCode);
    } else {
      debugPrint('SharedPreferences not initialized. Call init() first.');
      throw Exception('SharedPreferences not initialized');
    }
  }
}
