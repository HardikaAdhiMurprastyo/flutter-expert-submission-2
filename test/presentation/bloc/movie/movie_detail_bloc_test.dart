import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail usecase;
  late MoviesDetailBloc bloc;

  setUp(() {
    usecase = MockGetMovieDetail();
    bloc = MoviesDetailBloc(getMovieDetail: usecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, MoviesDetailInitial());
  });

  blocTest<MoviesDetailBloc, MoviesDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(OnDetailMoviesShow(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MoviesDetailLoading(),
      MoviesDetailHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
    },
  );

  blocTest<MoviesDetailBloc, MoviesDetailState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(usecase.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(OnDetailMoviesShow(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MoviesDetailLoading(),
      MoviesDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
    },
  );
}
