part of 'widgets.dart';

class VideosCard extends StatefulWidget {
  final VideosModel videos;
  VideosCard(this.videos);

  @override
  _VideosCardState createState() => _VideosCardState();
}

class _VideosCardState extends State<VideosCard> {
  lauchUrl() async {
    var url = "https://www.youtube.com/watch?v=" + widget.videos.key;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return (widget.videos.key == null)
        ? Container()
        : InkWell(
            onTap: lauchUrl,
            radius: 20,
            child: Stack(
              children: [
                Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [mainColor, accentColor1],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: defaultMargin - 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.videos.name,
                          maxLines: 1,
                          style: whiteTextFont,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          widget.videos.type,
                          style: whiteTextFont,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                ShaderMask(
                  shaderCallback: (rectangle) {
                    return LinearGradient(colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.transparent
                    ], begin: Alignment.centerRight, end: Alignment.centerLeft)
                        .createShader(Rect.fromLTRB(0, 0, 77.5, 80));
                  },
                  blendMode: BlendMode.dstIn,
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                      child: Image.asset("assets/reflection2.png"),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ShaderMask(
                    shaderCallback: (rectangle) {
                      return LinearGradient(
                          end: Alignment.centerRight,
                          begin: Alignment.centerLeft,
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.transparent
                          ]).createShader(Rect.fromLTRB(0, 0, 96, 45));
                    },
                    blendMode: BlendMode.dstIn,
                    child: SizedBox(
                      height: 45,
                      width: 96,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                          ),
                          child: Image.asset("assets/reflection1.png")),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
