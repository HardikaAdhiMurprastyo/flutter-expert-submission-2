import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_watchlist_status_event.dart';
part 'movie_watchlist_status_state.dart';

class WatchlistStatusBloc extends Bloc<WatchlistStatusEvent, WatchlistStatusState> {
  final GetWatchListStatus getWatchListStatus;
  WatchlistStatusBloc({required this.getWatchListStatus}) : super(WatchlistStatusInitial()) {
    on<GetWatchlistStatusEvent>((event, emit) async{
      final result = await getWatchListStatus.execute(event.id);
      if (result) {
        emit(WatchlistStatusTrue());
      } else {
        emit(WatchlistStatusFalse());
      }
    });
  }
}
