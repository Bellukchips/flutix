part of './../../pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationUser registrationUser;
  SignUpPage(this.registrationUser);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //TODO: controller textfield
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // variable bool
  bool isNameValid = false;
  bool isEmailVaid = false;
  bool showPassword = true;

  //function show and hide password

  showhide() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.registrationUser.name;
    emailController.text = widget.registrationUser.email;
  }

  @override
  Widget build(BuildContext context) {
    //bottom sheet modal
    void _settingModalBottomSheet(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(
                        Icons.photo,
                        color: accentColor3,
                      ),
                      title: Text(
                          AppLocalizations.of(context).translate('takeGallry')),
                      onTap: () async {
                        if (widget.registrationUser.profileImage == null) {
                          Navigator.pop(context);
                          widget.registrationUser.profileImage =
                              await getImageGallery();
                        } else {
                          widget.registrationUser.profileImage = null;
                        }
                        setState(() {});
                      }),
                  new ListTile(
                    leading: new Icon(Icons.camera_alt, color: accentColor3),
                    title: new Text(
                        AppLocalizations.of(context).translate('takeCamera')),
                    onTap: () async {
                      if (widget.registrationUser.profileImage == null) {
                        Navigator.pop(context);
                        widget.registrationUser.profileImage =
                            await getImageCamera();
                      } else {
                        widget.registrationUser.profileImage = null;
                      }
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          });
    }

    //change theme textfields
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));

    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToLoginPage());
          return;
        },
        child: SafeArea(
          top: false,
          child: Scaffold(
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 22),
                        height: 56,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () {
                                  context.bloc<PageBloc>().add(GoToLoginPage());
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('createAccount'),
                                style: blackTextFont.copyWith(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 104,
                        child: Stack(
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: accentColor2),
                                  image: DecorationImage(
                                      image: (widget.registrationUser
                                                  .profileImage ==
                                              null)
                                          ? AssetImage("assets/user_pic.png")
                                          : FileImage(widget
                                              .registrationUser.profileImage),
                                      fit: BoxFit.cover)),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () async {
                                  if (widget.registrationUser.profileImage ==
                                      null) {
                                    _settingModalBottomSheet(context);
                                  } else {
                                    widget.registrationUser.profileImage = null;
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                        (widget.registrationUser.profileImage ==
                                                null)
                                            ? "assets/btn_add_photo.png"
                                            : "assets/btn_del_photo.png",
                                      ))),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('fullName'),
                          hintText: AppLocalizations.of(context)
                              .translate('fullName'),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText:
                              AppLocalizations.of(context).translate('email'),
                          hintText:
                              AppLocalizations.of(context).translate('email'),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: showPassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: showhide,
                            icon: Icon(showPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('password'),
                          hintText: AppLocalizations.of(context)
                              .translate('password'),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: showPassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: showhide,
                            icon: Icon(showPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: AppLocalizations.of(context)
                              .translate('confPassword'),
                          hintText: AppLocalizations.of(context)
                              .translate('confPassword'),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FloatingActionButton(
                          onPressed: () {
                            if (!(nameController.text.trim() != "" &&
                                emailController.text.trim() != "" &&
                                passwordController.text.trim() != "" &&
                                confirmPasswordController.text.trim() != "")) {
                              Flushbar(
                                duration: Duration(milliseconds: 1500),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xFFFF5C83),
                                message: AppLocalizations.of(context)
                                    .translate('pleaseFillAll'),
                              )..show(context);
                            } else if (passwordController.text !=
                                confirmPasswordController.text) {
                              Flushbar(
                                duration: Duration(milliseconds: 1500),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xFFFF5C83),
                                message: AppLocalizations.of(context)
                                    .translate('passWordMiss'),
                              )..show(context);
                            } else if (passwordController.text.length < 6) {
                              Flushbar(
                                duration: Duration(milliseconds: 1500),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xFFFF5C83),
                                message: AppLocalizations.of(context)
                                    .translate('passwordLength'),
                              )..show(context);
                            } else if (!EmailValidator.validate(
                                emailController.text)) {
                              Flushbar(
                                duration: Duration(milliseconds: 1500),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xFFFF5C83),
                                message: AppLocalizations.of(context)
                                    .translate('emailValidate'),
                              )..show(context);
                            } else {
                              widget.registrationUser.name =
                                  nameController.text;
                              widget.registrationUser.email =
                                  emailController.text;
                              widget.registrationUser.password =
                                  passwordController.text;

                              context.bloc<PageBloc>().add(
                                  GoToPreferencePage(widget.registrationUser));
                            }
                          },
                          elevation: 5,
                          child: Icon(Icons.arrow_forward),
                          backgroundColor: mainColor)
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
