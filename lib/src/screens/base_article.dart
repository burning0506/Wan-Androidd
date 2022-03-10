
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wanandroid/src/data/api_response.dart';
import 'package:wanandroid/src/data/article.dart';
import 'package:wanandroid/src/data/article_list.dart';
import 'package:wanandroid/src/widgets/empty.dart';
import 'package:wanandroid/src/widgets/list_view_article.dart';
import 'package:wanandroid/src/widgets/loading.dart';

abstract class BaseArticleScreen extends StatefulWidget {

  final String urlString;

  const BaseArticleScreen({Key? key, required this.urlString}) : super(key: key);

  @override
  _BaseArticleScreenState createState() => _BaseArticleScreenState();

  Widget? buildListHeader();

}

class _BaseArticleScreenState extends State<BaseArticleScreen> {

  bool _isOver = false;
  int _currentPage = 0;
  final List<Article> _articles = [];
  RequestStatus _requestStatus = RequestStatus.loading;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  @override
  Widget build(BuildContext context) {

    const loadingLayout = LoadingWidget();

    final emptyLayout = EmptyLayout(onPressed: () {
      setState(() {
        fetchArticles();
      });
    });

    final successLayout = ListViewArticle(
      articles: _articles,
      isOver: _isOver,
      heroTag: widget.toString(),
      refreshCallback: _onRefresh,
      loadMoreCallback: _onLoadMore,
      header: widget.buildListHeader(),
    );

    switch (_requestStatus) {
      case RequestStatus.loading:
        return loadingLayout;
      case RequestStatus.error:
        return emptyLayout;
      case RequestStatus.success:
        return successLayout;
    }
  }

  Future<void> _onRefresh() async {
    _currentPage = 0;
    _articles.clear();
    fetchArticles();
  }

  Future<void> _onLoadMore() async {
    _currentPage++;
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    _requestStatus = RequestStatus.loading;
    final url = widget.urlString.replaceFirst('{currentPage}', '$_currentPage');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final apiResponse = jsonDecode(response.body);
      var articleData = ApiResponse<ArticleList>.fromJson(apiResponse,
              (data) => ArticleList.fromJson(data as Map<String, dynamic>));
      _isOver = articleData.data.over;
      setState(() {
        _requestStatus = RequestStatus.success;
        _articles.addAll(articleData.data.datas);
      });
    } else {
      setState(() {
        _requestStatus = RequestStatus.error;
      });
    }
  }

}
