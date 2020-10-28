part of './../../pages.dart';

class TicketPage extends StatefulWidget {
  final bool isExpiredTicket;
  TicketPage({this.isExpiredTicket = false});
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpiredTicket;
  @override
  void initState() {
    isExpiredTicket = widget.isExpiredTicket;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          BlocBuilder<TicketBloc, TicketState>(builder: (_, ticketState) {
            if (ticketState is TicketLoaded) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: TicketCard(
                    isExpiredTicket
                        ? ticketState.ticket
                            .where((tickets) =>
                                tickets.time.isBefore(DateTime.now()))
                            .toList()
                        : ticketState.ticket
                            .where((tickets) =>
                                !tickets.time.isBefore(DateTime.now()))
                            .toList(),
                  ));
            } else {
              return Center(
                  child: SpinKitWave(
                    color: mainColor,
                    size: 60,
                  ),
                );
            }
          }),
          SafeArea(
              child: ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              height: 113,
              color: accentColor1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 24, bottom: 32),
                      child: Text(
                        AppLocalizations.of(context).translate('myTicket'),
                        style: whiteTextFont.copyWith(
                          fontSize: 20,
                        ),
                      )),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isExpiredTicket = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                                AppLocalizations.of(context)
                                    .translate('newest'),
                                style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width * 0.5,
                              color: !isExpiredTicket
                                  ? accentColor2
                                  : Colors.transparent,
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isExpiredTicket = true;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                                AppLocalizations.of(context)
                                    .translate('history'),
                                style: whiteTextFont.copyWith(
                                  fontSize: 16,
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 4,
                              width: MediaQuery.of(context).size.width * 0.5,
                              color: isExpiredTicket
                                  ? accentColor2
                                  : Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 20, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//Todo ticket card

class TicketCard extends StatelessWidget {
  final List<Ticket> tickets;
  TicketCard(
    this.tickets,
  );
  @override
  Widget build(BuildContext context) {
    var sortedTicket = tickets;
    sortedTicket
        .sort((ticket1, ticket2) => ticket1.time.compareTo(ticket2.time));
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: sortedTicket.length,
      itemBuilder: (_, index) => InkWell(
        onTap: () {
          context.bloc<PageBloc>().add(GoToTicketDetail(sortedTicket[index]));
        },
        child: Container(
          margin: EdgeInsets.only(
              top: index == 0 ? 133 : 10,
              bottom: (index == sortedTicket.length - 1) ? 100 : 0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.61),
                            Colors.black.withOpacity(0)
                          ])),
                  child: Container(
                    width: 70,
                    height: 90,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(imageBaseURL +
                                'w500' +
                                sortedTicket[index].movieDetail.posterPath),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      2 * defaultMargin -
                      70 -
                      16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          sortedTicket[index].movieDetail.title,
                          style: blackTextFont.copyWith(fontSize: 18),
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          sortedTicket[index].movieDetail.genresAndLanguage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: greyTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        sortedTicket[index].theater.name,
                        style: greyTextFont.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
