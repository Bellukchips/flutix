import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'credits_event.dart';
part 'credits_state.dart';

class CreditsBloc extends Bloc<CreditsEvent, CreditsState> {
  CreditsBloc() : super(CreditsInitial());

  @override
  Stream<CreditsState> mapEventToState(
    CreditsEvent event,
  ) async* {
    if(event is LoadCredits){
      List<Credit> credit = await MovieServices.getCredits(event.id);
      yield CreditLoaded(credit);
    }
  }
}
