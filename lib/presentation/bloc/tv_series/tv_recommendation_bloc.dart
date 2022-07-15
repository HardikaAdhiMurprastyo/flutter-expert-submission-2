import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_recommendation_event.dart';
part 'tv_recommendation_state.dart';

class TvRecommendationBloc extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  final GetTvRecommendations getTvRecommendations;
  TvRecommendationBloc(this.getTvRecommendations) : super(TvRecommendationEmpty()) {
    on<RecommendationTvsShow>((event, emit) async{
      final id = event.id;
      emit(TvRecommendationLoading());
      final result = await getTvRecommendations.execute(id);

      result.fold(
            (failure) {
          emit(TvRecommendationError(failure.message));
        },
            (data) {
          emit(TvRecommendationHasData(data));
        },
      );
    });
  }
}