part of 'movie_detail_bloc.dart';

@immutable
abstract class MoviesDetailEvent extends Equatable{
  const MoviesDetailEvent();

  @override
  List<Object> get props => [];
}
class OnDetailMoviesShow extends MoviesDetailEvent{
  final int id;

  OnDetailMoviesShow(this.id);

}
