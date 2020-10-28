part of 'shared_preference.dart';

class PreferenceManager {
  static var id;
  static savePreferences(int id, String lang, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('id', id);
    pref.setString('lang', lang);
    pref.setString('value', value);
    pref.commit();
  }

  static getPreferences(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getInt('id');
    if (id == 1) {
      BlocProvider.of<LocaleCubit>(context).toEnglish();
    } else {
      BlocProvider.of<LocaleCubit>(context).toIndonesia();
    }
  }
}
