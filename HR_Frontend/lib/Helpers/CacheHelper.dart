import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper extends ChangeNotifier{
  SharedPreferences? sharedPreferences;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool?> saveCache({required key, required value}) async {
    if (value is String) {
      return sharedPreferences?.setString(key, value).then((value) => value);
    } else if (value is int) {
      return sharedPreferences?.setInt(key, value).then((value) => value);
    } else if (value is double) {
      return sharedPreferences?.setDouble(key, value).then((value) => value);
    } else if (value is bool) {
      return sharedPreferences?.setBool(key, value).then((value) => value);
    } else if (value is List<String>) {
      return sharedPreferences
          ?.setStringList(key, value)
          .then((value) => value);
    }
    return null;
  }

  dynamic getCachedData({required key}) {
    return sharedPreferences?.get(key);
  }

  Future<bool> removeCachedData({required key}) {
    return sharedPreferences?.remove(key).then((value) => value ?? false) ?? Future.value(false);  }

  Future<bool> clearCache() {
    return sharedPreferences?.clear().then((value) => value ?? false) ?? Future.value(false);
  }
}
