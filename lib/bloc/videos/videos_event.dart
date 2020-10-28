part of 'videos_bloc.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();
}
class LoadVideosMovie extends VideosEvent{
  final int id;

  LoadVideosMovie(this.id);
  @override
  List<Object> get props => [];
}