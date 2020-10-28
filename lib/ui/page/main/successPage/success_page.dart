part of '../../pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;
  SuccessPage(this.ticket, this.transaction);
  @override
  Widget build(BuildContext context) {
    NotificationManager.initializing();
    if (ticket != null) {
      NotificationManager.showNotifications(
          id: transaction.id,
          title: AppLocalizations.of(context).translate('succesBuyTicket'),
          body: AppLocalizations.of(context).translate('cinemaMovie') +
              ticket.movieDetail.title);
    } else {
      NotificationManager.showNotifications(
          id: transaction.id,
          title:
              AppLocalizations.of(context).translate('succesTransactionTopUp'),
          body: AppLocalizations.of(context).translate('youTopUpBalance') +
              NumberFormat.currency(
                      locale: 'id_ID', decimalDigits: 0, symbol: 'IDR ')
                  .format(transaction.amount));
    }
    return WillPopScope(
        onWillPop: () {
          return;
        },
        child: Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 150,
                height: 150,
                margin: EdgeInsets.only(bottom: 70),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ticket == null
                        ? "assets/top_up_done.png"
                        : "assets/ticket_done.png"),
                  ),
                )),
            Text(
              ticket == null
                  ? AppLocalizations.of(context).translate('emmYummy')
                  : AppLocalizations.of(context).translate('happyWatching'),
              style: blackTextFont.copyWith(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              (ticket == null)
                  ? AppLocalizations.of(context)
                      .translate('subtitleSuccesPageTopUp')
                  : AppLocalizations.of(context)
                      .translate('subtitleSuccessPageTicket'),
              textAlign: TextAlign.center,
              style: blackTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w300),
            ),
            //button
            Container(
              height: 45,
              width: 250,
              margin: EdgeInsets.only(top: 70, bottom: 20),
              child: RaisedButton(
                onPressed: () {
                  if (ticket == null) {
                    context
                        .bloc<PageBloc>()
                        .add(GoToWallettPage(GoToMainPage()));
                    context.bloc<UserBloc>().add(LoadUser(transaction.userID));
                  } else {
                    context.bloc<UserBloc>().add(LoadUser(transaction.userID));
                    context.bloc<TicketBloc>().add(ClearLoadTicket());
                    context
                        .bloc<PageBloc>()
                        .add(GoToMainPage(bottomNavBarIndex: 1));
                  }
                },
                elevation: 0,
                color: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  ticket == null
                      ? AppLocalizations.of(context).translate('myWallet')
                      : AppLocalizations.of(context).translate('myTicket'),
                  style: whiteTextFont.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context).translate('discoverNewMovie'),
                  style: greyTextFont.copyWith(fontWeight: FontWeight.w400),
                ),
                InkWell(
                  onTap: () {
                    context.bloc<UserBloc>().add(LoadUser(transaction.userID));
                    context.bloc<TicketBloc>().add(ClearLoadTicket());
                    context.bloc<PageBloc>().add(GoToMainPage());
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('backToHome'),
                    style: purpleTextFont,
                  ),
                )
              ],
            )
          ],
        )));
  }
}
