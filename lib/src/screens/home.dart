import 'package:flutter/material.dart';
import 'package:wanandroid/src/screens/base_article.dart';
import 'package:wanandroid/src/utils/constants.dart';
import 'package:wanandroid/src/widgets/carousel.dart';

class HomeScreen extends BaseArticleScreen {
  const HomeScreen({Key? key})
      : super(key: key, urlString: Constants.homeArticles);

  @override
  Widget? buildListHeader() {
    return const SizedBox(height: 200, child: MyPageView());
  }
}
