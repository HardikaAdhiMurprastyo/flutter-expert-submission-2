import 'package:ditonton/presentation/bloc/movie/movie_popular_bloc.dart';
import 'package:ditonton/presentation/pages/movie/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockPopulerMovieBloc extends Mock implements PopularMoviesBloc {}
class PopularMovieStateFake extends Fake implements PopularMoviesState {}
class PopularMovieEventFake extends Fake implements PopularMoviesEvent {}

void main() {
  late MockPopulerMovieBloc bloc;

  setUpAll(() {
    registerFallbackValue(PopularMovieStateFake());
    registerFallbackValue(PopularMovieEventFake());
  });

  setUp(() {
    bloc = MockPopulerMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display center progress bar when loading",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer(((_) => Stream.value(PopularMoviesLoading())));
      when(() => bloc.state).thenReturn(PopularMoviesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(progressBarFinder, findsOneWidget);
      expect(centerFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display ListView when data is loaded",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer(((_) => Stream.value(PopularMoviesLoaded(testMovieList))));
      when(() => bloc.state).thenReturn(PopularMoviesLoaded(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets('Page should display text with message when Error',
        (WidgetTester tester) async {
      when(() => bloc.stream).thenAnswer(
          ((_) => Stream.value(PopularMoviesError('Server Failure'))));
      when(() => bloc.state).thenReturn(PopularMoviesError('Server Failure'));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
