import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:test_news_app/index.dart';
import 'package:test_news_app/navigation/router.gr.dart';

class BaseWidget extends StatefulWidget {
  const BaseWidget({
    super.key,
    required this.searchController,
    required this.categories,
    required this.articles,
    required this.child,
  });

  final TextEditingController searchController;
  final List<String> categories;
  final List<Article> articles;
  final Widget Function(bool isSearching) child;

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ScrollablePositionedList.separated(
            itemCount: widget.categories.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                widget.categories[index],
              ),
              onTap: () => AutoRouter.of(context).push(
                SpecificCategoryRoute(
                  allArticles: widget.articles,
                  specificCategory: widget.categories[index],
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),
        ),
      ),
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: widget.searchController,
                decoration: const InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
                autofocus: true,
              )
            : const Center(child: Text("NewYork Times")),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  widget.searchController.clear();
                }
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
      ),
      body: widget.child(_isSearching),
    );
  }
}
