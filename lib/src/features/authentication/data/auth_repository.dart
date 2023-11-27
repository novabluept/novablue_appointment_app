
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:novablue_appointment_app/src/constants/app_file_size.dart';
import 'package:novablue_appointment_app/src/localization/app_locale_notifier.dart';
import 'package:novablue_appointment_app/src/supabase_providers/providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../exceptions/app_exceptions.dart';

abstract class AuthRepository {
  Stream<User?>  authStateChanges();
  User? get currentUser;
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<File?> chooseProfilePicture();
}

class SupabaseAuthRepository implements AuthRepository{

  SupabaseAuthRepository(this.ref,this._client);

  final Ref ref;
  final SupabaseClient _client;


  @override
  Stream<User?> authStateChanges() async*{
    final authStream = _client.auth.onAuthStateChange;

    await for (final authState in authStream) {
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
      email: email, // 'miguelsilva20015111@gmail.com'
      password: password, // '12345678'
    ).catchError((e){
      if(e.message == 'Invalid login credentials'){
        throw InvalidLoginCredentialsException(ref);
      }
      throw UnexpectedErrorException(ref);
    });
  }

  @override
  Future<void> signOut() async{
    await _client.auth.signOut();
  }

  @override
  Future<File?> chooseProfilePicture() async{
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(file != null){
      var imagePath = await file.readAsBytes();

      var fileSize = imagePath.length;

      if(fileSize <= fileMaxSizeInBytes){
        return File(file.path);
      }else if(fileSize > fileMaxSizeInBytes){
        throw FileTooLargeException(ref,fileMaxSizeInMegaBytes);
      }
    }

    return null;
  }
}

final authRepositoryProvider = Provider<SupabaseAuthRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseAuthRepository(ref,client);
});

final authStateChangesProvider = StreamProvider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});







