part of '../pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;
  final bool isExpired;

  MainPage({this.bottomNavBarIndex = 0, this.isExpired = false});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //initial variable for index bottom navbar and page controller
  int bottomNavbarIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    bottomNavbarIndex = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: bottomNavbarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) {
            if (userState is UserLoaded) {
              if (userState.user.selectedGenres == null ||
                  userState.user.selectedGenres.length == 0) {
                return PrefPageUser(
                  uid: userState.user.id,
                );
              }
              return Scaffold(
                body: Stack(
                  children: [
                    Container(
                      color: accentColor1,
                    ),
                    SafeArea(
                      child: Container(
                        color: Color(0xfff6f7f9),
                      ),
                    ),
                    PageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        setState(() {
                          bottomNavbarIndex = index;
                        });
                      },
                      children: [
                        MoviePage(),
                        TicketPage(
                          isExpiredTicket: widget.isExpired,
                        )
                      ],
                    ),
                    createCustomBottomnavBar(context),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 46,
                        width: 46,
                        margin: EdgeInsets.only(bottom: 42),
                        child: FloatingActionButton(
                            elevation: 0,
                            backgroundColor: accentColor2,
                            child: SizedBox(
                              height: 26,
                              width: 26,
                              child: Icon(
                                MdiIcons.walletPlus,
                                color: Colors.black.withOpacity(0.54),
                              ),
                            ),
                            onPressed: () async {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToTopUpPage(GoToMainPage()));
                            }),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  //TODO: custom bottom navbar

  Widget createCustomBottomnavBar(BuildContext context) => Align(
    alignment: Alignment.bottomCenter,
    child: ClipPath(
      clipper: BottomNavbarClipper(),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: mainColor,
          unselectedItemColor: Color(0xffe5e5e5),
          currentIndex: bottomNavbarIndex,
          onTap: (index) {
            setState(() {
              bottomNavbarIndex = index;
              pageController.jumpToPage(index);
            });
          },
          items: [
            BottomNavigationBarItem(
                title: Text(
                    AppLocalizations.of(context).translate('newMovies'),
                    style: GoogleFonts.raleway(
                        fontSize: 13, fontWeight: FontWeight.w600)),
                icon: Container(
                  margin: EdgeInsets.only(bottom: 6),
                  height: 20,
                  child: Image.asset((bottomNavbarIndex == 0)
                      ? "assets/ic_movie.png"
                      : "assets/ic_movie_grey.png"),
                )),
            BottomNavigationBarItem(
                title: Text(
                    AppLocalizations.of(context).translate('myTicket'),
                    style: GoogleFonts.raleway(
                        fontSize: 13, fontWeight: FontWeight.w600)),
                icon: Container(
                  margin: EdgeInsets.only(bottom: 6),
                  height: 20,
                  child: Image.asset((bottomNavbarIndex == 1)
                      ? "assets/ic_tickets.png"
                      : "assets/ic_tickets_grey.png"),
                ))
          ],
        ),
      ),
    ),
  );
}

//TODO: create clipath custom bottom navbar

class BottomNavbarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

//PreferencePage To User Register Using Google Account

class PrefPageUser extends StatefulWidget {
  final List<String> genres = [
    "Horror",
    "Music",
    "Action",
    "Drama",
    "War",
    "Crime",
  ];
  final List<String> languages = ["Indonesia", "English", "Korean", "Japanese"];
  final String uid;
  PrefPageUser({this.uid});
  @override
  _PrefPageUserState createState() => _PrefPageUserState();
}

class _PrefPageUserState extends State<PrefPageUser> {
  List<String> selectedGenres = [];
  String selectedLanguage = "";
  bool isSignUp = false;
  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(
            AppLocalizations.of(context).translate('areYouSure'),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: new Text(
            AppLocalizations.of(context).translate('wantexitApp'),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Text(AppLocalizations.of(context).translate('no'),
                      style: blackTextFont.copyWith(fontSize: 15)),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(true),
                  child: Text(AppLocalizations.of(context).translate('yes'),
                      style: blackTextFont.copyWith(fontSize: 15)),
                ),
              ],
            )
          ],
        ),
      ) ??
          false;
    }

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: SafeArea(
          top: false,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate('selectYourefavoriteGenres'),
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children: generateGenreWidgets(context),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate('movieLanguagePrefer'),
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children: generateLanguageWidgets(context),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      (isSignUp)
                          ? SpinKitThreeBounce(
                        color: mainColor,
                        size: 30,
                      )
                          : Center(
                        child: FloatingActionButton(
                          onPressed: () async {
                            if (selectedGenres.length != 4) {
                              Flushbar(
                                duration: Duration(milliseconds: 1500),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xFFFF5C83),
                                message: AppLocalizations.of(context)
                                    .translate('selectFourGenre'),
                              )..show(context);
                            } else if (selectedLanguage == "") {
                              Flushbar(
                                duration: Duration(milliseconds: 1500),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xFFFF5C83),
                                message: AppLocalizations.of(context)
                                    .translate('selectLanguage'),
                              )..show(context);
                            } else {
                              setState(() {
                                isSignUp = true;
                              });
                              context.bloc<UserBloc>().add(UpdateData(
                                  selectedGenres: selectedGenres,
                                  selectedLanguage: selectedLanguage));
                              context.bloc<PageBloc>().add(
                                  GoToMainPage(bottomNavBarIndex: 0));
                            }
                          },
                          elevation: 0,
                          backgroundColor: mainColor,
                          child: Icon(Icons.arrow_forward),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  //TODO : generate widgets select genre from data list

  List<Widget> generateGenreWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.genres
        .map((e) => SelectBox(
      e,
      width: width,
      isSelected: selectedGenres.contains(e),
      onTap: () {
        onSelectGenre(e);
      },
    ))
        .toList();
  }

  //TODO : generate widgets select language from data list
  List<Widget> generateLanguageWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;
    return widget.languages
        .map((e) => SelectBox(
      e,
      width: width,
      isSelected: selectedLanguage == e,
      onTap: () {
        setState(() {
          selectedLanguage = e;
        });
      },
    ))
        .toList();
  }

  //TODO: function onselectgenre
  void onSelectGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
    } else {
      if (selectedGenres.length < 4) {
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}
