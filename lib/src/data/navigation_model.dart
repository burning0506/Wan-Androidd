
import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/src/data/article.dart';

part 'navigation_model.g.dart';

@JsonSerializable()
class NavigationModel {

  List<Article> articles;
  int cid;
  String name;

  NavigationModel(this.articles, this.cid, this.name);

  factory NavigationModel.fromJson(Map<String, dynamic> json) => _$NavigationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NavigationModelToJson(this);

  bool isSelected = false;

}