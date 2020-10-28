import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'sortgenre_event.dart';
part 'sortgenre_state.dart';

class SortgenreBloc extends Bloc<SortgenreEvent, SortgenreState> {
  SortgenreBloc() : super(SortgenreInitial());

  @override
  Stream<SortgenreState> mapEventToState(
    SortgenreEvent event,
  ) async* {
    if (event is LoadSortgenreEvent) {
      List<Movie> movie = await MovieServices.sortGenreMovie(event.idgenre);
      yield SortgenreLoaded(movie);
    } else if (event is ClearSortGenres) {
      yield SortgenreInitial();
    }
  }
}
