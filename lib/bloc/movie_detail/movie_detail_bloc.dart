import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
    if(event is LoadMovieDetail){
      Movie movie = await MovieServices.getDetails(event.movie,movieID: event.idMovie);
      yield MovieDetailLoaded(movie);
    }else if (event is ClearMovieDetail){
      yield MovieDetailInitial();
    }
  }
}
