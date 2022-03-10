import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  MaterialColor? themeColor;

  void changeThemeColor(MaterialColor color) {
    themeColor = color;
    notifyListeners();
  }
}
