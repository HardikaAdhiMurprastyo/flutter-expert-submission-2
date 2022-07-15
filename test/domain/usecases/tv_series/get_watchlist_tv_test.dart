import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetWatchlistTvs usecase;
  late MockTvRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTvRepository();
    usecase = GetWatchlistTvs(mockTVSeriesRepository);
  });

  test('should get list of TV Series from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getWatchlistTvs())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvList));
  });
}
