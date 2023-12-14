
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';


class EmailConfirmationScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  EmailConfirmationScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));

  Future<void> resend({
    required String email,
    required void Function() onSuccess,
  }) async {
    state = const AsyncValue<void>.loading();
    final newState = await AsyncValue.guard(() => authRepository.resend(
      email: email,
    ));
    if(mounted){
      state = newState;
      if(!state.hasError){
        onSuccess();
      }
    }
  }
}

final emailConfirmationScreenControllerProvider = StateNotifierProvider.autoDispose<EmailConfirmationScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return EmailConfirmationScreenController(authRepository: authRepository);
});