
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/routing/refresh_service/refresh_service_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/authentication/data/auth_repository.dart';
import '../../features/authentication/domain/user_role_company_supabase.dart';

class RefreshService {

  final Ref ref;
  StreamSubscription<UserRoleCompanySupabase?>? _userRoleSubscription;
  StreamSubscription<AuthChangeEvent?>? _eventSubscription;

  StreamController<UserRoleCompanySupabase?> _userRoleStreamController = StreamController<UserRoleCompanySupabase?>();
  StreamController<AuthChangeEvent?> _eventStreamController = StreamController<AuthChangeEvent?>();


  RefreshService(this.ref) {
    _init();
  }

  void _init() {
    ref.listen<AsyncValue<AuthChangeEvent?>>(watchEventChangesProvider, (previous, next) {
      final event = next.value;
      _userRoleSubscription?.cancel();
      if (event != null) {
        getAuthEvent();
      }
    });

    ref.listen<AsyncValue<User?>>(watchUserSessionChangesProvider, (previous, next) {
      final user = next.value;
      _userRoleSubscription?.cancel();
      if (user != null) {
        getActiveUserRoleCompany(user.id);
      }else{
        _userRoleStreamController.add(null);
      }
    });
  }

  getAuthEvent(){
    _eventSubscription = ref
        .read(authRepositoryProvider)
        .watchEventChanges()
        .listen((event) async {
      ref.read(currentAuthChangeEventProvider.notifier).state = event;
      _eventStreamController.add(event);
    });
  }

  getActiveUserRoleCompany(String id){
    _userRoleSubscription = ref
      .read(authRepositoryProvider)
      .watchActiveUserRoleCompany(id: id)
      .listen((role) async {
        final user = ref.read(authRepositoryProvider).currentUser;
        if (user != null) {
          ref.read(currentUserRoleCompanyProvider.notifier).state = role;
          _userRoleStreamController.add(role);
        }
    });
  }


  void dispose() {
    _userRoleSubscription?.cancel();
    _eventSubscription?.cancel();
    _userRoleStreamController.close();
    _eventStreamController.close();
  }

  Stream<UserRoleCompanySupabase?> get userRoleStream => _userRoleStreamController.stream;
  Stream<AuthChangeEvent?> get eventStream => _eventStreamController.stream;

}