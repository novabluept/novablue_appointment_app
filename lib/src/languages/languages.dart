class Language {
  final int id;
  final String imagePath;
  final String languageCode;

  Language(this.id, this.imagePath, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, 'images/flags/portugal.svg','pt'),
      Language(2, 'images/flags/united_kingdom.svg','en'),
    ];
  }
}