part of '../pages.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var duration = const Duration(milliseconds: 1000);
    Timer(duration, () {
      context.bloc<PageBloc>().add(GoToBlankPage());
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TyperAnimatedTextKit(
              text: ["Flutix"],
              textAlign: TextAlign.center,
              textStyle: blackTextFont.copyWith(
                  fontSize: 35, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                ))
          ],
        ),
      ),
    );
  }
}
