part of './../../pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //declaration variable controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //declaration variable boolean for condition
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSignIn = false;
  bool showPass = true;
  showhide() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    //change theme textfields
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 80,
                      child: Image.asset("assets/logo.png"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 70, bottom: 40),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('titleTextLogin'),
                        style: blackTextFont.copyWith(fontSize: 25),
                      ),
                    ),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isEmailValid = EmailValidator.validate(text);
                        });
                      },
                      cursorColor: accentColor2,
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText:
                              AppLocalizations.of(context).translate('email'),
                          hintText:
                              AppLocalizations.of(context).translate('email')),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          isPasswordValid = text.length >= 6;
                        });
                      },
                      controller: passwordController,
                      obscureText: showPass,
                      cursorColor: accentColor2,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(showPass
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: showhide),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('password'),
                          hintText: AppLocalizations.of(context)
                              .translate('password')),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('forgotPassword'),
                          style: greyTextFont.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        InkWell(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToForgotPassword());
                          },
                          child: Text(
                            AppLocalizations.of(context).translate('getNow'),
                            style: purpleTextFont.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(top: 40, bottom: 30),
                        child: isSignIn
                            ? SpinKitCircle(
                                color: mainColor,
                              )
                            : FloatingActionButton(
                                onPressed: isEmailValid && isPasswordValid
                                    ? () async {
                                        setState(() {
                                          isSignIn = true;
                                        });

                                        SignInSignUpResult result =
                                            await AuthServices.signIn(
                                                emailController.text,
                                                passwordController.text);

                                        if (result.user == null) {
                                          setState(() {
                                            isSignIn = false;
                                          });
                                          Flushbar(
                                            duration: Duration(seconds: 4),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            backgroundColor: Color(0xFFFF5C83),
                                            message: result.message,
                                          )..show(context);
                                        }
                                      }
                                    : null,
                                elevation:
                                    isEmailValid && isPasswordValid ? 5 : 0,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: isEmailValid && isPasswordValid
                                      ? Colors.white
                                      : Color(0xFFBEBEBE),
                                ),
                                backgroundColor: isEmailValid && isPasswordValid
                                    ? mainColor
                                    : Color(0xFFE4E4E4),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('continueWith'),
                          style: greyTextFont.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          child: GestureDetector(
                            onTap: () async {
                              try {
                                await AuthServices.gmailSignIn();
                              } catch (e){
                                throw PlatformException(
                                    code: e.code, message: e.message);
                              }
                            },
                            child: Image.asset("assets/ic_google.png"),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context).translate('or'),
                          style: greyTextFont.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          child: Text(
                              AppLocalizations.of(context).translate('signUp'),
                              style: purpleTextFont),
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToRegisterPage(RegistrationUser()));
                          },
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
