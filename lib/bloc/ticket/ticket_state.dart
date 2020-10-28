part of 'ticket_bloc.dart';

abstract class TicketState extends Equatable {
  const TicketState();
}

class TicketInitial extends TicketState {
  @override
  List<Object> get props => [];
}

class TicketLoaded extends TicketState {
  final List<Ticket> ticket;
  TicketLoaded(this.ticket);
  @override
  List<Object> get props => [ticket];
}
