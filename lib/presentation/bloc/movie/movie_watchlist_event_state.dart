part of 'movie_watchlist_event_bloc.dart';

@immutable
abstract class WatchlistEventState extends Equatable{
  const WatchlistEventState();

  @override
  List<Object> get props => [];
}

class WatchlistEventInitial extends WatchlistEventState {}

class WatchlistEventLoading extends WatchlistEventState {}

class WatchlistEventLoaded extends WatchlistEventState {
  final String message;

  WatchlistEventLoaded(this.message);
}

class WatchlistEventError extends WatchlistEventState {
  final String message;

  WatchlistEventError(this.message);
}
