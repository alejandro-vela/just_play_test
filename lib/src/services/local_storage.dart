import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  get apiToken {
    return prefs.getString('api-token') ?? '';
  }

  set setApiToken(String value) {
    prefs.setString('api-token', value);
  }

  clear() {
    prefs.clear();
  }
}
