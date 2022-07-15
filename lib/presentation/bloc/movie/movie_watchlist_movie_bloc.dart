import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_watchlist_movie_event.dart';
part 'movie_watchlist_movie_state.dart';

class WatchlistMoviesBloc extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;
  WatchlistMoviesBloc({required this.getWatchlistMovies}) : super(WatchlistMoviesEmpty()) {
    on<WatchlistMoviesEvent>((event, emit) async {
      emit(WatchlistMoviesLoading());
      final result = await getWatchlistMovies.execute();

      result.fold(
            (failure) => emit(WatchlistMoviesError(failure.message)),
            (result) => emit(WatchlistMoviesLoaded(result)),
      );
    });
  }
}