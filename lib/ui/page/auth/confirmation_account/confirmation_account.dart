part of './../../pages.dart';

class ConfirmationAccountPage extends StatefulWidget {
  final RegistrationUser registrationUser;
  ConfirmationAccountPage(this.registrationUser);
  @override
  _ConfirmationAccountPageState createState() =>
      _ConfirmationAccountPageState();
}

class _ConfirmationAccountPageState extends State<ConfirmationAccountPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToPreferencePage(widget.registrationUser));
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
                      margin: EdgeInsets.only(top: 20, bottom: 90),
                      height: 56,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                context.bloc<PageBloc>().add(GoToPreferencePage(
                                    widget.registrationUser));
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
                                  .translate('confirmAccount'),
                              style: blackTextFont.copyWith(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:
                                  (widget.registrationUser.profileImage == null)
                                      ? AssetImage("assets/user_pic.png")
                                      : FileImage(
                                          widget.registrationUser.profileImage),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context).translate('welcome'),
                      style: blackTextFont.copyWith(
                          fontSize: 25, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${widget.registrationUser.name}",
                      style: blackTextFont.copyWith(fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 110,
                    ),
                    UploadImage(
                      file: widget.registrationUser.profileImage,
                      email: widget.registrationUser.email,
                      name: widget.registrationUser.name,
                      password: widget.registrationUser.password,
                      selectedGenre: widget.registrationUser.selectedGenre,
                      selectedLanguage:
                          widget.registrationUser.selectedLanguage,
                    )
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

class UploadImage extends StatefulWidget {
  final File file;
  final String name;
  final String email;
  final String password;
  final List<String> selectedGenre;
  final String selectedLanguage;
  const UploadImage(
      {Key key,
      this.file,
      this.name,
      this.email,
      this.password,
      this.selectedGenre,
      this.selectedLanguage})
      : super(key: key);
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  StorageUploadTask uploadTask;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://flutix-1e489.appspot.com');
  String url;
  String path;
  bool isSignUp = false;
  String waiting = "";
  bool saveData = false;

  ///
  ///Alert dialog
  Future alertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(AppLocalizations.of(context).translate('msgFlushbar')),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                context
                    .bloc<PageBloc>()
                    .add(GoToRegisterPage(RegistrationUser()));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  ///
  /////ZXZ
  ///upload image to firebase
  void upload() async {
    String filepath = basename(widget.file.path);
    setState(() {
      waiting = "Please wait ...";
      uploadTask = _storage.ref().child(filepath).putFile(widget.file);
    });

    ///
    ///get url image
    url = await (await uploadTask.onComplete).ref.getDownloadURL();
    path = filepath;
    waiting = "Success upload..";

    ///
    ///
  }

  @override
  Widget build(BuildContext context) {
    if (uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;
            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;
            return Column(
              children: [
                LinearProgressIndicator(
                    value: progressPercent,
                    backgroundColor: accentColor1,
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Color(0xFFFBD460))),
                Text("${(progressPercent * 100).toStringAsFixed(2)} %"),
                Text(waiting, style: blackTextFont.copyWith(fontSize: 15)),
                SizedBox(
                  height: 20,
                ),
                if (uploadTask.isComplete)
                  Center(
                    child: (saveData)
                        ? SizedBox(
                            width: 50,
                            height: 50,
                            child: SpinKitCircle(
                              color: mainColor,
                            ))
                        : FloatingActionButton(
                            elevation: 0,
                            backgroundColor: mainColor,
                            child: Icon(Icons.arrow_forward),
                            onPressed: () async {
                              setState(() {
                                saveData = true;
                              });
                              SignInSignUpResult result =
                                  await AuthServices.signUp(
                                      email: widget.email,
                                      password: widget.password,
                                      name: widget.name,
                                      selectedGenres: widget.selectedGenre,
                                      selectedLanguage: widget.selectedLanguage,
                                      profilePicture: url);
                              if (result.user == null) {
                                Flushbar(
                                  duration: Duration(milliseconds: 1500),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: Color(0xFFFF5C83),
                                  message: result.message,
                                )..show(context);

                                ///delete photo from firebaseStorage
                                ///
                                await _storage.ref().child(path).delete();
                                alertDialog(context);
                              }
                            },
                          ),
                  )
              ],
            );
          });
    } else {
      return (isSignUp)
          ? SizedBox(
              height: 45,
              width: 250,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff3e9d9d),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SpinKitThreeBounce(
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          : Button(
              color: Color(0xff3e9d9d),
              height: 45,
              width: 250,
              textStyle: whiteTextFont.copyWith(fontSize: 16),
              title: AppLocalizations.of(context).translate('createMyAccount'),
              onPressed: () async {
                if (widget.file != null) {
                  upload();
                } else {
                  setState(() {
                    isSignUp = true;
                  });
                  SignInSignUpResult result = await AuthServices.signUp(
                      email: widget.email,
                      password: widget.password,
                      name: widget.name,
                      selectedGenres: widget.selectedGenre,
                      selectedLanguage: widget.selectedLanguage,
                      profilePicture: "");
                  if (result.user == null) {
                    Flushbar(
                      duration: Duration(milliseconds: 1500),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: Color(0xFFFF5C83),
                      message: result.message,
                    )..show(context);
                  }
                }
              },
            );
    }
  }
}
