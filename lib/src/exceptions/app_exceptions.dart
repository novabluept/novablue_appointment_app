
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import '../localization/app_locale_notifier.dart';

sealed class AppException implements Exception {
  AppException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => message;
}

/// Auth
class EmailAlreadyInUseException extends AppException {

  EmailAlreadyInUseException(ref) : super('email-already-in-use', ref.read(appLocalizationsProvider).emailAlreadyInUseException);
}
/*
class WeakPasswordException extends AppException {
  WeakPasswordException() : super('weak-password', context.loc.weakPasswordException.capitalize());
}

class WrongPasswordException extends AppException {
  WrongPasswordException() : super('wrong-password', context.loc.wrongPasswordException.capitalize());
}

class UserNotFoundException extends AppException {
  UserNotFoundException() : super('user-not-found', context.loc.userNotFoundException.capitalize());
}*/
