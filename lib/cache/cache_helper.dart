import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  static late SharedPreferences sharedPreferences;

  static Future<void> cacheInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      await sharedPreferences.setString(key, value);
      return true;
    } else if (value is int) {
      await sharedPreferences.setInt(key, value);
      return true;
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
      return true;
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
      return true;
    }
    return false;
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static void removeItem({required String key}) async {
    await sharedPreferences.remove(key);
  }

  static void clearAllData() async {
    await sharedPreferences.clear();
  }
}
