part of 'articles_bloc.dart';

@freezed
class ArticlesState with _$ArticlesState {
  const factory ArticlesState.loading() = _Loading;
  const factory ArticlesState.loaded({required List<Article> articles}) = _Loaded;
  const factory ArticlesState.error() = _Error;
}
