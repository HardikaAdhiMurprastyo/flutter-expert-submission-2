import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/genre.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/entities/tv_series/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_series/tv_season.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvs,
  GetTvWatchListStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist,
])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetWatchlistTvs mockGetWatchlistTvs;
  late MockGetTvWatchListStatus mockGetWatchListTvStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    mockGetWatchListTvStatus = MockGetTvWatchListStatus();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    tvWatchlistBloc = TvWatchlistBloc(
      mockGetWatchlistTvs,
      mockGetWatchListTvStatus,
      mockRemoveTvWatchlist,
      mockSaveTvWatchlist,
    );
  });

  final tId = 1;

  final testTvDetail = TvDetail(
    backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
    episodeRunTime: [42],
    genres: [Genre(id: 18, name: 'Drama')],
    homepage: "https://www.telemundo.com/shows/pasion-de-gavilanes",
    id: 1,
    name: "name",
    numberOfEpisodes: 259,
    numberOfSeasons: 2,
    originalName: "Pasión de gavilanes",
    overview: "overview",
    popularity: 1747.047,
    posterPath: "posterPath",
    seasons: [
      Season(
        episodeCount: 188,
        id: 72643,
        name: "Season 1",
        posterPath: "/elrDXqvMIX3EcExwCenQMVVmnvd.jpg",
        seasonNumber: 1,
      )
    ],
    status: "Returning Series",
    type: "Scripted",
    voteAverage: 7.6,
    voteCount: 1803,
  );

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

  group('bloc watch list tv series testing', () {
    test('initial state should be empty', () {
      expect(tvWatchlistBloc.state, TvWatchlistEmpty());
    });

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when( mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Right(tTvList));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(TvsWatchlist()),
      expect: () => [
        TvWatchlistLoading(),
        TvWatchlistHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvs.execute());
        return TvsWatchlist().props;
      },
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when( mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(TvsWatchlist()),
      expect: () => [
        TvWatchlistLoading(),
        TvWatchlistError('Server Failure'),
      ],
      verify: (bloc) => TvWatchlistLoading(),
    );
  });

  group('bloc status watch list tv series testing', () {
    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchListTvStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(TvWatchlist(tId)),
      expect: () => [AddWatchlist(true)],
      verify: (bloc) {
        verify(mockGetWatchListTvStatus.execute(tId));
        return TvWatchlist(tId).props;
      },
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchListTvStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(TvWatchlist(tId)),
      expect: () => [AddWatchlist(false)],
      verify: (bloc) => TvWatchlistLoading(),
    );
  });

  group('bloc add watch list tv series testing', () {
    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSaveTvWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(AddTvWatchlist(testTvDetail)),
      expect: () => [
        TvWatchlistLoading(),
        MessageTvWatchlist('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveTvWatchlist.execute(testTvDetail));
        return AddTvWatchlist(testTvDetail).props;
      },
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSaveTvWatchlist.execute(testTvDetail)).thenAnswer(
                (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(AddTvWatchlist(testTvDetail)),
      expect: () => [
        TvWatchlistLoading(),
        TvWatchlistError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => AddTvWatchlist(testTvDetail),
    );
  });

  group('bloc remove watch list tv series testing', () {
    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockRemoveTvWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteTvWatchlist(testTvDetail)),
      expect: () => [
        MessageTvWatchlist('Delete to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveTvWatchlist.execute(testTvDetail));
        return DeleteTvWatchlist(testTvDetail).props;
      },
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockRemoveTvWatchlist.execute(testTvDetail))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(DeleteTvWatchlist(testTvDetail)),
      expect: () => [
        TvWatchlistError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => DeleteTvWatchlist(testTvDetail),
    );
  });
}