
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';

class PasswordRecoveryScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  PasswordRecoveryScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));

  Future<void> updatePassword({
    required String password,
    required void Function() onSuccess,
  }) async {
    state = const AsyncValue<void>.loading();
    final newState = await AsyncValue.guard(() => authRepository.updatePassword(
      password: password,
    ));
    if(mounted){
      state = newState;
      if(!state.hasError){
        onSuccess();
      }
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue<void>.loading();
    final newState = await AsyncValue.guard(() => authRepository.signOut());
    if(mounted){
      state = newState;
    }
  }
}

final passwordRecoveryScreenControllerProvider = StateNotifierProvider.autoDispose<PasswordRecoveryScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return PasswordRecoveryScreenController(authRepository: authRepository);
});