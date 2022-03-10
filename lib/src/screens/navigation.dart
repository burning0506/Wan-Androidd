import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wanandroid/src/data/api_response.dart';
import 'package:wanandroid/src/data/article.dart';
import 'package:wanandroid/src/data/navigation_model.dart';
import 'package:wanandroid/src/utils/constants.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<NavigationModel> _navList = [];
  late ItemScrollController _menuItemController;
  late ItemScrollController _contentItemController;
  late ItemPositionsListener _contentItemPositionsListener;

  @override
  void initState() {
    _menuItemController = ItemScrollController();
    _contentItemController = ItemScrollController();
    _contentItemPositionsListener = ItemPositionsListener.create();
    getNavigationMenus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                color: Colors.grey.shade200,
                child: NavigationMenu(list: _navList, itemController: _menuItemController, contentItemPositionsListener: _contentItemPositionsListener, onTap: (position) {
                  _contentItemController.jumpTo(index: position * 2);
                }))),
        Expanded(flex: 2, child: NavigationContent(list: _navList, itemController: _contentItemController, itemPositionsListener: _contentItemPositionsListener))
      ],
    );
  }

  Future<void> getNavigationMenus() async {
    const url = Constants.navigationMenus;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final apiResponse = jsonDecode(response.body);
      var data = ApiResponse<List<NavigationModel>>.fromJson(
          apiResponse,
          (json) => List<NavigationModel>.from(
              (json as List).map((e) => NavigationModel.fromJson(e))));
      setState(() {
        _navList.addAll(data.data);
      });
    }
  }
}

class NavigationMenu extends StatefulWidget {
  final List<NavigationModel> list;
  final ItemScrollController itemController;
  final ItemPositionsListener contentItemPositionsListener;
  final Function(int position) onTap;

  const NavigationMenu({Key? key, required this.list, required this.itemController, required this.contentItemPositionsListener, required this.onTap}) : super(key: key);

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {

  int selectedIndex = 0;

  @override
  void initState() {
    widget.contentItemPositionsListener.itemPositions.addListener(() {
      final itemPosition = widget.contentItemPositionsListener.itemPositions.value.first;
      final index = itemPosition.index ~/ 2;
      final model = widget.list[index];
      setState(() {
        updateSelectedItem(model, index);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
        itemScrollController: widget.itemController,
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          final model = widget.list[index];
          final isSelectedItem = selectedIndex == index || model.isSelected;
          final textColor = isSelectedItem
              ? Theme.of(context).colorScheme.primary
              : Colors.grey.shade600;
          final bgColor = isSelectedItem ? Colors.white : Colors.transparent;
          return InkWell(
            onTap: () {
              setState(() {
                updateSelectedItem(model, index);
              });
              widget.onTap(index);
            },
            child: Container(
                height: 50,
                color: bgColor,
                child: Stack(
                  children: [
                    if (isSelectedItem)
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Container(
                          width: 4,
                          height: 25,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    Center(
                        child: Text(
                      model.name,
                      style: TextStyle(color: textColor),
                    ))
                  ],
                )),
          );
        });
  }

  void updateSelectedItem(NavigationModel model, int index) {
    widget.list[selectedIndex].isSelected = false;
    model.isSelected = true;
    selectedIndex = index;
  }
}

class NavigationContent extends StatefulWidget {
  final List<NavigationModel> list;
  final ItemScrollController itemController;
  final ItemPositionsListener itemPositionsListener;

  const NavigationContent({Key? key, required this.list, required this.itemController, required this.itemPositionsListener}) : super(key: key);

  @override
  State<NavigationContent> createState() => _NavigationContentState();
}

class _NavigationContentState extends State<NavigationContent> {

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: widget.itemController,
      itemPositionsListener: widget.itemPositionsListener,
      itemCount: widget.list.length * 2,
      itemBuilder: (context, index) {
        final realIndex = index ~/ 2;
        NavigationModel model = widget.list[realIndex];
        return index % 2 == 0
            ? HeadingItem(heading: model.name)
            : ContentItem(articles: model.articles);
      },
    );
  }
}

class HeadingItem extends StatefulWidget {
  final String heading;
  const HeadingItem({Key? key, required this.heading}) : super(key: key);

  @override
  State<HeadingItem> createState() => _HeadingItemState();
}

class _HeadingItemState extends State<HeadingItem> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(widget.heading),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


class ContentItem extends StatefulWidget {
  final List<Article> articles;
  const ContentItem({Key? key, required this.articles}) : super(key: key);

  @override
  State<ContentItem> createState() => _ContentItemState();
}

class _ContentItemState extends State<ContentItem> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colors = Constants.themeColorSupport;
    final random = Random();
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 18, bottom: 8),
      child: Wrap(
        spacing: 10,
        runSpacing: 2,
        children: widget.articles
            .map((e) => MaterialButton(
          height: 40,
          elevation: 0,
          color: Colors.grey.shade200,
          padding: const EdgeInsets.all(5),
          child: Text(e.title,
              style: TextStyle(
                  color: colors.values
                      .elementAt(random.nextInt(colors.length))
                      .shade700)),
          onPressed: () {
            Navigator.of(context).pushNamed('/article_detail', arguments: e.link);
          },
        ))
            .toList(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
