// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationModel _$NavigationModelFromJson(Map<String, dynamic> json) =>
    NavigationModel(
      (json['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['cid'] as int,
      json['name'] as String,
    );

Map<String, dynamic> _$NavigationModelToJson(NavigationModel instance) =>
    <String, dynamic>{
      'articles': instance.articles,
      'cid': instance.cid,
      'name': instance.name,
    };
