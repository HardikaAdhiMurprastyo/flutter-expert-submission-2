part of 'movie_watchlist_status_bloc.dart';

@immutable
abstract class WatchlistStatusEvent extends Equatable{
  const WatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class GetWatchlistStatusEvent extends WatchlistStatusEvent {
  final int id;

  GetWatchlistStatusEvent(this.id);
}
