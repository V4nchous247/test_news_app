import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:test_news_app/index.dart';

class DefaultLayout extends StatefulWidget {
  const DefaultLayout({
    super.key,
    required this.allCategories,
    required this.allArticles,
  });

  final List<String> allCategories;
  final List<Article> allArticles;

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  List<Article> articles = [];
  List<String> filters = [];
  List<String> _categories = [];

  static const String _popular = 'Популярное';
  static const String _actual = 'Читают';

  @override
  void initState() {
    initCategories();
    super.initState();
  }

  void initCategories() {
    _categories = [
      _popular,
      _actual,
      ...widget.allCategories,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
              child: ScrollablePositionedList.separated(
                itemCount: _categories.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CategoryWidget(
                  onTap: () => setState(() {
                    if (filters.contains(_categories[index])) {
                      filters.remove(_categories[index]);
                    } else {
                      filters.add(_categories[index]);
                    }
                  }),
                  title: _categories[index],
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 8),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Builder(
              builder: (context) {
                articles = widget.allArticles;
                if (filters.isNotEmpty) {
                  articles = widget.allArticles.where((article) => filters.contains(article.category)).toList();
                }
                if (filters.contains(_popular)) {
                  articles = widget.allArticles;
                  final sortedArticles = articles.where((article) => article.allTimeViews > 0).toList()
                    ..sort((a, b) => b.allTimeViews.compareTo(a.allTimeViews));
                  articles = sortedArticles;
                }
                if (filters.contains(_actual)) {
                  articles = widget.allArticles;
                  final sortedArticles = articles.where((article) => article.lastTreeDaysViews > 0).toList()
                    ..sort((a, b) => b.lastTreeDaysViews.compareTo(a.lastTreeDaysViews));
                  articles = sortedArticles;
                }
                return SizedBox(
                  height: 100 * articles.length + 15 * (articles.length - 1),
                  child: ScrollablePositionedList.separated(
                    itemCount: articles.length,
                    itemBuilder: (context, index) => ArticleWidget(
                      allArticles: articles,
                      article: articles[index],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: 15),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
