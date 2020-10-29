import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/bloc/blocs.dart';
import 'package:flutix/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnPageInitial());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToSplashPage) {
      yield OnSplashPage();
    } else if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToMainPage) {
      yield OnMainPage(
          bottomNavBarIndex: event.bottomNavBarIndex,
          isExpired: event.isExpired);
    } else if (event is GoToRegisterPage) {
      yield OnRegisterPage(event.registrationUser);
    } else if (event is GoToPreferencePage) {
      yield OnPreferencePage(event.registrationUser);
    } else if (event is GoToConfirmationAccountPage) {
      yield OnConfirmationAccount(event.registrationUser);
    } else if (event is GoToMovieDetail) {
      yield OnMovieDetail(event.movie);
    } else if (event is GoToSelectSchedulePage) {
      yield OnSelectSchedulePage(event.movieDetail);
    } else if (event is GoToSelectSeatPage) {
      yield OnSelectSeatPage(event.ticket);
    } else if (event is GoToCheckoutPage) {
      yield OnCheckoutPage(event.ticket);
    } else if (event is GoToSuccessPage) {
      yield OnSuccessPage(event.ticket, event.transaction);
    } else if (event is GoToProfileSetting) {
      yield OnProfileSetting();
    } else if (event is GoToTicketDetail) {
      yield OnTicketDetail(event.ticket);
    } else if (event is GoToEditProfile) {
      yield OnEditProfile(event.user);
    } else if (event is GoToTopUpPage) {
      yield OnTopUpPage(event.pageEvent);
    } else if (event is GoToWallettPage) {
      yield OnWalletPage(event.pageEvent);
    } else if (event is GoToForgotPassword) {
      yield OnForgotPassword();
    } else if (event is GoToSplashScreen) {
      yield OnSplashScreen();
    } else if (event is GoToSeeMoreNowPlaying) {
      yield OnSeeMoreNowPlaying();
    } else if (event is GoToSeeMoreComingSoon) {
      yield OnSeeMoreComingSoon();
    } else if (event is GoToGenresMovie) {
      yield OnGenresMovie(genre: event.genre);
    } else if (event is GoToProsessTransactionsPage) {
      yield OnProsessTransactionsPage(event.ticket, event.transaction);
    } else if (event is GoToBlankPage) {
      yield OnBlankPage();
    } else if (event is GoToNetworkPage) {
      yield OnNetworkPage(event.refresh);
    }
  }
}
