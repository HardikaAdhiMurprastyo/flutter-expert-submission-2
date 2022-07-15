part of 'movie_top_rated_bloc.dart';

@immutable
abstract class TopRatedMoviesEvent extends Equatable{
  const TopRatedMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetTopRatedMoviesEvent extends TopRatedMoviesEvent {}
