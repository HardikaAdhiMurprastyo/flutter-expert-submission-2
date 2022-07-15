import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../dummy_data/dummy_objects.dart';

class MockTopRatedTvShowBloc extends Mock implements TopRatedTvsBloc {}
class FakeEvent extends Fake implements TopRatedTvsEvent {}
class FakeState extends Fake implements TopRatedTvsState {}

void main() {
  late MockTopRatedTvShowBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeEvent());
    registerFallbackValue(FakeState());
  });

  setUp(() {
    bloc = MockTopRatedTvShowBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvsBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display progress bar when loading",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(TvTopRatedLoading()));
      when(() => bloc.state).thenReturn(TvTopRatedLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display when data is loaded",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(TvTopRatedHasData(tTvList)));
      when(() => bloc.state).thenReturn(TvTopRatedHasData(tTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text with message when Error",
        (WidgetTester tester) async {
      when(() => bloc.stream)
          .thenAnswer((_) => Stream.value(TvTopRatedError(tError)));
      when(() => bloc.state).thenReturn(TvTopRatedError(tError));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
