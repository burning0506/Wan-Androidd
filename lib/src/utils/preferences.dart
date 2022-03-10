import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  // static final Preferences _preferences = Preferences._internal();

  static SharedPreferences? sp;

  // factory Preferences.getInstance() {
  //   return _preferences;
  // }

  // Preferences._internal();

  static void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    sp = await SharedPreferences.getInstance();
  }

  static String getString(String key, String defaultValue) {
    return sp?.getString(key) ?? defaultValue;
  }

  static void setString(String key, String value) {
    sp?.setString(key, value);
  }
}
