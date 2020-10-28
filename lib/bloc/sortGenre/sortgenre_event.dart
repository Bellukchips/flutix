part of 'sortgenre_bloc.dart';

abstract class SortgenreEvent extends Equatable {
  const SortgenreEvent();
}

class LoadSortgenreEvent extends SortgenreEvent {
  final int idgenre;

  LoadSortgenreEvent(this.idgenre);
  @override
  List<Object> get props => [idgenre];
}

class ClearSortGenres extends SortgenreEvent{
  @override
  List<Object> get props => [];
}