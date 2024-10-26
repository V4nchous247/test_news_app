import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_news_app/index.dart';
import 'package:test_news_app/navigation/router.gr.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key,
    required this.article,
    required this.allArticles,
  });

  final Article article;
  final List<Article> allArticles;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AutoRouter.of(context).push(ArticleRoute(article: article, allArticles: allArticles)),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                Image.asset(article.imgUrl),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            article.subTitle,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.type_specimen,
                            color: Colors.grey,
                          ),
                          Text(
                            article.category,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(article.allTimeViews.toString()),
                          const SizedBox(width: 5),
                          Text(article.lastTreeDaysViews.toString()),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
