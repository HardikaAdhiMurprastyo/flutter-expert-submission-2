import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/movie/genre_model.dart';
import 'package:ditonton/data/models/tv_series/tv_season_model.dart';
import 'package:ditonton/data/models/tv_series/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_series/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mocktvRemoteDataSource;
  late MockTvLocalDataSource mocktvLocalDataSource;

  setUp(() {
    mocktvRemoteDataSource = MockTvRemoteDataSource();
    mocktvLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      tvRemoteDataSource: mocktvRemoteDataSource,
      tvLocalDataSource: mocktvLocalDataSource,
    );
  });

  final ttvModel = TvModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ["US"],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 18.591,
    posterPath: 'posterPath',
    voteAverage: 9.4,
    voteCount: 2710,
  );

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ["US"],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 18.591,
    posterPath: 'posterPath',
    voteAverage: 9.4,
    voteCount: 2710,
  );

  final tTvModelList = <TvModel>[ttvModel];
  final tTvList = <Tv>[tTv];

  group('On the air TV Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getNowPlayingTvs())
              .thenAnswer((_) async => tTvModelList);
          // act
          final result = await repository.getNowPlayingTvs();
          // assert
          verify(mocktvRemoteDataSource.getNowPlayingTvs());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvList);
        });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getNowPlayingTvs())
              .thenThrow(ServerException());
          // act
          final result = await repository.getNowPlayingTvs();
          // assert
          verify(mocktvRemoteDataSource.getNowPlayingTvs());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getNowPlayingTvs())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getNowPlayingTvs();
          // assert
          verify(mocktvRemoteDataSource.getNowPlayingTvs());
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular TV Series', () {
    test('should return TV Series list when call to data source is success',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getPopularTvs())
              .thenAnswer((_) async => tTvModelList);
          // act
          final result = await repository.getPopularTvs();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvList);
        });

    test(
        'should return server failure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getPopularTvs())
              .thenThrow(ServerException());
          // act
          final result = await repository.getPopularTvs();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getPopularTvs())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getPopularTvs();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated TV Series', () {
    test('should return TV Series list when call to data source is successful',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getTopRatedTvs())
              .thenAnswer((_) async => tTvModelList);
          // act
          final result = await repository.getTopRatedTvs();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getTopRatedTvs())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTopRatedTvs();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getTopRatedTvs())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRatedTvs();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Get TV Series Detail', () {
    final tId = 1;
    final tTvResponse = TvDetailResponse(
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      episodeRunTime: [42],
      genres: [GenreModel(id: 18, name: 'Drama')],
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
        TvSeasonModel(
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

    test(
        'should return TV Series data when the call to remote data source is successful',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getTvDetail(tId))
              .thenAnswer((_) async => tTvResponse);
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mocktvRemoteDataSource.getTvDetail(tId));
          expect(result, equals(Right(testTvDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getTvDetail(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mocktvRemoteDataSource.getTvDetail(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getTvDetail(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mocktvRemoteDataSource.getTvDetail(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get TV Series Recommendations', () {
    final tTvList = <TvModel>[];
    final tId = 1;

    test('should return data (TV Series list) when the call is successful',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getTvRecommendations(tId))
              .thenAnswer((_) async => tTvList);
          // act
          final result = await repository.getTvRecommendations(tId);
          // assert
          verify(mocktvRemoteDataSource.getTvRecommendations(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tTvList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getTvRecommendations(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvRecommendations(tId);
          // assertbuild runner
          verify(mocktvRemoteDataSource.getTvRecommendations(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mocktvRemoteDataSource.getTvRecommendations(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvRecommendations(tId);
          // assert
          verify(mocktvRemoteDataSource.getTvRecommendations(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Search TV Series', () {
    final tQuery = 'Halo';

    test('should return TV Series list when call to data source is successful',
            () async {
          // arrange
          when(mocktvRemoteDataSource.searchTvs(tQuery))
              .thenAnswer((_) async => tTvModelList);
          // act
          final result = await repository.searchTvs(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mocktvRemoteDataSource.searchTvs(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchTvs(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mocktvRemoteDataSource.searchTvs(tQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchTvs(tQuery);
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mocktvLocalDataSource.insertTvWatchlist(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistTvs(testTvDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mocktvLocalDataSource.insertTvWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistTvs(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mocktvLocalDataSource.removeTvWatchlist(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlistTvs(testTvDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mocktvLocalDataSource.removeTvWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistTvs(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mocktvLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist TVSeries', () {
    test('should return list of TV Series', () async {
      // arrange
      when(mocktvLocalDataSource.getWatchlistTvs())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTvs();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
