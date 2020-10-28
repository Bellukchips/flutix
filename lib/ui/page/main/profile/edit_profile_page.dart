part of './../../pages.dart';

class EditProfilePage extends StatefulWidget {
  final Users user;
  EditProfilePage(this.user);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //text editing controller
  TextEditingController nameController;
  TextEditingController emailController;
  String profilePath;
  bool isDataEdited = false;
  File profileImageFile;
  bool isUpdating = false;
  @override
  initState() {
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    profilePath = widget.user.profilePicture;
    super.initState();
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
                      title: new Text(
                          AppLocalizations.of(context).translate('takeGallry')),
                      onTap: () async {
                        if (profileImageFile == null) {
                          Navigator.pop(context);
                          profileImageFile = await getImageGallery();
                        } else if (profileImageFile != null) {
                          Navigator.pop(context);
                          profileImageFile = await getImageGallery();
                        } else {
                          profileImageFile = null;
                        }
                        if (profileImageFile != null) {
                          profilePath = basename(profileImageFile.path);
                        }
                        setState(() {
                          isDataEdited =
                              (nameController.text.trim() != widget.user.name ||
                                      profilePath != widget.user.profilePicture)
                                  ? true
                                  : false;
                        });
                      }),
                  new ListTile(
                      leading: new Icon(Icons.camera_alt, color: accentColor3),
                      title: new Text(
                          AppLocalizations.of(context).translate('takeCamera')),
                      onTap: () async {
                        if (profileImageFile == null) {
                          Navigator.pop(context);
                          profileImageFile = await getImageCamera();
                        } else if (profileImageFile != null) {
                          Navigator.pop(context);
                          profileImageFile = await getImageCamera();
                        } else {
                          profileImageFile = null;
                        }
                        if (profileImageFile != null) {
                          profilePath = basename(profileImageFile.path);
                        }
                        setState(() {
                          isDataEdited =
                              (nameController.text.trim() != widget.user.name ||
                                      profilePath != widget.user.profilePicture)
                                  ? true
                                  : false;
                        });
                      }),
                ],
              ),
            );
          });
    }

    //bloc textfield theme
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
    return WillPopScope(
        onWillPop: () {
          context.bloc<PageBloc>().add(GoToProfileSetting());
          return;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
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
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToProfileSetting());
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
                                .translate('editYourProfil'),
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 95,
                    height: 104,
                    child: Stack(
                      children: [
                        Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: SpinKitCircle(
                              color: mainColor,
                            ),
                          ),
                        ),
                        Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: accentColor2),
                                image: DecorationImage(
                                    image: (profileImageFile != null)
                                        ? FileImage(profileImageFile)
                                        : (profilePath != "")
                                            ? NetworkImage(profilePath)
                                            : AssetImage("assets/user_pic.png"),
                                    fit: BoxFit.cover))),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () async {
                              if (profileImageFile == null) {
                                _settingModalBottomSheet(context);
                              } else if (profileImageFile != null) {
                                _settingModalBottomSheet(context);
                              } else {
                                profileImageFile = null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: (profilePath == "")
                                        ? AssetImage("assets/btn_add_photo.png")
                                        : AssetImage(
                                            "assets/btn_del_photo.png"),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Visibility(
                    visible: false,
                    child: Text(widget.user.id),
                  ),
                  TextField(
                    controller: nameController,
                    style: blackTextFont,
                    onChanged: (text) {
                      setState(() {
                        isDataEdited = (text.trim() != widget.user.name ||
                                profilePath != widget.user.profilePicture)
                            ? true
                            : false;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        hintText: "Full Name",
                        labelText: "Full Name"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AbsorbPointer(
                    child: TextField(
                      controller: emailController,
                      style: greyTextFont,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: "Email Address",
                          labelText: "Email Address"),
                    ),
                  ),
                  //button
                  Container(
                    width: 250,
                    height: 46,
                    margin: EdgeInsets.only(top: 36, bottom: 10),
                    child: RaisedButton(
                      elevation: 0,
                      color: Colors.redAccent,
                      onPressed: (isUpdating)
                          ? null
                          : () async {
                              await AuthServices.resetPassword(
                                  widget.user.email);

                              Flushbar(
                                duration: Duration(milliseconds: 2000),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xFFFF5C83),
                                message:
                                    "The link to change your password has been sent to your email.",
                              )..show(context);
                            },
                      child: Text(
                        "Reset Password",
                        style: whiteTextFont,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  UploadImageEdit(
                    uid: widget.user.id,
                    file: profileImageFile,
                    name: nameController.text,
                    isDataEdited: isDataEdited,
                    nameTemp: widget.user.name,
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}

class UploadImageEdit extends StatefulWidget {
  final File file;
  final bool isDataEdited;
  final String name;
  final String nameTemp;
  final String uid;
  const UploadImageEdit(
      {Key key,
      this.uid,
      this.file,
      this.name,
      this.isDataEdited = false,
      this.nameTemp})
      : super(key: key);
  @override
  _UploadImageEditState createState() => _UploadImageEditState();
}

class _UploadImageEditState extends State<UploadImageEdit> {
  StorageUploadTask uploadTask;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://flutix-1e489.appspot.com');
  String url;
  String path;
  bool isUpdating = false;
  bool updatePhoto = false;
  String waiting = "";

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
                SizedBox(
                  height: 30,
                ),
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
                    child: (updatePhoto)
                        ? SizedBox(
                            width: 50,
                            height: 50,
                            child: SpinKitCircle(
                              color: mainColor,
                            ))
                        : FloatingActionButton(
                            elevation: 0,
                            backgroundColor: mainColor,
                            child: Icon(Icons.arrow_back),
                            onPressed: () async {
                              setState(() {
                                updatePhoto = true;
                              });
                              if (widget.file != null &&
                                  widget.name != widget.nameTemp) {
                                context.bloc<UserBloc>().add(UpdateData(
                                    name: widget.name, profileImage: url));
                                context
                                    .bloc<UserBloc>()
                                    .add(LoadUser(widget.uid));
                              } else {
                                context
                                    .bloc<UserBloc>()
                                    .add(UpdateData(profileImage: url));
                                context
                                    .bloc<UserBloc>()
                                    .add(LoadUser(widget.uid));
                              }
                              Timer(Duration(seconds: 4), () {
                                setState(() {
                                  updatePhoto = false;
                                });
                              });
                              context
                                  .bloc<PageBloc>()
                                  .add(GoToProfileSetting());
                            },
                          ),
                  )
              ],
            );
          });
    } else {
      return (isUpdating)
          ? SizedBox(
              width: 250,
              height: 46,
              child: Container(
                alignment: FractionalOffset.center,
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
          : Container(
              width: 250,
              height: 46,
              margin: EdgeInsets.only(top: 10, bottom: 50),
              child: RaisedButton(
                elevation: 0,
                disabledColor: Color(0xFFE4E4E4),
                color: Color(0xFF3E9D9D),
                onPressed: (widget.isDataEdited)
                    ? () async {
                        if (widget.file != null) {
                          upload();
                        } else {
                          setState(() {
                            isUpdating = true;
                          });
                          context
                              .bloc<UserBloc>()
                              .add(UpdateData(name: widget.name));
                          context.bloc<UserBloc>().add(LoadUser(widget.uid));
                          Timer(Duration(seconds: 4), () {
                            setState(() {
                              isUpdating = false;
                            });
                          });
                          context.bloc<PageBloc>().add(GoToProfileSetting());
                        }
                      }
                    : null,
                child: Text(
                  AppLocalizations.of(context).translate('updateMyProfile'),
                  style: whiteTextFont.copyWith(
                      fontSize: 16,
                      color: (widget.isDataEdited)
                          ? Colors.white
                          : Color(0xFFBEBEBE)),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            );
    }
  }
}
