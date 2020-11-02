part of './../../pages.dart';

class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  launchUrl() async {
    var url =
        "https://play.google.com/store/apps/details?id=com.bellukstudio.flutix&reviewId=0";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///
  ///
  //bottom sheet modal lang
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  trailing: Visibility(
                      visible: AppLocalizations.of(context).isEnLocale
                          ? false
                          : true,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )),
                  title: Text("Indonesia"),
                  onTap: () async {
                    if (AppLocalizations.of(context).isEnLocale) {
                      PreferenceManager.savePreferences(2, 'ID', 'Indonesia');
                    }
                    Navigator.pop(context);
                    setState(() {});
                  },
                ),
                new ListTile(
                  trailing: Visibility(
                      visible: AppLocalizations.of(context).isEnLocale
                          ? true
                          : false,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )),
                  title: new Text("English"),
                  onTap: () async {
                    if (AppLocalizations.of(context).isIdLocale) {
                      BlocProvider.of<LocaleCubit>(context).toEnglish();
                      PreferenceManager.savePreferences(1, 'EN', 'ENglish');
                    }
                    Navigator.pop(context);
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        });
  }

  ///
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).translate('profile'),
            style: blackTextFont.copyWith(fontSize: 20),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                context.bloc<PageBloc>().add(GoToMainPage());
              }),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) {
                  if (userState is UserLoaded) {
                    Users user = userState.user;
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 45, bottom: 10),
                          width: 120,
                          height: 120,
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: SpinKitCircle(
                                    color: mainColor,
                                  ),
                                ),
                              ),
                              Hero(
                                tag: user.profilePicture,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: mainColor),
                                      image: DecorationImage(
                                          image: (user.profilePicture != "")
                                              ? NetworkImage(
                                                  user.profilePicture)
                                              : AssetImage(
                                                  "assets/user_pic.png"),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin,
                          child: Text(
                            user.name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: blackTextFont.copyWith(fontSize: 18),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin,
                          margin: EdgeInsets.only(top: 8, bottom: 30),
                          child: Text(
                            user.email,
                            textAlign: TextAlign.center,
                            style: greyTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          ),
                        )
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) => InkWell(
                      onTap: () {
                        context.bloc<PageBloc>().add(
                            GoToEditProfile((userState as UserLoaded).user));
                      },
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                                width: 24,
                                height: 24,
                                child: Image.asset("assets/edit_profile.png")),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .translate('editProfile'),
                              style: blackTextFont.copyWith(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 16),
                    child: generateDashedDivider(
                        MediaQuery.of(context).size.width - 2 * defaultMargin),
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .bloc<PageBloc>()
                          .add(GoToWallettPage(GoToProfileSetting()));
                    },
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset("assets/my_wallet.png")),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            AppLocalizations.of(context).translate('myWallet'),
                            style: blackTextFont.copyWith(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 16),
                    child: generateDashedDivider(
                        MediaQuery.of(context).size.width - 2 * defaultMargin),
                  ),
                  InkWell(
                    onTap: () {
                      _settingModalBottomSheet(context);
                    },
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset("assets/language.png")),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .translate('changeLanguage'),
                            style: blackTextFont.copyWith(fontSize: 16),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            AppLocalizations.of(context).isEnLocale
                                ? "(Language English)"
                                : "(Bahasa Indonesia)",
                            style: greyTextFont.copyWith(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 16),
                    child: generateDashedDivider(
                        MediaQuery.of(context).size.width - 2 * defaultMargin),
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                            width: 24,
                            height: 24,
                            child: Image.asset("assets/help_centre.png")),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context).translate('helpCenter'),
                          style: blackTextFont.copyWith(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 16),
                    child: generateDashedDivider(
                        MediaQuery.of(context).size.width - 2 * defaultMargin),
                  ),
                  InkWell(
                    onTap: launchUrl,
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset("assets/rate.png")),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            AppLocalizations.of(context).translate('rateApp'),
                            style: blackTextFont.copyWith(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 16),
                    child: generateDashedDivider(
                        MediaQuery.of(context).size.width - 2 * defaultMargin),
                  ),
                  InkWell(
                    onTap: () async {
                      await AuthServices.signOut();
                      context.bloc<UserBloc>().add(SignOut());
                    },
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                              width: 24,
                              height: 24,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5, 3, 9, 3),
                                    color: accentColor2,
                                  ),
                                  Icon(
                                    MdiIcons.logout,
                                    color: mainColor,
                                    size: 24,
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            AppLocalizations.of(context).translate('signOut'),
                            style: blackTextFont.copyWith(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 16),
                    child: generateDashedDivider(
                        MediaQuery.of(context).size.width - 2 * defaultMargin),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
