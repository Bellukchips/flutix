import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'comingsoon_event.dart';
part 'comingsoon_state.dart';

class ComingsoonBloc extends Bloc<ComingsoonEvent, ComingsoonState> {
  ComingsoonBloc() : super(ComingsoonInitial());

  @override
  Stream<ComingsoonState> mapEventToState(
    ComingsoonEvent event,
  ) async* {
    if (event is FetchComingSoon) {
      List<Movie> comingSoon = await MovieServices.getMoviesComingSoon(1);
      yield ComingSoonLoaded(comingSoon: comingSoon);
    }
  }
}
