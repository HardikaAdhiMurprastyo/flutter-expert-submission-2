part of 'movie_search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Movie> result;

  SearchLoaded(this.result);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
