
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';

class UpdatePersonalDataScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  UpdatePersonalDataScreenController({required this.authRepository}) : super(const AsyncValue<void>.data(null));

  Future<void> updateUserData({
    required String id,
    required Map<String,dynamic> updatedData,
    required void Function() onSuccess,
  }) async {
    state = const AsyncValue<void>.loading();
    final newState = await AsyncValue.guard(() => authRepository.updateUserData(
      id: id,
      updatedData: updatedData,
    ));
    if(mounted){
      state = newState;
      if(!state.hasError){
        onSuccess();
      }
    }
  }

}

final updatePersonalDataScreenControllerProvider = StateNotifierProvider.autoDispose<UpdatePersonalDataScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return UpdatePersonalDataScreenController(authRepository: authRepository);
});