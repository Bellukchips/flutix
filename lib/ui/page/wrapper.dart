part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    PreferenceManager.getPreferences(context);
    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashScreen)) {
        prevPageEvent = GoToSplashScreen();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        Timer(Duration(seconds: 2), () {
          context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
          context.bloc<TicketBloc>().add(GetTickets(firebaseUser.uid));
          prevPageEvent = GoToMainPage();
          context.bloc<PageBloc>().add(prevPageEvent);
        });
      }
    }
    return BlocBuilder<PageBloc, PageState>(
      builder: (_, pageState) => (pageState is OnLoginPage)
          ? SignInPage()
          : (pageState is OnForgotPassword)
              ? ForgotPassword()
              : (pageState is OnRegisterPage)
                  ? SignUpPage(pageState.registrationUser)
                  : (pageState is OnPreferencePage)
                      ? PreferencePage(pageState.registrationUser)
                      : (pageState is OnConfirmationAccount)
                          ? ConfirmationAccountPage(pageState.registrationUser)
                          : (pageState is OnForgotPassword)
                              ? ForgotPassword()
                              : (pageState is OnSplashScreen)
                                  ? SplashScreen()
                                  : (pageState is OnSeeMoreNowPlaying)
                                      ? SeeMoreNowPlaying()
                                      : (pageState is OnSeeMoreComingSoon)
                                          ? SeeMoreComingSoon()
                                          : (pageState is OnMainPage)
                                              ? MainPage(
                                                  bottomNavBarIndex: pageState
                                                      .bottomNavBarIndex,
                                                  isExpired:
                                                      pageState.isExpired,
                                                )
                                              : (pageState is OnEditProfile)
                                                  ? EditProfilePage(
                                                      pageState.user)
                                                  : (pageState
                                                          is OnProfileSetting)
                                                      ? ProfileSettings()
                                                      : (pageState
                                                              is OnTicketDetail)
                                                          ? TicketDetail(
                                                              pageState.ticket)
                                                          : (pageState
                                                                  is OnProsessTransactionsPage)
                                                              ? ProsesTransactions(
                                                                  pageState
                                                                      .ticket,
                                                                  pageState
                                                                      .transaction)
                                                              : (pageState
                                                                      is OnSuccessPage)
                                                                  ? SuccessPage(
                                                                      pageState
                                                                          .ticket,
                                                                      pageState
                                                                          .transaction)
                                                                  : (pageState
                                                                          is OnTopUpPage)
                                                                      ? TopUpPage(
                                                                          pageState
                                                                              .pageEvent)
                                                                      : (pageState
                                                                              is OnMovieDetail)
                                                                          ? MovieDetailPage(
                                                                              pageState.movie)
                                                                          : (pageState is OnSelectSchedulePage)
                                                                              ? SelectSchedulePage(pageState.movieDetail)
                                                                              : (pageState is OnSelectSeatPage)
                                                                                  ? SelectSeatPage(pageState.ticket)
                                                                                  : (pageState is OnCheckoutPage)
                                                                                      ? CheckoutPage(pageState.ticket)
                                                                                      : (pageState is OnWalletPage)
                                                                                          ? WalletPage(pageState.pageEvent)
                                                                                          : (pageState is OnBlankPage)
                                                                                              ? BlankScreen()
                                                                                              :(pageState is OnGenresMovie)
                                                                                              ? GenresMovie(genre: pageState.genre,)
                                                                                              : Container(),
    );
  }
}
