import 'package:get_it/get_it.dart';
import 'package:test_news_app/index.dart';

final sl = GetIt.instance;

void setup() {
  sl.registerSingleton<CategoriesBloc>(CategoriesBloc());
}
