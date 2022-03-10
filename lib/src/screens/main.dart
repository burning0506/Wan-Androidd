import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wanandroid/src/screens/group.dart';
import 'package:wanandroid/src/screens/home.dart';
import 'package:wanandroid/src/screens/plaza.dart';
import 'package:wanandroid/src/screens/project.dart';
import 'package:wanandroid/src/screens/navigation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      const HomeScreen(),
      const PlazaScreen(),
      const GroupScreen(),
      const NavigationScreen(),
      const ProjectScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: const Icon(Icons.home), label: appLocalizations.home),
      BottomNavigationBarItem(
          icon: const Icon(Icons.explore_rounded),
          label: appLocalizations.plaza),
      BottomNavigationBarItem(
          icon: const Icon(Icons.group), label: appLocalizations.group),
      BottomNavigationBarItem(
          icon: const Icon(Icons.navigation), label: appLocalizations.tree),
      BottomNavigationBarItem(
          icon: const Icon(Icons.account_balance_wallet),
          label: appLocalizations.project),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.wanandroid),
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavigationBarItems,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final icons = {
      Icons.integration_instructions_outlined: appLocalizations.myIntegration,
      Icons.favorite_border: appLocalizations.myFavorite,
      Icons.share: appLocalizations.myShared,
      Icons.today_outlined: appLocalizations.myTodo,
      Icons.dark_mode: appLocalizations.darkMode,
      Icons.settings: appLocalizations.setting,
    };
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Image.asset(
              'assets/images/avatar_bg.jpg',
            ),
            Expanded(
              child: ListView(
                  children: icons.entries
                      .map((entry) => InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/settings');
                            },
                            child: Container(
                              height: 48,
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Row(
                                children: [
                                  Icon(entry.key,
                                      color: Colors.black87, size: 24),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text(entry.value,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
