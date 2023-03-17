import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  static SpUtil? _spUtil;
  static late SharedPreferences _preferences;

  /// 获取shared preferences实例
  static Future<SpUtil?> getInstance() async {
    if (_spUtil == null) {
      _spUtil = SpUtil.internal();
      _preferences = await SharedPreferences.getInstance();
    }
    return _spUtil;
  }

  SpUtil.internal();

  /// 保存字符串
  static Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  /// 获取字符串
  static String getString(String key, {String defaultValue = ""}) {
    return _preferences.getString(key) ?? defaultValue;
  }

  /// 保存bool值
  static Future<bool> setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  /// 获取bool值
  static bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  /// 保存int值
  static Future<bool> setInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  /// 获取int值
  static int getInt(String key, {int defaultValue = 0}) {
    return _preferences.getInt(key) ?? defaultValue;
  }

  /// 保存浮点值
  static Future<bool> setDouble(String key, double value) {
    return _preferences.setDouble(key, value);
  }

  /// 获取浮点值
  static double getDouble(String key, {double defaultValue = 0.0}) {
    return _preferences.getDouble(key) ?? defaultValue;
  }

  /// 判断shared preferences是否包含某个键
  static bool contains(String key) {
    return _preferences.getKeys().contains(key);
  }

  /// 获取shared preferences所有的键
  static Set<String> getKeys() {
    return _preferences.getKeys();
  }

  /// 删除对应键值
  static Future<bool> remove(String key) {
    return _preferences.remove(key);
  }

  /// 清空shared preferences
  static Future<bool> clear() {
    return _preferences.clear();
  }
}
