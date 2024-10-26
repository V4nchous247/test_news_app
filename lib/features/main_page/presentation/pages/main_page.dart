import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_news_app/index.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
      child: (isSearching) => BlocBuilder<ArticlesBloc, ArticlesState>(
        bloc: _articlesBloc,
        builder: (context, state) {
          return state.when(
            loading: () => const CircularProgressIndicator(),
            loaded: (articles) => BlocBuilder<CategoriesBloc, CategoriesState>(
              bloc: _categoriesBloc,
              builder: (context, state) {
                return state.when(
                  loading: () => const CircularProgressIndicator(),
                  loaded: (categories) => isSearching
                      ? SearchLayout(
                          allArticles: articles,
                          searchController: _searchController,
                        )
                      : DefaultLayout(
                          allArticles: articles,
                          allCategories: categories,
                        ),
                  error: () => const Text('ERROR'),
                );
              },
            ),
            error: () => const Text('ERROR'),
          );
        },
      ),
    );
  }
}
