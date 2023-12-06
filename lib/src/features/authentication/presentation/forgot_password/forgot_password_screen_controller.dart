
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/auth_repository.dart';

class ForgotPasswordScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  ForgotPasswordScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));

  Future<void> resetPasswordForEmail({
    required String email,
    required void Function() onSuccess,
  }) async {
    state = const AsyncValue<void>.loading();
    final newState = await AsyncValue.guard(() => authRepository.resetPasswordForEmail(
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


final forgotPasswordScreenControllerProvider = StateNotifierProvider.autoDispose<ForgotPasswordScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return ForgotPasswordScreenController(authRepository: authRepository);
});