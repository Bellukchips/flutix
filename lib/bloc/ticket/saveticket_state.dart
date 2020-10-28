part of 'saveticket_bloc.dart';
class SaveticketState extends Equatable {
  final List<Ticket> tickets;
  const SaveticketState(this.tickets);
  
  @override
  List<Object> get props => [tickets];
}

