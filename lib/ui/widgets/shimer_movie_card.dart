part of 'widgets.dart';

class ShimmerMovieCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var container = Container(
        height: 140,
        width: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          height: 140,
          width: 210,
          child: Shimmer.fromColors(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      colors: [Colors.grey[300], Colors.grey[200]],
                      end: Alignment.centerRight,
                      begin: Alignment.centerLeft)),
            ),
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[200],
          ),
        ));
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(
          width: 24,
        ),
        container,
        SizedBox(
          width: 16,
        ),
        container,
        SizedBox(
          width: 16,
        ),
        container,
        SizedBox(
          width: 16,
        ),
        container,
        SizedBox(
          width: 24,
        ),
      ],
    );
  }
}
