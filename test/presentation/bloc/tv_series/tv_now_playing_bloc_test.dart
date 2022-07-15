import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_now_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs])
void main() {
  late NowPlayingTvsBloc TvNowPlayingBloc;
  late MockGetNowPlayingTvs mockOnTheAirTvseries;

  setUp(() {
    mockOnTheAirTvseries = MockGetNowPlayingTvs();
    TvNowPlayingBloc =
        NowPlayingTvsBloc(mockOnTheAirTvseries);
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

  group('bloc airing today tv series testing', () {
    test('initial state should be empty', () {
      expect(TvNowPlayingBloc.state, NowPlayingTvsEmpty());
    });

    blocTest<NowPlayingTvsBloc, NowPlayingTvsState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockOnTheAirTvseries.execute())
            .thenAnswer((_) async => Right(tTvList));
        return TvNowPlayingBloc;
      },
      act: (bloc) => bloc.add(NowPlayingTvsShow()),
      expect: () => [
        NowPlayingTvsLoading(),
        NowPlayingTvsHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockOnTheAirTvseries.execute());
        return NowPlayingTvsShow().props;
      },
    );

    blocTest<NowPlayingTvsBloc, NowPlayingTvsState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockOnTheAirTvseries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return TvNowPlayingBloc;
      },
      act: (bloc) => bloc.add(NowPlayingTvsShow()),
      expect: () => [
        NowPlayingTvsLoading(),
        NowPlayingTvsError('Server Failure'),
      ],
      verify: (bloc) => NowPlayingTvsLoading(),
    );
  });
}