part of 'tv_search_bloc.dart';

@immutable
abstract class TvSearchState extends Equatable {
  const TvSearchState();
  @override
  List<Object> get props => [];
}
class TvSearchEmpty extends TvSearchState {}

class TvSearchLoading extends TvSearchState {}

class TvSearchHasData extends TvSearchState {
  final List<Tv> result;

  TvSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvSearchError extends TvSearchState {
  final String message;

  TvSearchError(this.message);

  @override
  List<Object> get props => [message];
}

