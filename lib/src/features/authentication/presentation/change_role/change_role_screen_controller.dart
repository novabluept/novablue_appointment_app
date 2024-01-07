
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_role_company_supabase.dart';

class ChangeRoleScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  ChangeRoleScreenController({required this.authRepository}) : super(const AsyncValue<void>.data(null));

  Future<void> updateActiveUserRole({
    required UserRoleCompanyShopSupabase previousRole,
    required UserRoleCompanyShopSupabase nextRole,
    required void Function() onSuccess,
  }) async {
    state = const AsyncValue<void>.loading();
    final newState = await AsyncValue.guard(() => authRepository.updateActiveUserRole(
      previousRole: previousRole,
      nextRole: nextRole
    ));
    if(mounted){
      state = newState;
      if(!state.hasError){
        onSuccess();
      }
    }
  }
}

final changeRoleScreenControllerProvider = StateNotifierProvider.autoDispose<ChangeRoleScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return ChangeRoleScreenController(authRepository: authRepository);
});