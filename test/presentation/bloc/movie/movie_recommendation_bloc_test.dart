import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations usecase;
  late MovieRecomendationBloc bloc;

  setUp(() {
    usecase = MockGetMovieRecommendations();
    bloc = MovieRecomendationBloc(getMovierecomandations: usecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, MovieRecomendationInitial());
  });

  blocTest<MovieRecomendationBloc, MovieRecomendationState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetMovieRecomendationEvent(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieRecomendationLoading(),
      MovieRecomendationLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
    },
  );

  blocTest<MovieRecomendationBloc, MovieRecomendationState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetMovieRecomendationEvent(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieRecomendationLoading(),
      MovieRecomendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
    },
  );
}
