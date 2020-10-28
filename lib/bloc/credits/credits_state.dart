part of 'credits_bloc.dart';

abstract class CreditsState extends Equatable {
  const CreditsState();
}

class CreditsInitial extends CreditsState {
  @override
  List<Object> get props => [];
}

class CreditLoaded extends CreditsState{
  final List<Credit> credit;

  CreditLoaded(this.credit);
  @override
  List<Object> get props => [credit];
}