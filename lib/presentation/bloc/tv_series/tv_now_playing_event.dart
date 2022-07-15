part of 'tv_now_playing_bloc.dart';

abstract class NowPlayingTvsEvent extends Equatable{
  const NowPlayingTvsEvent();

}
class NowPlayingTvsShow extends NowPlayingTvsEvent {
  @override
  List<Object?> get props => [];
}
