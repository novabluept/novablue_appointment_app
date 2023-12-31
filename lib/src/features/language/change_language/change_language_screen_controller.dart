
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/constants/app_duration.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:novablue_appointment_app/src/localization/app_locale_notifier.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';

class ChangeLanguageScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  ChangeLanguageScreenController({required this.authRepository}) : super(const AsyncValue<void>.data(null));

  Future<void> changeLanguage({
    required WidgetRef ref,
    required Object locale,
    required void Function() onSuccess,
  }) async {
    state = const AsyncValue<void>.loading();
    final newValue = locale as Locale;
    final savedValue = newValue.languageCode == SupportedLocale.pt.countryCode ? SupportedLocale.pt : SupportedLocale.en;
    ref.read(localeProvider.notifier).changeLanguage(savedValue);
    if(mounted){
      await Future.delayed(Duration(milliseconds: fakeAsyncDelayMilliseconds));
      state = AsyncValue<void>.data(null);
      if(!state.hasError){
        onSuccess();
      }
    }
  }
}

final changeLanguageScreenControllerProvider = StateNotifierProvider.autoDispose<ChangeLanguageScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return ChangeLanguageScreenController(authRepository: authRepository);
});