part of 'movie_recommendation_bloc.dart';

abstract class MovieRecomendationState extends Equatable {
  const MovieRecomendationState();

  @override
  List<Object> get props => [];
}

class MovieRecomendationInitial extends MovieRecomendationState {}

class MovieRecomendationLoading extends MovieRecomendationState {}

class MovieRecomendationLoaded extends MovieRecomendationState {
  final List<Movie> result;

  MovieRecomendationLoaded(this.result);
}

class MovieRecomendationError extends MovieRecomendationState {
  final String message;

  MovieRecomendationError(this.message);
}