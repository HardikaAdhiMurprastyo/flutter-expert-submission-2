import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_now_playing_event.dart';
part 'tv_now_playing_state.dart';

class NowPlayingTvsBloc extends Bloc<NowPlayingTvsEvent, NowPlayingTvsState> {
  final GetNowPlayingTvs getNowPlayingTvs;

  NowPlayingTvsBloc(this.getNowPlayingTvs) : super((NowPlayingTvsEmpty())) {
    on<NowPlayingTvsShow>((event, emit) async {
      emit(NowPlayingTvsLoading());
      final result = await getNowPlayingTvs.execute();
      result.fold(
            (failure) {
          emit(NowPlayingTvsError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(NowPlayingTvsEmpty());
          } else {
            emit(NowPlayingTvsHasData(data));
          }
        },
      );
    });
  }
}