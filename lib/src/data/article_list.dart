
import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/src/data/article.dart';

part 'article_list.g.dart';

@JsonSerializable()
class ArticleList {

  int curPage;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;
  List<Article> datas;

  ArticleList(this.curPage, this.offset, this.over, this.pageCount, this.size,
      this.total, this.datas);

  factory ArticleList.fromJson(Map<String, dynamic> json) => _$ArticleListFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleListToJson(this);

}