
import '../common_widgets/my_dropdown_button.dart';

class Validations{

  static bool hasMinimumAndMaxCharacters(String value){
    final regex = RegExp(r"^[A-zÀ-ú]{3,15}$", caseSensitive: false);
    return regex.hasMatch(value);
  }

  static bool isEmailValid(String value){
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$");
    return regex.hasMatch(value);
  }

  static bool isPhoneValid(String value,String countryCode){
    RegExp regex;

    if (countryCode == PhoneCountryCode.pt.code) {
      regex = RegExp(r"^9[1236][0-9]{7}$");
      return regex.hasMatch(value);
    } else if (countryCode == PhoneCountryCode.fr.code) {
      regex = RegExp(r"^[1-9](\d{2}){4}$");
      return regex.hasMatch(value);
    } else if (countryCode == PhoneCountryCode.es.code) {
      regex = RegExp(r"^(6[0-9]|7[1-9])[0-9]{8}$");
      return regex.hasMatch(value);
    }

    return false;
  }

  static bool isPasswordValid(String value){
    final regex = RegExp(r"^.{6,}$");
    return regex.hasMatch(value);
  }
}