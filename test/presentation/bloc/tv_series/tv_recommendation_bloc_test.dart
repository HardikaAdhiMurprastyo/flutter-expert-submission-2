import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvRecommendationBloc tvRecommendationBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvRecommendationBloc =
        TvRecommendationBloc(mockGetTvRecommendations);
  });

  const tId = 1;

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

  group('bloc recomendation tv series testing', () {
    test('initial state should be empty', () {
      expect(tvRecommendationBloc.state, TvRecommendationEmpty());
    });

    blocTest<TvRecommendationBloc, TvRecommendationState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvList));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(RecommendationTvsShow(tId)),
      expect: () => [
        TvRecommendationLoading(),
        TvRecommendationHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(tId));
        return RecommendationTvsShow(tId).props;
      },
    );

    blocTest<TvRecommendationBloc, TvRecommendationState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvRecommendationBloc;
      },
      act: (bloc) => bloc.add(RecommendationTvsShow(tId)),
      expect: () => [
        TvRecommendationLoading(),
        TvRecommendationError('Server Failure'),
      ],
      verify: (bloc) => TvRecommendationLoading(),
    );
  });
}