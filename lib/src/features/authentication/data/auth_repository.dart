import 'package:novablue_appointment_app/src/supabase_providers/providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthRepository {
  Stream<User?>  authStateChanges();
  User? get currentUser;
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class SupabaseAuthRepository implements AuthRepository{

  SupabaseAuthRepository(this._client);
  final SupabaseClient _client;

  @override
  Stream<User?> authStateChanges() async*{
    final authStream = _client.auth.onAuthStateChange;

    await for (final authState in authStream) {
      print("user -> ${authState.session?.user}");
      yield authState.session?.user;
    }
  }

  @override
  User? get currentUser => _client.auth.currentUser;



  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) async{
    await _client.auth.signUp(
      email: 'miguelsilva20015111@gmail.com',
      password: '12345678',
    );
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async{
    await _client.auth.signInWithPassword(
      email: 'miguelsilva20015111@gmail.com',
      password: '12345678',
    );
  }

  @override
  Future<void> signOut() async{
    await _client.auth.signOut();
  }

}

final authRepositoryProvider = Provider<SupabaseAuthRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseAuthRepository(client);
});

final authStateChangesProvider = StreamProvider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});







