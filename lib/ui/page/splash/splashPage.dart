part of '../pages.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 136,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/logo.png"))),
            ),
            Container(
              margin: EdgeInsets.only(top: 70, bottom: 16),
              child: Text(
                AppLocalizations.of(context).translate('titleSplash'),
                style: blackTextFont.copyWith(fontSize: 20),
              ),
            ),
            TyperAnimatedTextKit(
              text: [AppLocalizations.of(context).translate('subTitleSplash')],
              textAlign: TextAlign.center,
              textStyle: greyTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w300),
            ),
            Button(
              width: 250,
              height: 46,
              margin: EdgeInsets.only(top: 70, bottom: 19),
              title:
                  AppLocalizations.of(context).translate('titleButtonSplash'),
              textStyle: whiteTextFont.copyWith(fontSize: 16),
              color: mainColor,
              onPressed: () {
                context
                    .bloc<PageBloc>()
                    .add(GoToRegisterPage(RegistrationUser()));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)
                    .translate('alreadyhaveanAccount')),
                InkWell(
                  onTap: () {
                    context.bloc<PageBloc>().add(GoToLoginPage());
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('signIn'),
                    style: purpleTextFont,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
