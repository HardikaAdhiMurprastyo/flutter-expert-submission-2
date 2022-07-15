import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetPopularTvs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTvs(mockTvRepository);
  });

  final tTVSeries = <Tv>[];

  group('GetPopularTV Series Tests', () {
    group('execute', () {
      test(
          'should get list of TV Series from the repository when execute function is called',
              () async {
            // arrange
            when(mockTvRepository.getPopularTvs())
                .thenAnswer((_) async => Right(tTVSeries));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(tTVSeries));
          });
    });
  });
}
