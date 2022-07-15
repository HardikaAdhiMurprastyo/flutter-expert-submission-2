import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late PopularTvsBloc popularTvsBloc;
  late MockGetPopularTvs mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    popularTvsBloc = PopularTvsBloc(mockGetPopularTvs);
  });

  final tTvs = Tv(
    backdropPath: "/9hp4JNejY6Ctg9i9ItkM9rd6GE7.jpg",
    genreIds: [10764],
    id: 12610,
    name: "Robinson",
    originCountry: ["SE"],
    originalLanguage: "sv",
    originalName: "Robinson",
    overview:
    "Expedition Robinson is a Swedish reality television program in which contestants are put into survival situations, and a voting process eliminates one person each episode until a winner is determined. The format was developed in 1994 by Charlie Parsons for a United Kingdom TV production company called Planet 24, but the Swedish debut in 1997 was the first production to actually make it to television.",
    popularity: 2338.977,
    posterPath: "/sWA0Uo9hkiAtvtjnPvaqfnulIIE.jpg",
    voteAverage: 5,
    voteCount: 3,
  );
  final tTvList = <Tv>[tTvs];

  group('bloc popular tv series testing', () {
    test('initial state should be empty', () {
      expect(popularTvsBloc.state, TvPopularEmpty());
    });

    blocTest<PopularTvsBloc, PopularTvsState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return popularTvsBloc;
      },
      act: (bloc) => bloc.add(PopularTvsShow()),
      expect: () => [
        TvPopularLoading(),
        TvPopularHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvs.execute());
        return PopularTvsShow().props;
      },
    );

    blocTest<PopularTvsBloc, PopularTvsState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularTvsBloc;
      },
      act: (bloc) => bloc.add(PopularTvsShow()),
      expect: () => [
        TvPopularLoading(),
        TvPopularError('Server Failure'),
      ],
      verify: (bloc) => TvPopularLoading(),
    );
  });
}