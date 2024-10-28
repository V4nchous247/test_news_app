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
  List<Article> _articles = [];
  List<String> _categories = [];
  final _filters = [];

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
                    if (_filters.contains(_categories[index])) {
                      _filters.remove(_categories[index]);
                    } else {
                      _filters.add(_categories[index]);
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
                _articles = widget.allArticles;
                if (_filters.isNotEmpty) {
                  _articles = widget.allArticles.where((article) => _filters.contains(article.category)).toList();
                }
                if (_filters.contains(_popular)) {
                  _articles = widget.allArticles;
                  final sortedArticles = _articles.where((article) => article.allTimeViews > 0).toList()
                    ..sort((a, b) => b.allTimeViews.compareTo(a.allTimeViews));
                  _articles = sortedArticles;
                }
                if (_filters.contains(_actual)) {
                  _articles = widget.allArticles;
                  final sortedArticles = _articles.where((article) => article.lastTreeDaysViews > 0).toList()
                    ..sort((a, b) => b.lastTreeDaysViews.compareTo(a.lastTreeDaysViews));
                  _articles = sortedArticles;
                }
                return _articles.isNotEmpty
                    ? SizedBox(
                        height: 100 * _articles.length + 15 * (_articles.length - 1),
                        child: ScrollablePositionedList.separated(
                          itemCount: _articles.length,
                          itemBuilder: (context, index) => ArticleWidget(
                            allArticles: _articles,
                            article: _articles[index],
                          ),
                          separatorBuilder: (context, index) => const SizedBox(height: 15),
                        ),
                      )
                    : const Center(
                        child: Text(
                          'No articles in this category',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
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
