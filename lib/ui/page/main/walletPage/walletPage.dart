part of './../../pages.dart';

class WalletPage extends StatefulWidget {
  final PageEvent pageEvent;
  WalletPage(this.pageEvent);
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(widget.pageEvent);
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                context.bloc<PageBloc>().add(widget.pageEvent);
              }),
          title: Text(AppLocalizations.of(context).translate('myWallet'),
              style: blackTextFont.copyWith(fontSize: 20)),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width - 2 * defaultMargin,
          height: 50,
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: mainColor,
              child: Text(
                AppLocalizations.of(context).translate('topUpWallet'),
                style: whiteTextFont.copyWith(fontSize: 16),
              ),
              onPressed: () {
                context
                    .bloc<PageBloc>()
                    .add(GoToTopUpPage(GoToWallettPage(widget.pageEvent)));
              }),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) => Column(
                  children: [
                    Container(
                      height: 185,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xFF382A74),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: Offset(0, 5))
                          ]),
                      child: Stack(
                        children: [
                          ClipPath(
                            clipper: CardReflectionClipper(),
                            child: Container(
                              height: 185,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0.1),
                                      Colors.white.withOpacity(0)
                                    ],
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      margin: EdgeInsets.only(right: 4),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xfffff2cb)),
                                    ),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: accentColor2),
                                    )
                                  ],
                                ),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'id_ID',
                                          symbol: 'IDR ',
                                          decimalDigits: 0)
                                      .format((userState as UserLoaded)
                                          .user
                                          .balance),
                                  style: whiteNumberFont.copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)
                                                .translate('cardHolder'),
                                            style: whiteTextFont.copyWith(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300)),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 125,
                                              child: Text(
                                                "${(userState as UserLoaded).user.name}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: whiteTextFont.copyWith(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            SizedBox(
                                              width: 14,
                                              height: 14,
                                              child: Image.asset(
                                                  'assets/ic_check.png'),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)
                                                .translate('cardID'),
                                            style: whiteTextFont.copyWith(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300)),
                                        Row(
                                          children: [
                                            Text(
                                              "${(userState as UserLoaded).user.id.substring(0, 10).toUpperCase()}",
                                              style: whiteTextFont.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            SizedBox(
                                              width: 14,
                                              height: 14,
                                              child: Image.asset(
                                                  'assets/ic_check.png'),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('recentTransaksi'),
                          style: blackTextFont,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    RecentTransactions(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardReflectionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 15);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class RecentTransactions extends StatefulWidget {
  @override
  _RecentTransactionsState createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  Column generateTransaction(
      List<FlutixTransaction> transactions, double width) {
    transactions.sort((transaction1, transaction2) =>
        transaction2.time.compareTo(transaction1.time));
    return Column(
      children: transactions
          .map((e) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: TransactionCard(e, width),
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 185,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (_, userState) => ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 12,
            ),
            FutureBuilder(
                future: FlutixTransactionServices.getTransaction(
                    (userState as UserLoaded).user.id),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return generateTransaction(snapshot.data,
                        MediaQuery.of(context).size.width - 2 * defaultMargin);
                  } else {
                    return Center(
                      child: SpinKitWave(
                        color: mainColor,
                        size: 60,
                      ),
                    );
                  }
                }),
            SizedBox(
              height: 220,
            )
          ],
        ),
      ),
    );
  }
}
