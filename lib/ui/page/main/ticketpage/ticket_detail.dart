part of './../../pages.dart';

class TicketDetail extends StatefulWidget {
  final Ticket ticket;
  TicketDetail(this.ticket);
  @override
  _TicketDetailState createState() => _TicketDetailState();
}

class _TicketDetailState extends State<TicketDetail> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMainPage(
            bottomNavBarIndex: 1,
            isExpired: widget.ticket.time.isBefore(DateTime.now())));
        return;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF6F7F9),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFF6F7F9),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                context.bloc<PageBloc>().add(GoToMainPage(
                    bottomNavBarIndex: 1,
                    isExpired: widget.ticket.time.isBefore(DateTime.now())));
              }),
          centerTitle: true,
          title: Text(AppLocalizations.of(context).translate('ticketDetail'),
              style: blackTextFont.copyWith(
                fontSize: 20,
              )),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 0),
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              ClipPath(
                clipper: TicketTopClipper(),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Container(
                            width: 70,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(imageBaseURL +
                                        'w500' +
                                        widget.ticket.movieDetail.posterPath),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width -
                                    2 * defaultMargin -
                                    150,
                                child: Text(
                                  widget.ticket.movieDetail.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: blackTextFont.copyWith(fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width -
                                    2 * defaultMargin -
                                    210,
                                child: Text(
                                  widget.ticket.movieDetail.genresAndLanguage,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: greyTextFont.copyWith(fontSize: 12),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              RatingStars(
                                starSize: 15,
                                color: Colors.grey,
                                voteAverage:
                                    widget.ticket.movieDetail.voteAverage,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).translate('cinema'),
                            style: greyTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Text(
                              widget.ticket.theater.name,
                              textAlign: TextAlign.end,
                              style: whiteNumberFont.copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)
                                .translate('dateAndTime'),
                            style: greyTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.ticket.time.dateAndTime,
                            textAlign: TextAlign.end,
                            style: whiteNumberFont.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)
                                .translate('seatNumber'),
                            style: greyTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            widget.ticket.seatsInString,
                            textAlign: TextAlign.end,
                            style: whiteNumberFont.copyWith(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
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
                                  .format(widget.ticket.totalPrice),
                              style: whiteNumberFont.copyWith(
                                  fontSize: 16, color: Colors.black)),
                        ],
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                           AppLocalizations.of(context).translate('paymentStatus'),
                            style: greyTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Icon(
                            MdiIcons.checkCircle,
                            color: Colors.green,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      generateDashedDivider(MediaQuery.of(context).size.width -
                          2 * defaultMargin -
                          40)
                    ],
                  ),
                ),
              ),
              ClipPath(
                clipper: TicketBottomClipper(),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    children: [
                      QrImage(
                          version: 6,
                          foregroundColor: Colors.black,
                          errorCorrectionLevel: QrErrorCorrectLevel.M,
                          padding: EdgeInsets.all(0),
                          size: 250,
                          data: widget.ticket.bookingCode),
                      SizedBox(
                        height: 9,
                      ),
                      Text(widget.ticket.bookingCode,
                          style: greyTextFont.copyWith(fontSize: 16)),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//Todo clipath bottom and top

class TicketTopClipper extends CustomClipper<Path> {
  double radius = 20;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(radius, size.height - radius, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(size.width - radius, size.height - radius,
        size.width, size.height - radius);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TicketBottomClipper extends CustomClipper<Path> {
  double radius = 20;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, radius);
    path.quadraticBezierTo(size.width - radius, radius, size.width - radius, 0);
    path.lineTo(radius, 0);
    path.quadraticBezierTo(radius, radius, 0, radius);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
