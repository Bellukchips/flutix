part of 'nowplaying_bloc.dart';

abstract class NowplayingState extends Equatable {
  const NowplayingState();
}

class NowplayingInitial extends NowplayingState {
  @override
  List<Object> get props => [];
}

class NowplayingLoaded extends NowplayingState {
  final List<Movie> nowPlayingModel;
  NowplayingLoaded({this.nowPlayingModel});
  @override
  List<Object> get props => [nowPlayingModel];
}
