part of './../../../pages.dart';

class SeeMoreComingSoon extends StatelessWidget {
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
            title: Text(AppLocalizations.of(context).translate('comingSoon'),
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
            child: BlocBuilder<SeeMoreCsBloc,SeeMoreCsState>(
              builder: (_,seeMoreState){
                if(seeMoreState is SeeMoreCsLoaded){
                  List<Movie>seeMore = seeMoreState.comingSoon;
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
                              )),
                        ),
                      );
                    }),
                  );
                }else{
                  return Center(
                    child: SpinKitWave(
                      color: mainColor,
                      size: 60,
                    ),
                  );
                }
              },
            )
          )),
    );
  }
}
