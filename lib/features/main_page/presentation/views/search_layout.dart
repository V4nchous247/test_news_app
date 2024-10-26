import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:test_news_app/index.dart';

class SearchLayout extends StatefulWidget {
  const SearchLayout({
    super.key,
    required this.allArticles,
    required this.searchController,
  });

  final List<Article> allArticles;
  final TextEditingController searchController;

  @override
  State<SearchLayout> createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<SearchLayout> {
  List<Article> filteredArticles = [];

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_onSearchChanged);
    filteredArticles = widget.allArticles;
  }

  void _onSearchChanged() {
    String searchQuery = widget.searchController.text.toLowerCase();
    setState(() {
      filteredArticles = widget.allArticles.where((article) {
        return article.title.toLowerCase().contains(searchQuery) ||
            article.subTitle.toLowerCase().contains(searchQuery) ||
            article.category.toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 100 * filteredArticles.length + 15 * (filteredArticles.length - 1),
        child: ScrollablePositionedList.separated(
          itemCount: filteredArticles.length,
          itemBuilder: (context, index) => ArticleWidget(
            allArticles: widget.allArticles,
            article: filteredArticles[index],
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 15),
        ),
      ),
    );
  }
}
