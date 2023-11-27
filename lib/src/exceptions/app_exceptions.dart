
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import '../localization/app_locale_notifier.dart';

sealed class AppException implements Exception {
  AppException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => message;
}

/// General Exceptions
class UnexpectedErrorException extends AppException {
  UnexpectedErrorException(ref) : super('unexpected-error', ref.read(appLocalizationsProvider).unexpectedErrorException);
}

/// Auth
class InvalidLoginCredentialsException extends AppException {
  InvalidLoginCredentialsException(ref) : super('invalid-login-credentials', ref.read(appLocalizationsProvider).invalidLoginCredentialsException);
}

class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException(ref) : super('email-already-in-use', ref.read(appLocalizationsProvider).emailAlreadyInUseException);
}

class WeakPasswordException extends AppException {
  WeakPasswordException(ref) : super('weak-password', ref.read(appLocalizationsProvider).weakPasswordException);
}

class WrongPasswordException extends AppException {
  WrongPasswordException(ref) : super('wrong-password', ref.read(appLocalizationsProvider).wrongPasswordException);
}

class UserNotFoundException extends AppException {
  UserNotFoundException(ref) : super('user-not-found', ref.read(appLocalizationsProvider).userNotFoundException);
}

class FileTooLargeException extends AppException {
  FileTooLargeException(ref,fileMaxSizeInMegaBytes) : super('file-too-large', ref.read(appLocalizationsProvider).fileTooLargeException(fileMaxSizeInMegaBytes));
}
