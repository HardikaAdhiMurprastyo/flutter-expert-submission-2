part of 'movie_watchlist_event_bloc.dart';

@immutable
abstract class WatchlistEventEvent extends Equatable{
  const WatchlistEventEvent();

  @override
  List<Object> get props => [];
}

class RemoveWatchlistMovies extends WatchlistEventEvent {
  final MovieDetail movie;

  RemoveWatchlistMovies(this.movie);
}

class AddWatchlistMovies extends WatchlistEventEvent {
  final MovieDetail movie;

  AddWatchlistMovies(this.movie);
}