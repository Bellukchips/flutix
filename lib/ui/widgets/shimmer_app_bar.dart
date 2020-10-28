part of 'widgets.dart';

class ShimmerAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xff5f558b), width: 1),
          ),
          child: Stack(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: SpinKitCircle(
                  color: accentColor2,
                  size: 50,
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
              width: MediaQuery.of(context).size.width - 2 * defaultMargin - 78,
              height: 10,
              child: Shimmer.fromColors(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          colors: [accentColor2, accentColor4],
                          end: Alignment.centerRight,
                          begin: Alignment.centerLeft)),
                ),
                baseColor: accentColor2,
                highlightColor: accentColor4,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 2 * defaultMargin - 78,
              height: 10,
              child: Shimmer.fromColors(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          colors: [accentColor2, accentColor4],
                          end: Alignment.centerRight,
                          begin: Alignment.centerLeft)),
                ),
                baseColor: accentColor2,
                highlightColor: accentColor4,
              ),
            ),
          ],
        )
      ],
    );
  }
}
