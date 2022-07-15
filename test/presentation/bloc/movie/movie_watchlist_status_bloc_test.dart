import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_status_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_status_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus])
void main() {
  late MockGetWatchListStatus usecase;
  late WatchlistStatusBloc bloc;

  setUp(() {
    usecase = MockGetWatchListStatus();
    bloc = WatchlistStatusBloc(getWatchListStatus: usecase);
  });

  test('initial state should be empty', () {
    expect(bloc.state, WatchlistStatusInitial());
  });

  blocTest<WatchlistStatusBloc, WatchlistStatusState>(
    'Should emit [Loading, TrueState] when data is true',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchlistStatusEvent(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchlistStatusTrue(),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
    },
  );

  blocTest<WatchlistStatusBloc, WatchlistStatusState>(
    'Should emit [Loading, FalseState] when data is false',
    build: () {
      when(usecase.execute(tId)).thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(GetWatchlistStatusEvent(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchlistStatusFalse(),
    ],
    verify: (bloc) {
      verify(usecase.execute(tId));
    },
  );
}
