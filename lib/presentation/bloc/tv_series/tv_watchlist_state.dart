part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable{
  const TvWatchlistState();
  @override
  List<Object> get props => [];
}

class TvWatchlistEmpty extends TvWatchlistState {
  @override
  List<Object> get props => [];
}

class TvWatchlistLoading extends TvWatchlistState {
  @override
  List<Object> get props => [];
}

class TvWatchlistHasData extends TvWatchlistState {
  final List<Tv> result;

  TvWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvWatchlistError extends TvWatchlistState {
  final String message;
  TvWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class AddWatchlist extends TvWatchlistState {
  final bool status;

  AddWatchlist(this.status);

  @override
  List<Object> get props => [status];
}

class MessageTvWatchlist extends TvWatchlistState {
  final String message;

  MessageTvWatchlist(this.message);

  @override
  List<Object> get props => [message];
}