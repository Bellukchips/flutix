import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      Users user = await UsersServices.getUser(event.id);
      yield UserLoaded(user);
    } else if (event is SignOut) {
      yield UserInitial();
    } else if (event is UpdateData) {
      if (state is UserLoaded) {
        try {
          Users updateUser = (state as UserLoaded).user.copyWith(
              name: event.name,
              profilePicture: event.profileImage,
              selectedGenres: event.selectedGenres,
              selectedLanguage: event.selectedLanguage);
          await UsersServices.updateUser(updateUser);
          yield UserLoaded(updateUser);
        } catch (e) {
          print(e);
        }
      }
    } else if (event is TopUp) {
      if (state is UserLoaded) {
        try {
          Users userUpdate = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance + event.amount);
          await UsersServices.updateUser(userUpdate);
          yield UserLoaded(userUpdate);
        } catch (e) {
          print(e);
        }
      }
    } else if (event is Purchase) {
      if (state is UserLoaded) {
        try {
          Users userUpdate = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance - event.amount);
          await UsersServices.updateUser(userUpdate);
          yield UserLoaded(userUpdate);
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
