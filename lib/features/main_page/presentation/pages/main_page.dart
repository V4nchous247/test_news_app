import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:test_news_app/index.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  Future<List<String>> loadCategories() async {
    String jsonString = await rootBundle.loadString('assets/strings/categories.json');

    final data = json.decode(jsonString);
    List<String> categories = List<String>.from(data['categories']);
    return categories;
  }

  Future<List<Article>> loadArticles() async {
    String jsonString = await rootBundle.loadString('assets/strings/articles.json');

    final data = json.decode(jsonString);
    List<Article> articles = (data['articles'] as List).map((article) => Article.fromJson(article)).toList();

    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
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
                child: FutureBuilder(
                  future: loadCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final categories = snapshot.data!;
                      return ScrollablePositionedList.separated(
                        itemCount: categories.length,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => CategoryWidget(title: categories[index]),
                        separatorBuilder: (context, index) => const SizedBox(width: 8),
                      );
                    }
                  },
                ),
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
                    final articles = snapshot.data!;

                    return SizedBox(
                      height: 2285,
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
