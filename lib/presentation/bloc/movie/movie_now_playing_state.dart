part of 'movie_now_playing_bloc.dart';

@immutable
abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

class MovieNowPlayingInitial extends MovieNowPlayingState {}

class MovieNowPlayingLoading extends MovieNowPlayingState {}

class MovieNowPlayingLoaded extends MovieNowPlayingState {
  final List<Movie> result;

  MovieNowPlayingLoaded(this.result);
}

class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;

  MovieNowPlayingError(this.message);
}
