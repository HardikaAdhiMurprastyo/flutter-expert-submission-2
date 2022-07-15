part of 'movie_watchlist_movie_bloc.dart';

@immutable
abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}
class GetWatchlistMovieEvent extends WatchlistMoviesEvent {}

