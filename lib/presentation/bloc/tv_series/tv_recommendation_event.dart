part of 'tv_recommendation_bloc.dart';

abstract class TvRecommendationEvent extends Equatable{
  const TvRecommendationEvent();
}
class RecommendationTvsShow extends TvRecommendationEvent {
  final int id;

  RecommendationTvsShow(this.id);

  @override
  List<Object?> get props => [];
}