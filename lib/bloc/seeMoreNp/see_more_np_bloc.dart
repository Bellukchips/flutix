import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'see_more_np_event.dart';
part 'see_more_np_state.dart';

class SeeMoreNpBloc extends Bloc<SeeMoreNpEvent, SeeMoreNpState> {
  SeeMoreNpBloc() : super(SeeMoreNpInitial());

  @override
  Stream<SeeMoreNpState> mapEventToState(
    SeeMoreNpEvent event,
  ) async* {
    if (event is FetchSeeMoreNp){
      List<Movie> seeMore = await MovieServices.getMovies(2);
      yield SeeMoreNpLoaded(nowPlayingModel: seeMore);
    }
  }
}
