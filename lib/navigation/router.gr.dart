// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:test_news_app/features/article_page/presentation/pages/article_page.dart' as _i1;
import 'package:test_news_app/features/main_page/presentation/pages/main_page.dart' as _i2;
import 'package:test_news_app/features/specific_category_page/presentation/pages/specific_category_page.dart' as _i3;
import 'package:test_news_app/index.dart' as _i6;

/// generated route for
/// [_i1.ArticlePage]
class ArticleRoute extends _i4.PageRouteInfo<ArticleRouteArgs> {
  ArticleRoute({
    _i5.Key? key,
    required _i6.Article article,
    required List<_i6.Article> allArticles,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          ArticleRoute.name,
          args: ArticleRouteArgs(
            key: key,
            article: article,
            allArticles: allArticles,
          ),
          initialChildren: children,
        );

  static const String name = 'ArticleRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ArticleRouteArgs>();
      return _i1.ArticlePage(
        key: args.key,
        article: args.article,
        allArticles: args.allArticles,
      );
    },
  );
}

class ArticleRouteArgs {
  const ArticleRouteArgs({
    this.key,
    required this.article,
    required this.allArticles,
  });

  final _i5.Key? key;

  final _i6.Article article;

  final List<_i6.Article> allArticles;

  @override
  String toString() {
    return 'ArticleRouteArgs{key: $key, article: $article, allArticles: $allArticles}';
  }
}

/// generated route for
/// [_i2.MainPage]
class MainRoute extends _i4.PageRouteInfo<void> {
  const MainRoute({List<_i4.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.MainPage();
    },
  );
}

/// generated route for
/// [_i3.SpecificCategoryPage]
class SpecificCategoryRoute extends _i4.PageRouteInfo<SpecificCategoryRouteArgs> {
  SpecificCategoryRoute({
    _i5.Key? key,
    required List<_i6.Article> allArticles,
    required String specificCategory,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          SpecificCategoryRoute.name,
          args: SpecificCategoryRouteArgs(
            key: key,
            allArticles: allArticles,
            specificCategory: specificCategory,
          ),
          initialChildren: children,
        );

  static const String name = 'SpecificCategoryRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SpecificCategoryRouteArgs>();
      return _i3.SpecificCategoryPage(
        key: args.key,
        allArticles: args.allArticles,
        specificCategory: args.specificCategory,
      );
    },
  );
}

class SpecificCategoryRouteArgs {
  const SpecificCategoryRouteArgs({
    this.key,
    required this.allArticles,
    required this.specificCategory,
  });

  final _i5.Key? key;

  final List<_i6.Article> allArticles;

  final String specificCategory;

  @override
  String toString() {
    return 'SpecificCategoryRouteArgs{key: $key, allArticles: $allArticles, specificCategory: $specificCategory}';
  }
}
