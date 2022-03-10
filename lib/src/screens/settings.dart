import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/src/provider/theme_model.dart';
import 'package:wanandroid/src/utils/constants.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.setting),
      ),
      body: const ThemeColorSetting(),
    );
  }
}

class ThemeColorSetting extends StatefulWidget {
  const ThemeColorSetting({Key? key}) : super(key: key);

  @override
  _ThemeColorSettingState createState() => _ThemeColorSettingState();
}

class _ThemeColorSettingState extends State<ThemeColorSetting> {
  final themeColors = Constants.themeColorSupport;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 3 / 2,
      children: themeColors.entries
          .map((e) => GridTile(
                header: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8)),
                      color: Colors.grey.withAlpha(55)),
                  height: 30,
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(colorString(e.value),
                          style: const TextStyle(color: Colors.white)),
                      const Spacer(),
                      Consumer<ThemeModel>(
                        builder: (context, themeModel, child) {
                          if(themeModel.themeColor == e.value) {
                            return const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.check_circle, color: Colors.white),
                            );
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    saveThemeColor(context, e);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(colors: [
                        e.value.shade50,
                        e.value.shade100,
                        e.value.shade200,
                        e.value.shade300,
                        e.value.shade400,
                        e.value.shade500,
                        e.value.shade600,
                        e.value.shade700,
                        e.value.shade800,
                        e.value.shade900,
                      ]),
                    ),
                    child: Text(
                      e.key,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ))
          .toList(),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  Future<void> saveThemeColor(BuildContext context, MapEntry<String, MaterialColor> e) async {

    Provider.of<ThemeModel>(context, listen: false).changeThemeColor(e.value);
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(Constants.themeColorName, e.key);
  }
}
