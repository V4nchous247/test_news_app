import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_news_app/index.dart';

part 'articles_event.dart';
part 'articles_state.dart';
part 'articles_bloc.freezed.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc() : super(const _Loading()) {
    on<ArticlesEvent>((event, emit) async {
      await event.when(
        fetch: () async {
          String jsonString = await rootBundle.loadString('assets/strings/articles.json');

          final data = json.decode(jsonString);
          List<Article> articles = (data['articles'] as List).map((article) => Article.fromJson(article)).toList();

          emit(ArticlesState.loaded(articles: articles));
        },
      );
    });
  }
}
