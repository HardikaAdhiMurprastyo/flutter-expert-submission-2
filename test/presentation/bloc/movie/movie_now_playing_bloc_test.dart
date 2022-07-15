import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/movie/movie_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late GetNowPlayingMovies usecase;
  late MovieNowPlayingBloc bloc;

  setUp(() {
    usecase = MockGetNowPlayingMovies();
    bloc = MovieNowPlayingBloc(getNowPlayingMovies: usecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, MovieNowPlayingInitial());
  });

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(GetMovieNowPlayingEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieNowPlayingLoading(),
      MovieNowPlayingLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
    },
  );

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetMovieNowPlayingEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieNowPlayingLoading(),
      MovieNowPlayingError('Server Failure'),
    ],
    verify: (bloc) {
      verify(usecase.execute());
    },
  );
}
