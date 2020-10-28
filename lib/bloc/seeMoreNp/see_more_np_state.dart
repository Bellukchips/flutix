part of 'see_more_np_bloc.dart';

abstract class SeeMoreNpState extends Equatable {
  const SeeMoreNpState();
}

class SeeMoreNpInitial extends SeeMoreNpState {
  @override
  List<Object> get props => [];
}

class SeeMoreNpLoaded extends SeeMoreNpState{
  final List<Movie> nowPlayingModel;

  SeeMoreNpLoaded({this.nowPlayingModel});
  @override
  List<Object> get props =>[nowPlayingModel];
}