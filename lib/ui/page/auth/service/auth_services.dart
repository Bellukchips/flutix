part of './../../../../services/services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = new GoogleSignIn();
  static CollectionReference _userCollection =
      Firestore.instance.collection("users");
  static Future<SignInSignUpResult> signUp(
      {String email,
      String password,
      String name,
      List<String> selectedGenres,
      String selectedLanguage,
      String profilePicture}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Users user = result.user.convertToUser(
          name: name,
          profilePicture: profilePicture,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

      await UsersServices.updateUser(user);

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      Users user = await result.user.fromFireStore();

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1].trim());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static Stream<FirebaseUser> get userStream => _auth.onAuthStateChanged;

  static Future<FirebaseUser> gmailSignIn() async {
    //1
    try {
      GoogleSignInAccount _googleAccount = await googleSignIn.signIn();
      if (_googleAccount == null) {
        return null;
      }
      //2
      GoogleSignInAuthentication _googleAuth =
          await _googleAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      //3
      AuthResult result = await _auth.signInWithCredential(credential);
      FirebaseUser user = await _auth.currentUser();
      gmailSignUp(user);
      return user;
    } catch (error) {
      throw PlatformException(code: error.code, message: error.message);
    }
  }

  static Future<FirebaseUser> gmailSignUp(FirebaseUser user) async {
    DocumentSnapshot snapshot = await _userCollection.document(user.uid).get();
    if (!snapshot.exists || snapshot == null) {
      List<String> genres = [];
      Users users = Users(
        user.uid,
        user.email,
        balance: 0,
        name: user.displayName,
        profilePicture: user.photoUrl,
        selectedGenres: genres,
        selectedLanguage: "English",
      );
      await UsersServices.saveUserGmail(users);
    }
    return null;
  }
}

class SignInSignUpResult {
  final Users user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}
