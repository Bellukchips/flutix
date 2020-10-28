part of 'sortgenre_bloc.dart';

abstract class SortgenreState extends Equatable {
  const SortgenreState();
}

class SortgenreInitial extends SortgenreState {
  @override
  List<Object> get props => [];
}

class SortgenreLoaded extends SortgenreState {
  final List<Movie> movie;

  SortgenreLoaded(this.movie);
  @override
  List<Object> get props => [movie];
}
