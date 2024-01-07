
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/authentication/domain/user_role_company_supabase.dart';

final currentAuthChangeEventProvider = StateProvider<AuthChangeEvent?>((ref){
  return null;
});

final currentUserRoleCompanyProvider = StateProvider<UserRoleCompanyShopSupabase?>((ref){
  return null;
});