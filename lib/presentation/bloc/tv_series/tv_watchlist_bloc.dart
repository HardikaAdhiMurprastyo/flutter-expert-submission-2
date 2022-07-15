import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv.dart';
import 'package:ditonton/domain/entities/tv_series/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTvs getWatchlistTvs;
  final GetTvWatchListStatus getTvWatchListStatus;
  final RemoveTvWatchlist removeTvWatchlist;
  final SaveTvWatchlist saveTvWatchlist;

  TvWatchlistBloc(
      this.getWatchlistTvs,
      this.getTvWatchListStatus,
      this.removeTvWatchlist,
      this.saveTvWatchlist
      ) : super(TvWatchlistEmpty()) {
    on<TvsWatchlist>((event, emit) async{
      emit(TvWatchlistLoading());

      final result = await getWatchlistTvs.execute();

      result.fold(
            (failure) {
          emit(TvWatchlistError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(TvWatchlistEmpty());
          } else {
            emit(TvWatchlistHasData(data));
          }
        },
      );
    });
    on<TvWatchlist>((event, emit) async {

      final id = event.id;

      final result = await getTvWatchListStatus.execute(id);

      emit(AddWatchlist(result));
    });

    on<AddTvWatchlist>((event, emit) async {
      emit(TvWatchlistLoading());
      final movie = event.tvDetail;

      final result = await saveTvWatchlist.execute(movie);

      result.fold(
            (failure) {
          emit(TvWatchlistError(failure.message));
        },
            (message) {
          emit(MessageTvWatchlist(message));
        },
      );
    });

    on<DeleteTvWatchlist>((event, emit) async {
      final movie = event.tvDetail;

      final result = await removeTvWatchlist.execute(movie);

      result.fold(
            (failure) {
          emit(TvWatchlistError(failure.message));
        },
            (message) {
          emit(MessageTvWatchlist(message));
        },
      );
    });
  }
}
