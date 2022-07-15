part of 'tv_popular_bloc.dart';

@immutable
abstract class PopularTvsEvent extends Equatable {
  const PopularTvsEvent();
}
class PopularTvsShow extends PopularTvsEvent {
  @override
  List<Object?> get props => [];
}
