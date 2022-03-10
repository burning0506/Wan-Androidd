import 'package:flutter/material.dart';
import 'package:wanandroid/src/screens/base_article.dart';
import 'package:wanandroid/src/utils/constants.dart';

class PlazaScreen extends BaseArticleScreen {
  const PlazaScreen({Key? key})
      : super(key: key, urlString: Constants.plazaArticles);

  @override
  Widget? buildListHeader() => null;
}
