part of '../../../pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;
  SelectSeatPage(this.ticket);
  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedOfSeats = [];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context
            .bloc<PageBloc>()
            .add(GoToSelectSchedulePage(widget.ticket.movieDetail));
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(left: defaultMargin - 20, top: 3),
                          padding: EdgeInsets.all(1),
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                context.bloc<PageBloc>().add(
                                    GoToSelectSchedulePage(
                                        widget.ticket.movieDetail));
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: defaultMargin),
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 16),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    widget.ticket.movieDetail.title ?? "",
                                    style: blackTextFont.copyWith(fontSize: 20),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  )),
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: NetworkImage(imageBaseURL +
                                                "w154" +
                                                widget.ticket.movieDetail
                                                    .posterPath ??
                                            widget.ticket.movieDetail
                                                .backdropPath),
                                        fit: BoxFit.cover)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/screen.png"))),
                    ),
                    //List Seats
                    generateSeats(),
                    SizedBox(
                      height: 30,
                    ),
                    //button
                    Align(
                      alignment: Alignment.center,
                      child: FloatingActionButton(
                        elevation: 0,
                        backgroundColor: selectedOfSeats.length > 0
                            ? mainColor
                            : Color(0xffe4e4e4),
                        child: Icon(
                          Icons.arrow_forward,
                          color: selectedOfSeats.length > 0
                              ? Colors.white
                              : Color(0xffbebebe),
                        ),
                        onPressed: selectedOfSeats.length > 0
                            ? () {
                                context.bloc<PageBloc>().add(GoToCheckoutPage(
                                    widget.ticket
                                        .copyWith(seats: selectedOfSeats)));
                              }
                            : null,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Column generateSeats() {
    List<int> numberofSeats = [3, 6, 6, 6, 6, 6];
    List<Widget> widgets = [];
    for (int i = 0; i < numberofSeats.length; i++) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            numberofSeats[i],
            (index) => Padding(
                  padding: EdgeInsets.only(
                      right: index < numberofSeats[i] - 1 ? 16 : 0, bottom: 16),
                  child: SelectBox(
                    "${String.fromCharCode(i + 65)}${index + 1}",
                    width: 40,
                    height: 40,
                    textStyle: whiteNumberFont.copyWith(color: Colors.black),
                    isSelected: selectedOfSeats
                        .contains("${String.fromCharCode(i + 65)}${index + 1}"),
                    onTap: () {
                      String seatNumber =
                          "${String.fromCharCode(i + 65)}${index + 1}";
                      setState(() {
                        if (selectedOfSeats.contains(seatNumber)) {
                          selectedOfSeats.remove(seatNumber);
                        } else {
                          selectedOfSeats.add(seatNumber);
                        }
                      });
                    },
                  ),
                )),
      ));
    }
    return Column(
      children: widgets,
    );
  }
}
