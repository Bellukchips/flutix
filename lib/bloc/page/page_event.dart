part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  final int bottomNavBarIndex;
  final bool isExpired;
  GoToMainPage({this.bottomNavBarIndex = 0, this.isExpired = false});
  @override
  List<Object> get props => [bottomNavBarIndex, isExpired];
}

class GoToRegisterPage extends PageEvent {
  final RegistrationUser registrationUser;
  GoToRegisterPage(this.registrationUser);
  @override
  List<Object> get props => [];
}

class GoToPreferencePage extends PageEvent {
  final RegistrationUser registrationUser;
  GoToPreferencePage(this.registrationUser);
  @override
  List<Object> get props => [];
}

class GoToConfirmationAccountPage extends PageEvent {
  final RegistrationUser registrationUser;
  GoToConfirmationAccountPage(this.registrationUser);
  @override
  List<Object> get props => [];
}

class GoToMovieDetail extends PageEvent {
  final Movie movie;
  GoToMovieDetail(this.movie);
  @override
  List<Object> get props => [movie];
}

class GoToSelectSchedulePage extends PageEvent {
  final MovieDetail movieDetail;
  GoToSelectSchedulePage(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class GoToSelectSeatPage extends PageEvent {
  final Ticket ticket;
  GoToSelectSeatPage(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class GoToCheckoutPage extends PageEvent {
  final Ticket ticket;
  GoToCheckoutPage(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class GoToSuccessPage extends PageEvent {
  final Ticket ticket;
  final FlutixTransaction transaction;

  GoToSuccessPage(this.ticket, this.transaction);
  @override
  List<Object> get props => [ticket, transaction];
}

class GoToProsessTransactionsPage extends PageEvent {
  final Ticket ticket;
  final FlutixTransaction transaction;

  GoToProsessTransactionsPage(this.ticket, this.transaction);
  @override
  List<Object> get props => [ticket, transaction];
}

class GoToProfileSetting extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToTicketDetail extends PageEvent {
  final Ticket ticket;

  GoToTicketDetail(this.ticket);
  @override
  List<Object> get props => [ticket];
}

class GoToEditProfile extends PageEvent {
  final Users user;

  GoToEditProfile(this.user);
  @override
  List<Object> get props => [user];
}

class GoToTopUpPage extends PageEvent {
  final PageEvent pageEvent;

  GoToTopUpPage(this.pageEvent);
  @override
  List<Object> get props => [pageEvent];
}

class GoToWallettPage extends PageEvent {
  final PageEvent pageEvent;

  GoToWallettPage(this.pageEvent);
  @override
  List<Object> get props => [pageEvent];
}

class GoToForgotPassword extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSplashScreen extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSeeMoreNowPlaying extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSeeMoreComingSoon extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToGenresMovie extends PageEvent {
  final String genre;
  GoToGenresMovie({this.genre});
  @override
  List<Object> get props => [genre];
}

class GoToBlankPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToNetworkPage extends PageEvent {
  final Function refresh;

  GoToNetworkPage(this.refresh);
  @override
  List<Object> get props => [refresh];
}
