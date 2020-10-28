part of '../../../pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;
  SelectSchedulePage(this.movieDetail);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  //initial variable
  List<DateTime> dates;
  DateTime selectedDate;
  int selectedTime;
  Theater selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToMovieDetail(widget.movieDetail));
          return;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context).translate('selectSchedule'),
              style: blackTextFont,
            ),
            leading: IconButton(
              onPressed: () {
                context
                    .bloc<PageBloc>()
                    .add(GoToMovieDetail(widget.movieDetail));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 16),
                child: Text(
                    AppLocalizations.of(context).translate('chooseDate'),
                    style: blackTextFont.copyWith(fontSize: 20)),
              ),
              //note: Choose day and date
              Container(
                margin: EdgeInsets.only(bottom: 24),
                height: 90,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dates.length,
                    itemBuilder: (_, index) => Container(
                          margin: EdgeInsets.only(
                              left: (index == 0) ? defaultMargin : 0,
                              right:
                                  (index < dates.length) ? 16 : defaultMargin),
                          child: DateTimeCard(
                            dates[index],
                            width: 70,
                            heigth: 90,
                            isSelected: selectedDate == dates[index],
                            onTap: () {
                              setState(() {
                                selectedDate = dates[index];
                                selectedTime = null;
                                isValid = false;
                              });
                            },
                          ),
                        )),
              ),
              //note : Choose Time and Bioskop
              generateTimeTable(),
              //note : Button
              SizedBox(
                height: 50,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) => FloatingActionButton(
                      elevation: 0,
                      child: Icon(Icons.arrow_forward),
                      backgroundColor:
                          (isValid) ? mainColor : Color(0xffe4e4e4),
                      onPressed: () {
                        if (isValid) {
                          context.bloc<PageBloc>().add(GoToSelectSeatPage(
                              Ticket(
                                  widget.movieDetail,
                                  selectedTheater,
                                  DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime),
                                  randomAlphaNumeric(12).toUpperCase(),
                                  null,
                                  (userState as UserLoaded).user.name,
                                  null)));
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var theater in dummyTheater) {
      widgets.add(Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child:
              Text(theater.name, style: blackTextFont.copyWith(fontSize: 20))));

      widgets.add(Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          itemCount: schedule.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Container(
            margin: EdgeInsets.only(
                left: (index == 0) ? defaultMargin : 0,
                right: (index < schedule.length - 1) ? 16 : defaultMargin),
            child: SelectBox(
              "${schedule[index]}:00",
              height: 50,
              isSelected:
                  selectedTheater == theater && selectedTime == schedule[index],
              isEnabled: schedule[index] > DateTime.now().hour ||
                  selectedDate.day != DateTime.now().day,
              onTap: () {
                setState(() {
                  if (schedule[index] < DateTime.now().hour ||
                      selectedDate.day == DateTime.now().day) {
                    isValid = false;
                    selectedTime = null;
                  }
                  if (schedule[index] > DateTime.now().hour ||
                      selectedDate.day != DateTime.now().day) {
                    selectedTheater = theater;
                    selectedTime = schedule[index];
                    isValid = true;
                  }
                });
              },
            ),
          ),
        ),
      ));
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }
}
