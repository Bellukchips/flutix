part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnPageInitial extends PageState {
  @override
  List<Object> get props => [];
}

class OnLoginPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnMainPage extends PageState {
  final int bottomNavBarIndex;
  final bool isExpired;
  OnMainPage({this.bottomNavBarIndex = 0, this.isExpired = false});
  @override
  List<Object> get props => [bottomNavBarIndex, isExpired];
}

class OnRegisterPage extends PageState {
  final RegistrationUser registrationUser;
  OnRegisterPage(this.registrationUser);
  @override
  List<Object> get props => [];
}

class OnPreferencePage extends PageState {
  final RegistrationUser registrationUser;
  OnPreferencePage(this.registrationUser);
  @override
  List<Object> get props => [];
}

class OnConfirmationAccount extends PageState {
  final RegistrationUser registrationUser;
  OnConfirmationAccount(this.registrationUser);
  @override
  List<Object> get props => [];
}

class OnMovieDetail extends PageState {
  final Movie movie;

  OnMovieDetail(this.movie);
  @override
  List<Object> get props => [movie];
}

class OnSelectSchedulePage extends PageState {
  final MovieDetail movieDetail;
  OnSelectSchedulePage(this.movieDetail);
  @override
  List<Object> get props => [movieDetail];
}

class OnSelectSeatPage extends PageState {
  final Ticket ticket;
  OnSelectSeatPage(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class OnCheckoutPage extends PageState {
  final Ticket ticket;
  OnCheckoutPage(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class OnSuccessPage extends PageState {
  final Ticket ticket;
  final FlutixTransaction transaction;

  OnSuccessPage(this.ticket, this.transaction);
  @override
  List<Object> get props => [ticket, transaction];
}

class OnProsessTransactionsPage extends PageState {
  final Ticket ticket;
  final FlutixTransaction transaction;

  OnProsessTransactionsPage(this.ticket, this.transaction);
  @override
  List<Object> get props => [ticket, transaction];
}

class OnProfileSetting extends PageState {
  @override
  List<Object> get props => [];
}

class OnTicketDetail extends PageState {
  final Ticket ticket;

  OnTicketDetail(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class OnEditProfile extends PageState {
  final Users user;

  OnEditProfile(this.user);
  @override
  List<Object> get props => [user];
}

class OnTopUpPage extends PageState {
  final PageEvent pageEvent;

  OnTopUpPage(this.pageEvent);
  @override
  List<Object> get props => [pageEvent];
}

class OnWalletPage extends PageState {
  final PageEvent pageEvent;

  OnWalletPage(this.pageEvent);
  @override
  List<Object> get props => [pageEvent];
}

class OnForgotPassword extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashScreen extends PageState {
  @override
  List<Object> get props => [];
}

class OnSeeMoreNowPlaying extends PageState {
  @override
  List<Object> get props => [];
}

class OnSeeMoreComingSoon extends PageState {
  @override
  List<Object> get props => [];
}

class OnGenresMovie extends PageState {
  final String genre;
  OnGenresMovie({this.genre});
  @override
  List<Object> get props => [genre];
}
class OnBlankPage extends PageState{
  @override
  List<Object> get props => [];
}