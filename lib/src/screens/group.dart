import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wanandroid/src/data/api_response.dart';
import 'package:wanandroid/src/data/groups.dart';
import 'package:wanandroid/src/screens/group_tab_view.dart';
import 'package:wanandroid/src/utils/constants.dart';
import 'package:wanandroid/src/widgets/keep_alive_wrapper.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> with TickerProviderStateMixin {

  late TabController _tabController;

  final List<Groups> _wechatGroups = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _wechatGroups.length, vsync: this);
    fetchWechatGroups();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final tabBars = TabBar(
      controller: _tabController,
      labelColor: Colors.white,
      overlayColor: MaterialStateProperty.all(Colors.red),
      unselectedLabelColor: Colors.white.withOpacity(0.6),
      indicatorColor: Colors.white,
      indicatorWeight: 3,
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: _wechatGroups.map((e) => Text(e.name)).toList()
    );

    final tabBarViews = TabBarView(
        controller: _tabController,
        children: _wechatGroups.map((e) {
          final urlString = Constants.groupArticles.replaceFirst('{groupId}', '${e.id}');
          return KeepAliveWrapper(child: GroupTabViewScreen(urlString: urlString));
        }).toList()
    );

    return Column(
      children: [
        Container(
          child: tabBars,
          color: Theme.of(context).colorScheme.primary,
          height: 40,
        ),
        Expanded(child: tabBarViews)
      ],
    );

  }

  Future<void> fetchWechatGroups() async {
    final response = await http.get(Uri.parse(Constants.groupList));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final apiResponse = jsonDecode(response.body);
      var responseData = ApiResponse<List<Groups>>.fromJson(apiResponse, (json) => List<Groups>.from((json as List).map((e) => Groups.fromJson(e))));
      final groups = responseData.data;
      setState(() {
        _wechatGroups.clear();
        _wechatGroups.addAll(groups);
        _tabController.dispose();
        _tabController = TabController(length: _wechatGroups.length, vsync: this);
      });
    }
  }

}
