import 'package:auto_route/auto_route.dart';
import 'package:test_news_app/navigation/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, initial: true),
        AutoRoute(page: ArticleRoute.page),
      ];
}
