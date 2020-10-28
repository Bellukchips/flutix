part of 'saveticket_bloc.dart';

abstract class SaveticketEvent extends Equatable {
  const SaveticketEvent();
}

class BuyTicket extends SaveticketEvent {
  final Ticket ticket;
  final String userID;

  BuyTicket(this.ticket, this.userID);
  @override
  List<Object> get props => [ticket, userID];
}
