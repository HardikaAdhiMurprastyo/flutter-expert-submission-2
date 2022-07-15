part of 'tv_watchlist_bloc.dart';

@immutable
abstract class TvWatchlistEvent extends Equatable{
  const TvWatchlistEvent();
}

class TvsWatchlist extends TvWatchlistEvent {
  @override
  List<Object> get props => [];
}

class TvWatchlist extends TvWatchlistEvent {
  final int id;

  TvWatchlist(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvWatchlist extends TvWatchlistEvent {
  final TvDetail tvDetail;

  AddTvWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class DeleteTvWatchlist extends TvWatchlistEvent {
  final TvDetail tvDetail;

  DeleteTvWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}