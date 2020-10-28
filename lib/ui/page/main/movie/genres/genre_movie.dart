part of './../../../pages.dart';

class GenresMovie extends StatefulWidget {
  final String genre;
  GenresMovie({this.genre});
  @override
  _GenresMovieState createState() => _GenresMovieState();
}

class _GenresMovieState extends State<GenresMovie> {
  List<Movie> genreMovie;
  @override
  void initState() {
    super.initState();
    debugPrint(widget.genre);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 0));
        context.bloc<SortgenreBloc>().add(ClearSortGenres());
        return;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(widget.genre,
                style: blackTextFont.copyWith(fontSize: 20)),
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  context
                      .bloc<PageBloc>()
                      .add(GoToMainPage(bottomNavBarIndex: 0));
                }),
          ),
          backgroundColor: Colors.white,
          body: Container(
            child: BlocBuilder<SortgenreBloc, SortgenreState>(
              builder: (_, sortState) {
                if (sortState is SortgenreLoaded) {
                  genreMovie = sortState.movie;
                  return GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(genreMovie.length, (index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                              child: MovieCard(
                            genreMovie[index],
                            onTap: () {
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToMovieDetail(genreMovie[index]));
                              context.bloc<MovieDetailBloc>().add(
                                  LoadMovieDetail(
                                      genreMovie[index].id, genreMovie[index]));
                              context
                                  .bloc<CreditsBloc>()
                                  .add(LoadCredits(genreMovie[index].id));
                              context
                                  .bloc<VideosBloc>()
                                  .add(LoadVideosMovie(genreMovie[index].id));
                            },
                          )),
                        ),
                      );
                    }),
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
            ),
          )),
    );
  }
}
