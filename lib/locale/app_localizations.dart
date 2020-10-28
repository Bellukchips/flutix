part of 'locale.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  ///Buildcontext app localizations
  ///
  ///
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  ///Deletgate app localizations
  ///
  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;
  Future<void> load() async {
    String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) => _localizedStrings[key];
  bool get isEnLocale => locale.languageCode == 'en';
  bool get isIdLocale => locale.languageCode == 'id';
}
