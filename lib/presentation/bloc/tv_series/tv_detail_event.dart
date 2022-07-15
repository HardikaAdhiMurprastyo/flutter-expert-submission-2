part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();
}
class TvDetailShow extends TvDetailEvent {
  final int id;
  TvDetailShow(this.id);

  @override
  List<Object> get props => [];
}
