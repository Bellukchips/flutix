part of './../../../pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;
  CheckoutPage(this.ticket);
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
    NotificationManager.initializing();
  }

  @override
  Widget build(BuildContext context) {
    int total = widget.ticket.theater.price * widget.ticket.seats.length;
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSelectSeatPage(widget.ticket));

        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                context.bloc<PageBloc>().add(GoToSelectSeatPage(widget.ticket));
              }),
          title: Text(
            AppLocalizations.of(context).translate('checkoutMovie'),
            style: blackTextFont.copyWith(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 25),
          child: ListView(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) {
                  Users user = (userState as UserLoaded).user;
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 130,
                            margin:
                                EdgeInsets.only(left: defaultMargin, right: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(imageBaseURL +
                                        'w342' +
                                        widget.ticket.movieDetail.posterPath),
                                    fit: BoxFit.cover)),
                            child: Container(
                              height: 130,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.61),
                                        Colors.black.withOpacity(0)
                                      ])),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    2 * defaultMargin -
                                    100 -
                                    20,
                                child: Text(widget.ticket.movieDetail.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        blackTextFont.copyWith(fontSize: 20)),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width -
                                    2 * defaultMargin -
                                    100 -
                                    20,
                                margin: EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                    widget.ticket.movieDetail.genresAndLanguage,
                                    style: blackTextFont.copyWith(
                                        fontSize: 12, color: Colors.grey)),
                              ),
                              RatingStars(
                                voteAverage:
                                    widget.ticket.movieDetail.voteAverage,
                                color: accentColor3,
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 20, horizontal: defaultMargin),
                        child: Divider(
                          color: Color(0xffe4e4e4),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('orderID'),
                              style: greyTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              widget.ticket.bookingCode,
                              style: blackNumberFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('cinema'),
                              style: greyTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Text(
                                widget.ticket.theater.name,
                                textAlign: TextAlign.end,
                                style: blackNumberFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('dateAndTime'),
                              style: greyTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              widget.ticket.time.dateAndTime,
                              style: blackNumberFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('seatNumber'),
                              style: greyTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Text(
                                widget.ticket.seatsInString,
                                textAlign: TextAlign.end,
                                style: blackNumberFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('price'),
                              style: greyTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              NumberFormat.currency(
                                          locale: "id_ID",
                                          decimalDigits: 0,
                                          symbol: "IDR ")
                                      .format(widget.ticket.theater.price) +
                                  " x ${widget.ticket.seats.length}",
                              style: blackNumberFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('fee'),
                              style: greyTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "IDR 1.500 x ${widget.ticket.seats.length}",
                              style: blackNumberFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('total'),
                              style: greyTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: "id_ID",
                                      decimalDigits: 0,
                                      symbol: "IDR ")
                                  .format(total),
                              style: blackNumberFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 20, horizontal: defaultMargin),
                        child: Divider(
                          color: Color(0xffe4e4e4),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('myWallet'),
                              style: greyTextFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: "id_ID",
                                      decimalDigits: 0,
                                      symbol: "IDR ")
                                  .format(user.balance),
                              style: blackNumberFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: user.balance >= total
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ],
                        ),
                      ),
                      //button
                      Container(
                        width: 250,
                        height: 46,
                        margin: EdgeInsets.only(top: 36, bottom: 50),
                        child: RaisedButton(
                          elevation: 0,
                          color: user.balance >= total
                              ? Color(0xff3e9d9d)
                              : mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            user.balance >= total
                                ? AppLocalizations.of(context)
                                    .translate('checkoutNow')
                                : AppLocalizations.of(context)
                                    .translate('topUpWallet'),
                            style: whiteNumberFont.copyWith(fontSize: 15),
                          ),
                          onPressed: () {
                            if (user.balance >= total) {
                              var random = Random();
                              context.bloc<PageBloc>().add(
                                  GoToProsessTransactionsPage(
                                      widget.ticket.copyWith(totalPrice: total),
                                      FlutixTransaction(
                                          id: random.nextInt(1000000),
                                          userID: user.id,
                                          title:
                                              widget.ticket.movieDetail.title,
                                          subtitle: widget.ticket.theater.name,
                                          time: DateTime.now(),
                                          amount: -total,
                                          picture: widget
                                              .ticket.movieDetail.posterPath)));
                            } else {
                              context.bloc<PageBloc>().add(GoToTopUpPage(
                                  GoToCheckoutPage(widget.ticket)));
                            }
                          },
                        ),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
