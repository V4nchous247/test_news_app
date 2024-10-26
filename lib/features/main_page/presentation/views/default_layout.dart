import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:test_news_app/index.dart';

class DefaultLayout extends StatefulWidget {
  const DefaultLayout({
    super.key,
    required this.categoriesBloc,
    required this.articlesBloc,
  });

  final CategoriesBloc categoriesBloc;
  final ArticlesBloc articlesBloc;

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  List<Article> articles = [];
  List<String> filters = [];

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
              child: BlocBuilder<CategoriesBloc, CategoriesState>(
                bloc: widget.categoriesBloc,
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
              bloc: widget.articlesBloc,
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
    );
  }
}
