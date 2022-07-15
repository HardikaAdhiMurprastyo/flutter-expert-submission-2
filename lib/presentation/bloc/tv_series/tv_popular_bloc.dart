import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class PopularTvsBloc extends Bloc<PopularTvsEvent, PopularTvsState> {
  final GetPopularTvs _getPopularTvs;

  PopularTvsBloc(this._getPopularTvs) : super(TvPopularEmpty()) {
    on<PopularTvsShow>((event, emit) async {
      emit(TvPopularLoading());
      final result = await _getPopularTvs.execute();

      result.fold(
            (failure) {
          emit(TvPopularError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(TvPopularEmpty());
          } else {
            emit(TvPopularHasData(data));
          }
        },
      );
    });
  }
}
