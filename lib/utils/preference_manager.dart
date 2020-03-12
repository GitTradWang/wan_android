import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static Future<bool> set(String key, dynamic value) async {
    switch (value.runtimeType) {
      case int:
        return (await SharedPreferences.getInstance()).setInt(key, value);
        break;
      case bool:
        return (await SharedPreferences.getInstance()).setBool(key, value);
        break;
      case double:
        return (await SharedPreferences.getInstance()).setDouble(key, value);
        break;
      case String:
        return (await SharedPreferences.getInstance()).setString(key, value);
        break;
      default:
        return false;
        break;
    }
  }

  static Future<int> getInt(String key) async {
    return (await SharedPreferences.getInstance()).getInt(key);
  }

  static Future<bool> getBool(String key) async {
    return (await SharedPreferences.getInstance()).getBool(key);
  }

  static Future<String> getString(String key) async {
    return (await SharedPreferences.getInstance()).getString(key);
  }

  static Future<double> getDouble(String key) async {
    return (await SharedPreferences.getInstance()).getDouble(key);
  }
}
