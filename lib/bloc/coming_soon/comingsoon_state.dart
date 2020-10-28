part of 'comingsoon_bloc.dart';

abstract class ComingsoonState extends Equatable {
  const ComingsoonState();
}

class ComingsoonInitial extends ComingsoonState {
  @override
 
  List<Object> get props => [];
}

class ComingSoonLoaded extends ComingsoonState {
  final List<Movie> comingSoon;
  ComingSoonLoaded({this.comingSoon});
  @override
  List<Object> get props => [comingSoon];
}


