part of 'widgets.dart';

class ShimmerBrowseMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var column = Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 4),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Color(0xFFEEF1F8), borderRadius: BorderRadius.circular(8)),
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
        SizedBox(
          height: 4,
        ),
        SizedBox(
            width: 50,
            height: 10,
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
            )),
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
