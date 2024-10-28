import 'package:test_news_app/index.dart';

@RoutePage()
class ArticlePage extends StatelessWidget {
  const ArticlePage({
    super.key,
    required this.article,
    required this.allArticles,
  });

  final Article article;
  final List<Article> allArticles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Image.asset(article.imgUrl),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                article.subTitle,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.nextArticleHint,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  ArticleWidget(
                    article: allArticles.firstWhere(
                      (newArticle) => newArticle.category == article.category && newArticle != article,
                    ),
                    allArticles: allArticles,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
