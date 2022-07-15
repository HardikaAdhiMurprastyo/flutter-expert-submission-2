part of 'movie_detail_bloc.dart';

abstract class MoviesDetailState extends Equatable {
  const MoviesDetailState();

  @override
  List<Object> get props => [];
}

class MoviesDetailInitial extends MoviesDetailState {}
class MoviesDetailLoading extends MoviesDetailState {}

class MoviesDetailHasData extends MoviesDetailState {
  final MovieDetail result;

  MoviesDetailHasData(this.result);
}

class MoviesDetailError extends MoviesDetailState {
  final String message;

  MoviesDetailError(this.message);
}