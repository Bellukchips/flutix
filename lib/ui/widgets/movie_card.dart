part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function onTap;
  final BorderRadiusGeometry borderRadius;

  MovieCard(this.movie, {this.onTap, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Hero(
        tag: movie.id,
        child: movie.backdropPath == null || movie.backdropPath == ""
            ? Container(
                height: 140,
                width: 210,
                decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    image: DecorationImage(
                        image: NetworkImage(
                            imageBaseURL + "w780" + movie.posterPath),
                        fit: BoxFit.cover)),
                child: Container(
                  height: 140,
                  width: 210,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.61),
                            Colors.black.withOpacity(0)
                          ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        movie.title,
                        style: whiteTextFont,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      RatingStars(
                        voteAverage: movie.voteAverage,
                      )
                    ],
                  ),
                ),
              )
            : Container(
                height: 140,
                width: 210,
                decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    image: DecorationImage(
                        image: NetworkImage(
                            imageBaseURL + "w780" + movie.backdropPath),
                        fit: BoxFit.cover)),
                child: Container(
                  height: 140,
                  width: 210,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.61),
                            Colors.black.withOpacity(0)
                          ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        movie.title,
                        style: whiteTextFont,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      RatingStars(
                        voteAverage: movie.voteAverage,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
