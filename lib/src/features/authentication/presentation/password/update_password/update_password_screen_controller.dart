
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:novablue_appointment_app/src/routing/scaffold_with_nested_navigation/scaffold_with_nested_navigation_provider.dart';

class UpdatePasswordScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  UpdatePasswordScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));

  Future<void> updatePassword({
    required WidgetRef ref,
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
        ref.read(currentIndexProvider.notifier).state = 0;
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

final updatePasswordScreenControllerProvider = StateNotifierProvider.autoDispose<UpdatePasswordScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return UpdatePasswordScreenController(authRepository: authRepository);
});