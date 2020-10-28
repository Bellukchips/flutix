import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/bloc/blocs.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketInitial());

  @override
  Stream<TicketState> mapEventToState(
    TicketEvent event,
  ) async* {
    if (event is GetTickets) {
      List<Ticket> tickets = await TicketServices.getTicket(event.userID);
      yield TicketLoaded(tickets);
    } else if (event is ClearLoadTicket) {
      yield TicketInitial();
    }
  }
}
