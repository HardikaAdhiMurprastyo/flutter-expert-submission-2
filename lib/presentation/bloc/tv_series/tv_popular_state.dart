part of 'tv_popular_bloc.dart';

abstract class PopularTvsState extends Equatable {
  const PopularTvsState();
  List<Object> get props => [];
}

class TvPopularEmpty extends PopularTvsState {
  List<Object> get props => [];
}

class TvPopularLoading extends PopularTvsState {
  List<Object> get props => [];
}

class TvPopularHasData extends PopularTvsState {
  final List<Tv> result;
  TvPopularHasData(this.result);
  List<Object> get props => [result];
}

class TvPopularError extends PopularTvsState {
  final String message;

  TvPopularError(this.message);

  @override
  List<Object> get props => [message];
}



