import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecomendationBloc extends Bloc<MovieRecomendationEvent, MovieRecomendationState> {
  final GetMovieRecommendations getMovierecomandations;
  MovieRecomendationBloc({required this.getMovierecomandations}) : super(MovieRecomendationInitial()) {
    on<GetMovieRecomendationEvent>((event, emit) async {
      emit(MovieRecomendationLoading());
      final result = await getMovierecomandations.execute(event.id);

      result.fold(
            (failure) => emit(MovieRecomendationError(failure.message)),
            (result) => emit(MovieRecomendationLoaded(result)),
      );
    });
  }
}
