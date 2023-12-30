
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';

class CreatePersonalDataScreenController extends StateNotifier<AsyncValue<File?>>{

  final SupabaseAuthRepository authRepository;

  CreatePersonalDataScreenController({required this.authRepository}) : super(const AsyncValue<File?>.data(null));

  Future<void> chooseProfilePicture() async {
    state = const AsyncLoading();
    final value = await AsyncValue.guard(() => authRepository.chooseProfileImage());
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = AsyncData(value.value);
    }
  }
}

final createPersonalDataScreenControllerProvider = StateNotifierProvider.autoDispose<CreatePersonalDataScreenController,AsyncValue<File?>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return CreatePersonalDataScreenController(authRepository: authRepository);
});