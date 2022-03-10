
import 'package:flutter/material.dart';

class Constants {

  static const String baseUrl = 'https://wanandroid.com/';
  static const String homeArticles = '${baseUrl}article/list/{currentPage}/json';
  static const String plazaArticles = '${baseUrl}user_article/list/{currentPage}/json';
  static const String groupArticles = '${baseUrl}wxarticle/list/{groupId}/{currentPage}/json';
  static const String groupList = '${baseUrl}wxarticle/chapters/json';
  static const String navigationMenus = '${baseUrl}navi/json';
  static const String projectTrees = '${baseUrl}project/tree/json';
  static const String projectLists = '${baseUrl}project/list/{currentPage}/json?cid={cid}';


  static final themeColorSupport = {
    'red': Colors.red,
    'orange': Colors.orange,
    'yellow': Colors.yellow,
    'green': Colors.green,
    'blue': Colors.blue,
    'purple': Colors.purple,
    'cyan': Colors.cyan,
    'teal': Colors.teal,

    'black': const MaterialColor(0xff2D2D2D, <int, Color>{
      50: Color(0xFF8A8A8A),
      100: Color(0xFF747474),
      200: Color(0xFF616161),
      300: Color(0xFF484848),
      400: Color(0xFF3D3D3D),
      500: Color(0xff2D2D2D),
      600: Color(0xFF252525),
      700: Color(0xFF141414),
      800: Color(0xFF050505),
      900: Color(0xff000000),
    }),

  };

  static const String themeColorName = 'themeColorName';

}