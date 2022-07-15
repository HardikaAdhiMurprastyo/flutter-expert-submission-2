import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_event_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_event_bloc_test.mocks.dart';

@GenerateMocks([SaveWatchlist, RemoveWatchlist])
void main() {
  late MockSaveWatchlist saveWatchlist;
  late MockRemoveWatchlist removeWatchlist;
  late WatchlistEventBloc bloc;

  setUp(() {
    saveWatchlist = MockSaveWatchlist();
    removeWatchlist = MockRemoveWatchlist();
    bloc = WatchlistEventBloc(
      saveWatchlist: saveWatchlist,
      removeWatchlist: removeWatchlist,
    );
  });

  test('initial state should be empty', () {
    expect(bloc.state, WatchlistEventInitial());
  });

  group(
    'saveWatchListTv test',
        () {
      blocTest<WatchlistEventBloc, WatchlistEventState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(saveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Added to Watchlist'));
          return bloc;
        },
        act: (bloc) => bloc.add(AddWatchlistMovies(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          WatchlistEventLoading(),
          WatchlistEventLoaded('Added to Watchlist'),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
        },
      );

      blocTest<WatchlistEventBloc, WatchlistEventState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(saveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (bloc) => bloc.add(AddWatchlistMovies(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          WatchlistEventLoading(),
          WatchlistEventError('Server Failure'),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
        },
      );
    },
  );

  group(
    'removeWatchListTv test',
        () {
      blocTest<WatchlistEventBloc, WatchlistEventState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(removeWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Removed from Watchlist'));
          return bloc;
        },
        act: (bloc) => bloc.add(RemoveWatchlistMovies(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          WatchlistEventLoading(),
          WatchlistEventLoaded('Removed from Watchlist'),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
        },
      );

      blocTest<WatchlistEventBloc, WatchlistEventState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(removeWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return bloc;
        },
        act: (bloc) => bloc.add(RemoveWatchlistMovies(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          WatchlistEventLoading(),
          WatchlistEventError('Server Failure'),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
        },
      );
    },
  );
}
