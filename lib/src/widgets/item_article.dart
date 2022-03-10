
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wanandroid/src/data/article.dart';

class ItemArticle extends StatelessWidget {
  const ItemArticle({
    Key? key,
    required this.article,
    required this.appLocalizations,
  }) : super(key: key);

  final Article article;
  final AppLocalizations appLocalizations;

  @override
  Widget build(BuildContext context) {
    final imageLayout = Container(
      margin: const EdgeInsets.only(right: 18),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(3),
      ),
      child: CachedNetworkImage(
        width: 80,
        height: 100,
        fit: BoxFit.fill,
        imageUrl: article.envelopePic,
        placeholder: (context, url) => Image.asset('assets/images/loading.gif'),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );

    final contentLayout = Stack(
      children: [
        Row(
          children: [
            Visibility(
              visible: article.fresh,
              child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  padding: const EdgeInsets.all(3),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red),
                          borderRadius:
                          BorderRadius.all(Radius.circular(3)))),
                  child: Text(appLocalizations.newFlag,
                      style: const TextStyle(fontSize: 10, height: 1))),
            ),
            Text(
              article.author.isEmpty ? article.shareUser : article.author,
              style: const TextStyle(fontSize: 10),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
          child: Text(
            article.title,
            style: const TextStyle(
                fontSize: 16, overflow: TextOverflow.ellipsis),
            maxLines: 2,
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Text('${article.superChapterName} | ${article.chapterName}',
              style: const TextStyle(fontSize: 10),
          ),
        ),
        Positioned(
            right: 0,
            top: 0,
            child:
            Text(article.niceDate, style: const TextStyle(fontSize: 10))),
        const Positioned(
            bottom: 0,
            right: 0,
            child: Icon(
              Icons.favorite_border,
              color: Colors.black38,
            ))
      ],
    );

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/article_detail', arguments: article.link);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: article.envelopePic.isNotEmpty ? Row(
          children: [
            imageLayout,
            Expanded(child: SizedBox(height: 100, child: contentLayout))
          ],
        ) : contentLayout
      ),
    );
  }
}