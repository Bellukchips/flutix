part of '../../../../services/services.dart';

class UsersServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection("users");
  // for update users;

  static Future<void> updateUser(Users user) async {
    await _userCollection.document(user.id).setData({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': user.selectedGenres,
      'selectedLanguage': user.selectedLanguage,
      'profilePicture': user.profilePicture ?? ""
    }).then((value) {
      print('success');
    }).catchError((error) {
      print(error);
    });
  }

  static Future<void> saveUserGmail(Users user) async {
    await _userCollection
        .document(user.id)
        .setData({
          'email': user.email,
          'name': user.name,
          'balance': user.balance,
          'selectedGenres': user.selectedGenres,
          'selectedLanguage': user.selectedLanguage,
          'profilePicture': user.profilePicture ?? ""
        })
        .then((value) {
          print('success');
        })
        .timeout(Duration(seconds: 10))
        .catchError((error) {
          print('error');
        });
  }

  static Future<Users> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.document(id).get();

    return Users(id, snapshot.data['email'],
        balance: snapshot.data['balance'],
        profilePicture: snapshot.data['profilePicture'],
        selectedGenres: (snapshot.data['selectedGenres'] as List)
            .map((e) => e.toString())
            .toList(),
        selectedLanguage: snapshot.data['selectedLanguage'],
        name: snapshot.data['name']);
  }
}
