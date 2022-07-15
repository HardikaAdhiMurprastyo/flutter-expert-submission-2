import 'package:ditonton/presentation/bloc/tv_series/tv_popular_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series/populer_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockPopularTvShowBloc extends Mock implements PopularTvsBloc {}
class FakeEvent extends Fake implements PopularTvsEvent {}
class FakeState extends Fake implements PopularTvsState {}

void main() {
  late MockPopularTvShowBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeEvent());
    registerFallbackValue(FakeState());
  });

  setUp(() {
    bloc = MockPopularTvShowBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvsBloc>.value(
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
          .thenAnswer(((_) => Stream.value(TvPopularLoading())));
      when(() => bloc.state).thenReturn(TvPopularLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

      expect(progressBarFinder, findsOneWidget);
      expect(centerFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display ListView when data is loaded",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer(((_) => Stream.value(TvPopularHasData(tTvList))));
      when(() => bloc.state).thenReturn(TvPopularHasData(tTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text with message when Error",
        (WidgetTester tester) async {
      when(() => bloc.stream).thenAnswer(
          ((_) => Stream.value(TvPopularError('Server Failure'))));
      when(() => bloc.state)
          .thenReturn(TvPopularError('Server Failure'));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
