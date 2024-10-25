// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleImpl _$$ArticleImplFromJson(Map<String, dynamic> json) =>
    _$ArticleImpl(
      imgUrl: json['imgUrl'] as String,
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      category: json['category'] as String,
      allTimeViews: (json['allTimeViews'] as num).toInt(),
      lastTreeDaysViews: (json['lastTreeDaysViews'] as num).toInt(),
    );

Map<String, dynamic> _$$ArticleImplToJson(_$ArticleImpl instance) =>
    <String, dynamic>{
      'imgUrl': instance.imgUrl,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'category': instance.category,
      'allTimeViews': instance.allTimeViews,
      'lastTreeDaysViews': instance.lastTreeDaysViews,
    };
