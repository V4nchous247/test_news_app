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

  @override
  void initState() {
    _categoriesBloc.add(const CategoriesEvent.fetch());
    super.initState();
  }

  @override
  void dispose() {
    _categoriesBloc.close();
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
                // child: FutureBuilder(
                //   future: loadCategories(),
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const CircularProgressIndicator();
                //     } else if (snapshot.hasError) {
                //       return Text('Error: ${snapshot.error}');
                //     } else {
                //       final categories = snapshot.data!;
                //       return ScrollablePositionedList.separated(
                //         itemCount: categories.length,
                //         padding: const EdgeInsets.symmetric(horizontal: 10),
                //         scrollDirection: Axis.horizontal,
                //         itemBuilder: (context, index) => CategoryWidget(
                //           onTap: () => setState(() {
                //             if (filters.contains(categories[index])) {
                //               filters.remove(categories[index]);
                //             } else {
                //               filters.add(categories[index]);
                //             }
                //           }),
                //           title: categories[index],
                //         ),
                //         separatorBuilder: (context, index) => const SizedBox(width: 8),
                //       );
                //     }
                //   },
                // ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: loadArticles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (filters.isEmpty) {
                      articles = snapshot.data!;
                    } else {
                      articles = snapshot.data!.where((article) => filters.contains(article.category)).toList();
                    }
                    return SizedBox(
                      height: 100 * articles.length + 15 * (articles.length - 1),
                      child: ScrollablePositionedList.separated(
                        itemCount: articles.length,
                        itemBuilder: (context, index) => ArticleWidget(article: articles[index]),
                        separatorBuilder: (context, index) => const SizedBox(height: 15),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
