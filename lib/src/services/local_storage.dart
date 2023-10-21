import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  get tokenFcm {
    return prefs.getString('tokenFcm') ?? '';
  }

  set setTokenFcm(String value) {
    prefs.setString('tokenFcm', value);
  }

  get token {
    return prefs.getString('token') ?? '';
  }

  set setToken(String value) {
    prefs.setString('token', value);
  }

  clear() {
    prefs.clear();
  }
}
