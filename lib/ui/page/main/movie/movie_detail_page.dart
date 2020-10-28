part of '../../pages.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  MovieDetailPage(this.movie);
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieDetail movieDetail;
  List<Credit> credits;
  List<VideosModel> videos;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage());
        context.bloc<MovieDetailBloc>().add(ClearMovieDetail());
        credits.clear();
        videos.clear();
        return;
      },
      child: Scaffold(
          body: Container(child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (_, detailState) {
              if (detailState is MovieDetailLoaded) {
                movieDetail = detailState.movie;
                return Scaffold(
                  floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.scaling,
                  floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: AnimatedContainer(
                    duration: Duration(seconds: 5),
                    curve: Curves.bounceOut,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: mainColor,
                        child: Text(
                          AppLocalizations.of(context).translate('continueBooking'),
                          style: whiteTextFont.copyWith(fontSize: 16),
                        ),
                        onPressed: () {
                          context
                              .bloc<PageBloc>()
                              .add(GoToSelectSchedulePage(movieDetail));
                        }),
                  ),
                  backgroundColor: Colors.white,
                  body: NestedScrollView(
                    physics: BouncingScrollPhysics(),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          expandedHeight: 260,
                          pinned: true,
                          leading: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                context.bloc<PageBloc>().add(GoToMainPage());
                              }),
                          title: Text(detailState.movie.title,
                              style: whiteTextFont.copyWith(
                                  fontSize: 30, fontWeight: FontWeight.w900),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          backgroundColor: mainColor,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.pin,
                            background: Stack(
                              children: <Widget>[
                                Hero(
                                  tag: detailState.movie.id,
                                  child: Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(imageBaseURL +
                                                "w1280" +
                                                detailState
                                                    .movie.backdropPath ??
                                                detailState.movie.posterPath),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Container(
                                  height: 305,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment(0, 1),
                                          end: Alignment(0, 0.06),
                                          colors: [
                                            Colors.white,
                                            Colors.white.withOpacity(0)
                                          ])),
                                )
                              ],
                            ),
                          ),
                        )
                      ];
                    },
                    body: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  defaultMargin, 16, defaultMargin, 6),
                              child: Text(
                                "${detailState.movie.title}",
                                textAlign: TextAlign.center,
                                style: blackTextFont.copyWith(fontSize: 24),
                              ),
                            ),

                            Text(
                              "${movieDetail.genresAndLanguage}",
                              style: greyTextFont.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            // note: RATING
                            RatingStars(
                              voteAverage: detailState.movie.voteAverage,
                              color: accentColor3,
                              alignment: MainAxisAlignment.center,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              margin:
                              EdgeInsets.only(left: defaultMargin, bottom: 12),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('castAndCrew'),
                                style: blackTextFont.copyWith(fontSize: 14),
                              )),
                        ),
                        BlocBuilder<CreditsBloc, CreditsState>(
                          builder: (_, creditState) {
                            if (creditState is CreditLoaded) {
                              credits = creditState.credit;
                              return SizedBox(
                                height: 115,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: credits.length,
                                    itemBuilder: (_, index) => Container(
                                        margin: EdgeInsets.only(
                                            left: (index == 0) ? defaultMargin : 0,
                                            right: (index == credits.length - 1)
                                                ? defaultMargin
                                                : 16),
                                        child: CreditCard(credits[index]))),
                              );
                            } else {
                              return ShimmerCredits();
                            }
                          },
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              defaultMargin, 24, defaultMargin, 8),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('storyAndTrailer'),
                              style: blackTextFont,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              defaultMargin, 0, defaultMargin, 30),
                          child: Text(
                            "${detailState.movie.overview}",
                            style:
                            greyTextFont.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                        BlocBuilder<VideosBloc, VideosState>(
                          builder: (_, videosState) {
                            if (videosState is VideosLoaded) {
                              videos = videosState.videos;
                              return SizedBox(
                                height: 100,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: videos.length,
                                    itemBuilder: (_, index) => Container(
                                        margin: EdgeInsets.only(
                                            left: (index == 0) ? defaultMargin : 0,
                                            right: (index == videos.length - 1)
                                                ? defaultMargin
                                                : 16),
                                        child: VideosCard(videos[index]))),
                              );
                            } else {
                              return SpinKitPulse(
                                size: 100,
                                color: accentColor1,
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: SpinKitWave(
                    color: mainColor,
                    size: 60,
                  ),
                );
              }
            },
          ))),
    );
  }
}
