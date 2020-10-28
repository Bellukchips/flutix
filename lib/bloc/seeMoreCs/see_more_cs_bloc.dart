import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'see_more_cs_event.dart';
part 'see_more_cs_state.dart';

class SeeMoreCsBloc extends Bloc<SeeMoreCsEvent, SeeMoreCsState> {
  SeeMoreCsBloc() : super(SeeMoreCsInitial());

  @override
  Stream<SeeMoreCsState> mapEventToState(
    SeeMoreCsEvent event,
  ) async* {
    if(event is FetchSeeMoreCs){
      List<Movie> seeMore = await MovieServices.getMoviesComingSoon(2);
      yield SeeMoreCsLoaded(comingSoon: seeMore);
    }
  }
}
