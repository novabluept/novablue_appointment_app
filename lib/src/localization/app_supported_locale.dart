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

  String get name {
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

  String get path {
    String path;
    switch(this){
      case SupportedLocale.pt:
        path = 'images/flags/portugal.svg';
        break;
      case SupportedLocale.en:
        path = 'images/flags/united_kingdom.svg';
        break;
    }
    return path;
  }
}