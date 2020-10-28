part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class LoadMovieDetail extends MovieDetailEvent{
  final int idMovie;
  final Movie movie;
  LoadMovieDetail(this.idMovie,this.movie);
  @override
  List<Object> get props => [idMovie,movie];
}
class ClearMovieDetail extends MovieDetailEvent{
  @override
  List<Object> get props => [];
}