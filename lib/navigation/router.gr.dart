// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:test_news_app/features/article_page/presentation/pages/article_page.dart'
    as _i1;
import 'package:test_news_app/features/main_page/presentation/pages/main_page.dart'
    as _i2;
import 'package:test_news_app/index.dart' as _i5;

/// generated route for
/// [_i1.ArticlePage]
class ArticleRoute extends _i3.PageRouteInfo<ArticleRouteArgs> {
  ArticleRoute({
    _i4.Key? key,
    required _i5.Article article,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          ArticleRoute.name,
          args: ArticleRouteArgs(
            key: key,
            article: article,
          ),
          initialChildren: children,
        );

  static const String name = 'ArticleRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ArticleRouteArgs>();
      return _i1.ArticlePage(
        key: args.key,
        article: args.article,
      );
    },
  );
}

class ArticleRouteArgs {
  const ArticleRouteArgs({
    this.key,
    required this.article,
  });

  final _i4.Key? key;

  final _i5.Article article;

  @override
  String toString() {
    return 'ArticleRouteArgs{key: $key, article: $article}';
  }
}

/// generated route for
/// [_i2.MainPage]
class MainRoute extends _i3.PageRouteInfo<void> {
  const MainRoute({List<_i3.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.MainPage();
    },
  );
}
