part of 'movie_watchlist_status_bloc.dart';

@immutable
abstract class WatchlistStatusState extends Equatable {
  const WatchlistStatusState();

  @override
  List<Object> get props => [];
}

class WatchlistStatusInitial extends WatchlistStatusState {}

class WatchlistStatusTrue extends WatchlistStatusState {}

class WatchlistStatusFalse extends WatchlistStatusState {}
