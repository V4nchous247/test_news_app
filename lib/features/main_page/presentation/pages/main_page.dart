import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
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

  List<Article> articles = [];
  List<String> filters = [];

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
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: TopicOfTheHourWidget(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                height: 40,
                child: BlocBuilder<CategoriesBloc, CategoriesState>(
                  bloc: _categoriesBloc,
                  builder: (context, state) => state.when(
                    loading: () => const CircularProgressIndicator(),
                    loaded: (categories) => ScrollablePositionedList.separated(
                      itemCount: categories.length,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CategoryWidget(
                        onTap: () => setState(() {
                          if (filters.contains(categories[index])) {
                            filters.remove(categories[index]);
                          } else {
                            filters.add(categories[index]);
                          }
                        }),
                        title: categories[index],
                      ),
                      separatorBuilder: (context, index) => const SizedBox(width: 8),
                    ),
                    error: () => const Text('ERROR'),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: BlocBuilder<ArticlesBloc, ArticlesState>(
                bloc: _articlesBloc,
                builder: (context, state) => state.when(
                  loading: () => const CircularProgressIndicator(),
                  loaded: (allArticles) {
                    if (filters.isEmpty) {
                      articles = allArticles;
                    } else {
                      articles = allArticles.where((article) => filters.contains(article.category)).toList();
                    }
                    return SizedBox(
                      height: 100 * articles.length + 15 * (articles.length - 1),
                      child: ScrollablePositionedList.separated(
                        itemCount: articles.length,
                        itemBuilder: (context, index) => ArticleWidget(article: articles[index]),
                        separatorBuilder: (context, index) => const SizedBox(height: 15),
                      ),
                    );
                  },
                  error: () => const Text('Error'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
