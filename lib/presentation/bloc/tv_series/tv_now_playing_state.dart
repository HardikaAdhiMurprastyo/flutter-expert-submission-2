part of 'tv_now_playing_bloc.dart';

abstract class NowPlayingTvsState extends Equatable{
  const NowPlayingTvsState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvsEmpty extends NowPlayingTvsState {
  @override
  List<Object> get props => [];
}

class NowPlayingTvsLoading extends NowPlayingTvsState {
  @override
  List<Object> get props => [];
}

class NowPlayingTvsHasData extends NowPlayingTvsState {
  final List<Tv> result;

  NowPlayingTvsHasData(this.result);

  @override
  List<Object> get props => [result];
}

class NowPlayingTvsError extends NowPlayingTvsState {
  final String message;

  NowPlayingTvsError(this.message);

  @override
  List<Object> get props => [message];
}