part of './../../pages.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor1,
      body: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          // header
          Container(
            padding: EdgeInsets.fromLTRB(defaultMargin, 24, defaultMargin, 20),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (_, userState) {
                if (userState is UserLoaded) {
                  // if (imageFileToUpload != null) {
                  //   uploadImage(imageFileToUpload).then((downloadURL) {
                  //     imageFileToUpload = null;
                  //     context
                  //         .bloc<UserBloc>()
                  //         .add(UpdateData(profileImage: downloadURL));
                  //     context.bloc<UserBloc>().add(LoadUser(userState.user.id));
                  //   });
                  return Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xff5f558b), width: 1),
                        ),
                        child: Stack(
                          children: [
                            SpinKitCircle(
                              color: accentColor2,
                              size: 50,
                            ),
                            imageFileToUpload != null
                                ? SpinKitCircle(
                                    color: accentColor2,
                                    size: 50,
                                  )
                                : InkWell(
                                    onTap: () {
                                      context
                                          .bloc<PageBloc>()
                                          .add(GoToProfileSetting());
                                    },
                                    child: Hero(
                                      tag: userState.user.profilePicture,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: (userState.user
                                                            .profilePicture ==
                                                        ""
                                                    ? AssetImage(
                                                        "assets/user_pic.png")
                                                    : NetworkImage(userState
                                                        .user.profilePicture)),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  2 * defaultMargin -
                                  78,
                              child: Text(
                                userState.user.name,
                                style: whiteTextFont.copyWith(fontSize: 20),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              )),
                          Text(
                              NumberFormat.currency(
                                      locale: "id_ID",
                                      decimalDigits: 0,
                                      symbol: "IDR ")
                                  .format(userState.user.balance),
                              style: yellowNumberFont.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w400))
                        ],
                      )
                    ],
                  );
                } else {
                  return ShimmerAppBar();
                }
              },
            ),
          ),
          //Body
          Container(
            height: MediaQuery.of(context).size.height - 100,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Body(),
          )
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          // TODO: Show Movie Now Playing
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate('nowPlaying'),
                  style: blackTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    context.bloc<PageBloc>().add(GoToSeeMoreNowPlaying());
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('seeMore'),
                    style: yellowNumberFont.copyWith(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 140,
            child: BlocBuilder<NowplayingBloc, NowplayingState>(
              builder: (_, movieState) {
                if (movieState is NowplayingLoaded) {
                  List<Movie> nowPlaying = movieState.nowPlayingModel;
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: nowPlaying.length,
                      itemBuilder: (_, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: (index == 0) ? defaultMargin : 0,
                                    right: (index == nowPlaying.length - 1)
                                        ? defaultMargin
                                        : 16),
                                child: MovieCard(
                                  nowPlaying[index],
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () {
                                    context.bloc<PageBloc>().add(
                                        GoToMovieDetail(nowPlaying[index]));
                                    context.bloc<MovieDetailBloc>().add(
                                        LoadMovieDetail(nowPlaying[index].id,
                                            nowPlaying[index]));
                                    context
                                        .bloc<CreditsBloc>()
                                        .add(LoadCredits(nowPlaying[index].id));
                                    context.bloc<VideosBloc>().add(
                                        LoadVideosMovie(nowPlaying[index].id));
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return ShimmerMovieCard();
                }
              },
            ),
          ),
          //TODO:browse movie
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
            child: Text(
              AppLocalizations.of(context).translate('browseMovie'),
              style: blackTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        userState.user.selectedGenres.length,
                        (index) => BrowseButton(
                              userState.user.selectedGenres[index],
                              onTap: () {
                                int getIdGenre(String genre) {
                                  switch (genre) {
                                    case "Horror":
                                      return 27;
                                      break;
                                    case "Music":
                                      return 10402;
                                      break;
                                    case "Action":
                                      return 28;
                                      break;
                                    case "Drama":
                                      return 18;
                                      break;
                                    case "War":
                                      return 10752;
                                      break;
                                    case "Crime":
                                      return 80;
                                      break;
                                    default:
                                      return null;
                                  }
                                }

                                context.bloc<PageBloc>().add(GoToGenresMovie(
                                    genre:
                                        userState.user.selectedGenres[index]));
                                context.bloc<SortgenreBloc>().add(
                                    LoadSortgenreEvent(getIdGenre(
                                        userState.user.selectedGenres[index])));
                              },
                            )),
                  ),
                );
              } else {
                return ShimmerBrowseMovie();
              }
            },
          ),
          //TODO: Show Coming Soon
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).translate('comingSoon'),
                  style: blackTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    context.bloc<PageBloc>().add(GoToSeeMoreComingSoon());
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('seeMore'),
                    style: yellowNumberFont.copyWith(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 160,
            child: BlocBuilder<ComingsoonBloc, ComingsoonState>(
              builder: (_, comingSoonState) {
                if (comingSoonState is ComingSoonLoaded) {
                  List<Movie> comingsoon =
                      comingSoonState.comingSoon.sublist(15);
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: comingsoon.length,
                      itemBuilder: (_, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 600),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: (index == 0) ? defaultMargin : 0,
                                    right: (index == comingsoon.length - 1)
                                        ? defaultMargin
                                        : 16),
                                child: ComingSoonCard(comingsoon[index]),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return ShimmerComingSoon();
                }
              },
            ),
          ),
          //TODO: get lucky day
          Container(
            margin: EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 30),
            child: Text(
              AppLocalizations.of(context).translate('getLuckyDay'),
              style: blackTextFont.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: dummyPromos
                .map((e) => Padding(
                    padding: EdgeInsets.fromLTRB(
                        defaultMargin, 0, defaultMargin, 16),
                    child: PromoCard(e)))
                .toList(),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.70,
        size.width * 0.17, size.height * 0.90);
    path.quadraticBezierTo(
        size.width * 0.20, size.height, size.width * 0.25, size.height * 0.90);
    path.quadraticBezierTo(size.width * 0.40, size.height * 0.40,
        size.width * 0.50, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.85,
        size.width * 0.65, size.height * 0.65);
    path.quadraticBezierTo(
        size.width * 0.70, size.height * 0.90, size.width, 0);
    path.close();

    paint.color = accentColor1;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.80,
        size.width * 0.15, size.height * 0.60);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.45,
        size.width * 0.27, size.height * 0.60);
    path.quadraticBezierTo(
        size.width * 0.45, size.height, size.width * 0.50, size.height * 0.80);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.45,
        size.width * 0.75, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.93, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = mainColor;
    canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.55,
        size.width * 0.22, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.90,
        size.width * 0.40, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.52, size.height * 0.50,
        size.width * 0.65, size.height * 0.70);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.85, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = accentColor2;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
