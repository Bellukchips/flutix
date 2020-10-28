part of 'nowplaying_bloc.dart';

abstract class NowplayingEvent extends Equatable {
  const NowplayingEvent();
}

class FetchNowPlaying extends NowplayingEvent {
  @override
  List<Object> get props => [];
}
