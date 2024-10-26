import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_news_app/index.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<List<Article>> loadArticles() async {
    String jsonString = await rootBundle.loadString('assets/strings/articles.json');

    final data = json.decode(jsonString);
    List<Article> articles = (data['articles'] as List).map((article) => Article.fromJson(article)).toList();

    return articles;
  }

  final TextEditingController _searchController = TextEditingController();

  final CategoriesBloc _categoriesBloc = sl<CategoriesBloc>();
  final ArticlesBloc _articlesBloc = sl<ArticlesBloc>();

  @override
  void initState() {
    _categoriesBloc.add(const CategoriesEvent.fetch());
    _articlesBloc.add(const ArticlesEvent.fetch());
    super.initState();
  }

  @override
  void dispose() {
    _categoriesBloc.close();
    _articlesBloc.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      searchController: _searchController,
      child: (isSearching) => isSearching
          ? BlocBuilder<ArticlesBloc, ArticlesState>(
              bloc: _articlesBloc,
              builder: (context, state) {
                return state.when(
                  loading: () => const CircularProgressIndicator(),
                  loaded: (articles) => SearchLayout(
                    articles: articles,
                    searchController: _searchController,
                  ),
                  error: () => const Text('ERROR'),
                );
              },
            )
          : DefaultLayout(
              categoriesBloc: _categoriesBloc,
              articlesBloc: _articlesBloc,
            ),
    );
  }
}
