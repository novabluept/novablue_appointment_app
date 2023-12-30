
enum SupportedLocale { pt, en }

extension SupportedLocalExtension on SupportedLocale {

  String get countryCode {
    String name;
    switch (this) {
      case SupportedLocale.pt:
        name = 'pt';
        break;
      case SupportedLocale.en:
        name = 'en';
        break;
    }
    return name;
  }

  String get namePt {
    String name;
    switch (this) {
      case SupportedLocale.pt:
        name = 'Português';
        break;
      case SupportedLocale.en:
        name = 'Inglês';
        break;

    }
    return name;
  }

  String get nameEn {
    String name;
    switch (this) {
      case SupportedLocale.pt:
        name = 'Portuguese';
        break;
      case SupportedLocale.en:
        name = 'English';
        break;

    }
    return name;
  }

  String get icon {
    String icon;
    switch(this){
      case SupportedLocale.pt:
        icon = '🇵🇹';
        break;
      case SupportedLocale.en:
        icon = '🇬🇧';
        break;
    }
    return icon;
  }
}