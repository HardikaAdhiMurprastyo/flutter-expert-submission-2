import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MoviesDetailBloc extends Bloc<MoviesDetailEvent, MoviesDetailState> {
  final GetMovieDetail getMovieDetail;
  MoviesDetailBloc({required this.getMovieDetail}) : super(MoviesDetailInitial()) {
    on<OnDetailMoviesShow>((event, emit) async {
      emit(MoviesDetailLoading());
      final result = await getMovieDetail.execute(event.id);

      result.fold(
            (failure) => emit(MoviesDetailError(failure.message)),
            (result) => emit(MoviesDetailHasData(result)),
      );
    });
  }
}