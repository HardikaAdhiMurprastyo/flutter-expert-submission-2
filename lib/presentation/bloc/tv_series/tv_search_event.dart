part of 'tv_search_bloc.dart';

abstract class SeriesSearchEvent extends Equatable{
  const SeriesSearchEvent();
}

class queryChanged extends SeriesSearchEvent {
  final String query;

  queryChanged(this.query);

  @override
  List<Object> get props => [query];
}