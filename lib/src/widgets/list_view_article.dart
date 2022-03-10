
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wanandroid/src/data/article.dart';
import 'package:wanandroid/src/widgets/item_article.dart';

class ListViewArticle extends StatefulWidget {

  final List<Article> articles;

  final bool isOver;

  final String heroTag;

  final RefreshCallback refreshCallback;

  final Future<void> Function() loadMoreCallback;

  final Widget? header;

  const ListViewArticle({
    Key? key,
    required this.articles,
    required this.isOver,
    required this.heroTag,
    required this.refreshCallback,
    required this.loadMoreCallback,
    this.header,
  }) : super(key: key);

  @override
  State<ListViewArticle> createState() => _ListViewArticleState();
}

class _ListViewArticleState extends State<ListViewArticle> {

  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  late ScrollController _controller;

  late int headerCount;

  @override
  void initState() {
    super.initState();
    headerCount = widget.header == null ? 0 : 1;
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final articles = widget.articles;
    final header = widget.header;
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: widget.refreshCallback,
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            if (index == 0 && header != null) {
              return header;
            }
            if (index >= articles.length + headerCount) {
              if (widget.isOver) {
                return Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: const Text('已经到底了~'));
              }
              widget.loadMoreCallback();
              return Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: const SizedBox(
                  child: CircularProgressIndicator(strokeWidth: 2),
                  width: 24,
                  height: 24,
                ),
              );
            }
            final article = articles[index - headerCount];
            return ItemArticle(
                article: article, appLocalizations: appLocalizations);
          },
          itemCount: articles.isNotEmpty ? articles.length + headerCount + 1 : headerCount,
          controller: _controller,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: widget.heroTag,
        onPressed: () {
          _controller.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.decelerate);
        },
        child: const Icon(Icons.arrow_upward),
        elevation: 5,
      ),
    );
  }
}

enum RequestStatus {
  success,
  error,
  loading
}

