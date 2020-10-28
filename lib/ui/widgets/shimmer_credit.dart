part of 'widgets.dart';

class ShimmerCredits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var column = Column(
      children: <Widget>[
        Container(
          height: 80,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.blueGrey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Shimmer.fromColors(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                      colors: [Colors.grey[300], Colors.grey[200]],
                      end: Alignment.centerRight,
                      begin: Alignment.centerLeft)),
            ),
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[200],
          ),
        ),
      ],
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [column, column, column, column],
      ),
    );
  }
}
