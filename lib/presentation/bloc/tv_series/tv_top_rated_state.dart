part of 'tv_top_rated_bloc.dart';

abstract class TopRatedTvsState extends Equatable {
  const TopRatedTvsState();

  @override
  List<Object> get props => [];
}

class TvTopRatedEmpty extends TopRatedTvsState {
  @override
  List<Object> get props => [];
}
class TvTopRatedLoading extends TopRatedTvsState {
  @override
  List<Object> get props => [];
}

class TvTopRatedHasData extends TopRatedTvsState {
  final List<Tv> result;

  TvTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvTopRatedError extends TopRatedTvsState {
  final String message;

  TvTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}


