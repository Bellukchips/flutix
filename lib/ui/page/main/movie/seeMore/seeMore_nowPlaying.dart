part of './../../../pages.dart';

class SeeMoreNowPlaying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMainPage(bottomNavBarIndex: 0));
        return;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(AppLocalizations.of(context).translate('nowPlaying'),
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
          body: Container(child: BlocBuilder<SeeMoreNpBloc, SeeMoreNpState>(
            builder: (_, seeMoreState) {
              if (seeMoreState is SeeMoreNpLoaded) {
                List<Movie> seeMore = seeMoreState.nowPlayingModel;
                return GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(seeMore.length, (index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                            child: MovieCard(
                          seeMore[index],
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToMovieDetail(seeMore[index]));
                            context.bloc<MovieDetailBloc>().add(LoadMovieDetail(
                                seeMore[index].id, seeMore[index]));
                            context
                                .bloc<CreditsBloc>()
                                .add(LoadCredits(seeMore[index].id));
                            context
                                .bloc<VideosBloc>()
                                .add(LoadVideosMovie(seeMore[index].id));
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
          ))),
    );
  }
}
