part of 'comingsoon_bloc.dart';

abstract class ComingsoonEvent extends Equatable {
  const ComingsoonEvent();
}

class FetchComingSoon extends ComingsoonEvent {
  @override
  List<Object> get props => [];
}

