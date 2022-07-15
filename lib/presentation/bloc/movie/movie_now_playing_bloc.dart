import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  MovieNowPlayingBloc({required this.getNowPlayingMovies}) : super(MovieNowPlayingInitial()) {
    on<MovieNowPlayingEvent>((event, emit)  async {
      emit(MovieNowPlayingLoading());
      final result = await getNowPlayingMovies.execute();

      result.fold(
            (failure) => emit(MovieNowPlayingError(failure.message)),
            (result) => emit(MovieNowPlayingLoaded(result)),
      );
    });
  }
}
