import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'saveticket_event.dart';
part 'saveticket_state.dart';

class SaveticketBloc extends Bloc<SaveticketEvent, SaveticketState> {
  SaveticketBloc() : super(SaveticketState([]));

  @override
  Stream<SaveticketState> mapEventToState(
    SaveticketEvent event,
  ) async* {
    if (event is BuyTicket) {
      await TicketServices.saveTicket(event.userID, event.ticket);
      //create list ticket
      List<Ticket> tickets = state.tickets + [event.ticket];
      yield SaveticketState(tickets);
    }
  }
}
