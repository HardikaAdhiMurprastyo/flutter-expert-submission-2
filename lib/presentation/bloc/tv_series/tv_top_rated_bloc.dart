import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TopRatedTvsBloc extends Bloc<TopRatedTvsEvent, TopRatedTvsState> {
  final GetTopRatedTvs getTopRatedTVSeries;

  TopRatedTvsBloc(this.getTopRatedTVSeries) : super(TvTopRatedEmpty()) {
    on<TopRatedTvsShow>((event, emit) async {
      emit(TvTopRatedLoading());
      final result = await getTopRatedTVSeries.execute();
      result.fold(
            (failure) {
          emit(TvTopRatedError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(TvTopRatedEmpty());
          } else {
            emit(TvTopRatedHasData(data));
          }
        },
      );
    });
  }
}
