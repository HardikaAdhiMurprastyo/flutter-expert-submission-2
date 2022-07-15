import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_event_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watchlist_status_bloc.dart';
import 'package:ditonton/presentation/pages/movie/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

// import 'movie_detail_page_test.mocks.dart';
class MockMovieDetailBloc extends Mock implements MoviesDetailBloc {}
class MovieDetailStateFake extends Fake implements MoviesDetailState {}
class MovieDetailEventFake extends Fake implements MoviesDetailEvent {}
class MockWatchlistEventBloc extends Mock implements WatchlistEventBloc {}
class WatchlistEventStateFake extends Fake implements WatchlistEventState {}
class WatchlistEventEventFake extends Fake implements WatchlistEventEvent {}
class MockWatchlistStatusBloc extends Mock implements WatchlistStatusBloc {}
class WatchlistStatusEventFake extends Fake implements WatchlistStatusEvent {}
class WatchlistStatusStateFake extends Fake implements WatchlistStatusState {}
class MockRecomendationMovieBloc extends Mock implements MovieRecomendationBloc {}
class RecomendationMovieStateFake extends Fake implements MovieRecomendationState {}
class RecomendationMovieEventFake extends Fake implements MovieRecomendationEvent {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockWatchlistEventBloc mockWatchlistEventBloc;
  late MockWatchlistStatusBloc mockWatchlistStatusBloc;
  late MockRecomendationMovieBloc mockRecomendationMovieBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(WatchlistStatusEventFake());
    registerFallbackValue(WatchlistStatusStateFake());
    registerFallbackValue(WatchlistEventEventFake());
    registerFallbackValue(WatchlistEventStateFake());
    registerFallbackValue(RecomendationMovieStateFake());
    registerFallbackValue(RecomendationMovieEventFake());
  });

  setUp(() {
    mockWatchlistStatusBloc = MockWatchlistStatusBloc();
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockWatchlistEventBloc = MockWatchlistEventBloc();
    mockRecomendationMovieBloc = MockRecomendationMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesDetailBloc>.value(value: mockMovieDetailBloc),
        BlocProvider<WatchlistEventBloc>.value(
            value: mockWatchlistEventBloc),
        BlocProvider<WatchlistStatusBloc>.value(
            value: mockWatchlistStatusBloc),
        BlocProvider<MovieRecomendationBloc>.value(
            value: mockRecomendationMovieBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display progress bar when loading",
        (WidgetTester tester) async {
      //tv detail
      when(() => mockMovieDetailBloc.stream)
          .thenAnswer(((_) => Stream.value(MoviesDetailLoading())));
      when(() => mockMovieDetailBloc.state).thenReturn(MoviesDetailLoading());
      //watchlist event
      when(() => mockWatchlistEventBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistEventInitial())));
      when(() => mockWatchlistEventBloc.state)
          .thenReturn(WatchlistEventInitial());
      //watchlist status
      when(() => mockWatchlistStatusBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistStatusInitial())));
      when(() => mockWatchlistStatusBloc.state)
          .thenReturn(WatchlistStatusInitial());
      //recomendation
      when(() => mockRecomendationMovieBloc.stream)
          .thenAnswer(((_) => Stream.value(MovieRecomendationLoading())));
      when(() => mockRecomendationMovieBloc.state)
          .thenReturn(MovieRecomendationLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);
      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

      expect(progressFinder, findsOneWidget);
      expect(centerFinder, findsWidgets);
    },
  );

  testWidgets(
    "Watchlist button should display check icon when tv is added to watchlist",
        (WidgetTester tester) async {
      //tv detail
      when(() => mockMovieDetailBloc.stream).thenAnswer(
          ((_) => Stream.value(MoviesDetailHasData(testMovieDetail))));
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MoviesDetailHasData(testMovieDetail));
      //watchlist event
      when(() => mockWatchlistEventBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistEventInitial())));
      when(() => mockWatchlistEventBloc.state)
          .thenReturn(WatchlistEventInitial());
      //watchlist status
      when(() => mockWatchlistStatusBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistStatusTrue())));
      when(() => mockWatchlistStatusBloc.state)
          .thenReturn(WatchlistStatusTrue());
      //recomendation
      when(() => mockRecomendationMovieBloc.stream).thenAnswer(
          ((_) => Stream.value(MovieRecomendationLoaded(testMovieList))));
      when(() => mockRecomendationMovieBloc.state)
          .thenReturn(MovieRecomendationLoaded(testMovieList));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );


  testWidgets(
    "Watchlist button should display Snackbar when added to watchlist",
        (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.stream).thenAnswer(
          ((_) => Stream.value(MoviesDetailHasData(testMovieDetail))));
      when(() => mockMovieDetailBloc.state)
          .thenReturn(MoviesDetailHasData(testMovieDetail));
      //watchlist event
      when(() => mockWatchlistEventBloc.stream).thenAnswer(((_) =>
          Stream.value(WatchlistEventLoaded('Added to Watchlist'))));
      when(() => mockWatchlistEventBloc.state)
          .thenReturn(WatchlistEventLoaded('Added to Watchlist'));
      //watchlist status
      when(() => mockWatchlistStatusBloc.stream)
          .thenAnswer(((_) => Stream.value(WatchlistStatusFalse())));
      when(() => mockWatchlistStatusBloc.state)
          .thenReturn(WatchlistStatusFalse());
      //recomendation
      when(() => mockRecomendationMovieBloc.stream).thenAnswer(
          ((_) => Stream.value(MovieRecomendationLoaded(testMovieList))));
      when(() => mockRecomendationMovieBloc.state)
          .thenReturn(MovieRecomendationLoaded(testMovieList));

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    },
  );
}
