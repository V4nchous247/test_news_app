import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:test_news_app/index.dart';

@RoutePage()
class SpecificCategoryPage extends StatelessWidget {
  const SpecificCategoryPage({
    super.key,
    required this.allArticles,
    required this.specificCategory,
  });

  final String specificCategory;
  final List<Article> allArticles;

  @override
  Widget build(BuildContext context) {
    final articles = allArticles.where((article) => article.category == specificCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(specificCategory),
      ),
      body: articles.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 100 * articles.length + 15 * (articles.length - 1),
                child: ScrollablePositionedList.separated(
                  itemCount: articles.length,
                  itemBuilder: (context, index) => ArticleWidget(
                    allArticles: articles,
                    article: articles[index],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                ),
              ),
            )
          : Center(
              child: Text(
                AppLocalizations.of(context)!.emptyCategoryPlaceholder,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
    );
  }
}
