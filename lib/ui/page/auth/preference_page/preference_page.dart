part of './../../pages.dart';

class PreferencePage extends StatefulWidget {
  final List<String> genres = [
    "Horror",
    "Music",
    "Action",
    "Drama",
    "War",
    "Crime",
  ];
  final List<String> languages = ["Indonesia", "English", "Korean", "Japanese"];
  final RegistrationUser registrationUser;
  PreferencePage(this.registrationUser);
  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenres = [];
  String selectedLanguage = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          widget.registrationUser.password = "";
          context
              .bloc<PageBloc>()
              .add(GoToRegisterPage(widget.registrationUser));
          return;
        },
        child: SafeArea(
          top: false,
          child: Scaffold(
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 56,
                        margin: EdgeInsets.only(top: 20, bottom: 4),
                        child: InkWell(
                            onTap: () {
                              widget.registrationUser.password = "";

                              context.bloc<PageBloc>().add(
                                  GoToRegisterPage(widget.registrationUser));
                            },
                            child: Icon(Icons.arrow_back)),
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
                      Center(
                        child: FloatingActionButton(
                          onPressed: () {
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
                              print(selectedGenres);
                              widget.registrationUser.selectedGenre =
                                  selectedGenres;
                              widget.registrationUser.selectedLanguage =
                                  selectedLanguage;
                              context.bloc<PageBloc>().add(
                                  GoToConfirmationAccountPage(
                                      widget.registrationUser));
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
