import 'package:ditonton/data/models/tv_series/tv_model.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final seriesModel = TvModel(
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

  final seriestV = Tv(
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

  test('should be a subclass of Movie entity', () async {
    final result = seriesModel.toEntity();
    expect(result, seriestV);
  });
}
