
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_role_company_supabase.dart';

final tempUserRoleCompanyProvider = StateProvider<UserRoleCompanySupabase?>((ref){
  return ref.read(currentUserRoleCompanyProvider);
});