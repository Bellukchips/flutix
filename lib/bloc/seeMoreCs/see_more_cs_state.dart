part of 'see_more_cs_bloc.dart';

abstract class SeeMoreCsState extends Equatable {
  const SeeMoreCsState();
}

class SeeMoreCsInitial extends SeeMoreCsState {
  @override
  List<Object> get props => [];
}
class SeeMoreCsLoaded extends SeeMoreCsState{
  final List<Movie> comingSoon;

  SeeMoreCsLoaded({this.comingSoon});
  @override
  List<Object> get props => [comingSoon];
}