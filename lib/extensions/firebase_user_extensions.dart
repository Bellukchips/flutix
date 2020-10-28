part of 'extensions.dart';

extension FirebaseUserExtension on FirebaseUser {
  Users convertToUser(
          {String name = "No Name",
          String profilePicture = "",
          List<String> selectedGenres = const [],
          String selectedLanguage = "English",
          int balance = 0}) =>
      Users(this.uid, this.email,
          name: name,
          profilePicture: profilePicture,
          balance: balance,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

  Future<Users> fromFireStore() async => await UsersServices.getUser(this.uid);
}
