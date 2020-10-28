part of 'credits_bloc.dart';

abstract class CreditsEvent extends Equatable {
  const CreditsEvent();
}
class LoadCredits extends CreditsEvent{
  final int id;

  LoadCredits(this.id);
  @override
  List<Object> get props => [id];
}