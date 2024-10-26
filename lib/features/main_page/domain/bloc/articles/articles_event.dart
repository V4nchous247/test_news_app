part of 'articles_bloc.dart';

@freezed
class ArticlesEvent with _$ArticlesEvent {
  const factory ArticlesEvent.fetch() = _Fetch;
}
