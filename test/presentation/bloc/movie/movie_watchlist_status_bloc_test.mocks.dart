// Mocks generated by Mockito 5.1.0 from annotations
// in ditonton/test/presentation/bloc/movie/movie_watchlist_status_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:ditonton/domain/repositories/movie_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieRepository_0 extends _i1.Fake implements _i2.MovieRepository {}

/// A class which mocks [GetWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatus extends _i1.Mock
    implements _i3.GetWatchListStatus {
  MockGetWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i4.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
}
