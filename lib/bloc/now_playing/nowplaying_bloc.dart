import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'nowplaying_event.dart';
part 'nowplaying_state.dart';

class NowplayingBloc extends Bloc<NowplayingEvent, NowplayingState> {
  NowplayingBloc() : super(NowplayingInitial());

  @override
  Stream<NowplayingState> mapEventToState(
    NowplayingEvent event,
  ) async* {
    if (event is FetchNowPlaying) {
      List<Movie> nowPlaying = await MovieServices.getMovies(1);
      yield NowplayingLoaded(nowPlayingModel: nowPlaying);
    }
  }
}
