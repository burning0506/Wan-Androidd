import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/src/provider/theme_model.dart';
import 'package:wanandroid/src/screens/article_detail.dart';
import 'package:wanandroid/src/screens/group.dart';
import 'package:wanandroid/src/screens/home.dart';
import 'package:wanandroid/src/screens/luanch.dart';
import 'package:wanandroid/src/screens/main.dart';
import 'package:wanandroid/src/screens/plaza.dart';
import 'package:wanandroid/src/screens/project.dart';
import 'package:wanandroid/src/screens/settings.dart';
import 'package:wanandroid/src/screens/navigation.dart';
import 'package:wanandroid/src/utils/constants.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Future<SharedPreferences> _futureSP = SharedPreferences.getInstance();

  MaterialColor _localThemeColor = Colors.red;

  @override
  void initState() {
    super.initState();
    getAppThemeColor();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeModel()),
      ],
      child: Consumer<ThemeModel>(builder: (context, themeModel, child) {
        return MaterialApp(
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.wanandroid,
          theme: ThemeData(
            primarySwatch: themeModel.themeColor ?? _localThemeColor,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          initialRoute: '/launch',
          routes: {
            '/launch': (context) => const LaunchScreen(),
            '/main': (context) => const MainScreen(),
            '/home': (context) => const HomeScreen(),
            '/plaza': (context) => const PlazaScreen(),
            '/group': (context) => const GroupScreen(),
            '/navigation': (context) => const NavigationScreen(),
            '/project': (context) => const ProjectScreen(),
            '/article_detail': (context) => const ArticleDetail(),
            '/settings': (context) => const Settings(),
          },
        );
      }),
    );
  }

  void getAppThemeColor() async {
    final SharedPreferences sp = await _futureSP;
    var colorName = sp.getString(Constants.themeColorName);
    if(colorName != null) {
      MaterialColor color = Constants.themeColorSupport[colorName]!;
      setState(() {
        _localThemeColor = color;
      });
    }
  }
}
