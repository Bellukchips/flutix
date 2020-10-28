part of './../../pages.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToLoginPage());
        return;
      },
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              SizedBox(
                height: 200,
              ),
              Center(
                child: TyperAnimatedTextKit(
                  text: [
                    AppLocalizations.of(context).translate('forgotPassword')
                  ],
                  textAlign: TextAlign.center,
                  textStyle: blackTextFont.copyWith(
                      fontSize: 30, fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                child: TextField(
                  autofocus: true,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email",
                      hintText: "Email"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                width: 250,
                margin: EdgeInsets.only(bottom: 20),
                child: RaisedButton(
                  onPressed: () async {
                    if (emailController.text == "") {
                      Flushbar(
                        duration: Duration(milliseconds: 2000),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: AppLocalizations.of(context)
                            .translate('pleaseFillEmail'),
                      )..show(context);
                    } else {
                      await AuthServices.resetPassword(emailController.text);

                      Flushbar(
                        duration: Duration(milliseconds: 2000),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message:
                            AppLocalizations.of(context).translate('linkSend'),
                      )..show(context);
                    }
                  },
                  elevation: 0,
                  color: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('sendEmail'),
                    style: whiteTextFont.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
