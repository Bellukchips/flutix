part of '../../../../models/models.dart';

class RegistrationUser {
  String name;
  String email;
  String password;
  List<String> selectedGenre;
  String selectedLanguage;
  File profileImage;

  RegistrationUser(
      {this.name = "",
      this.email = "",
      this.password = "",
      this.selectedGenre = const [],
      this.selectedLanguage = "",
      this.profileImage});
}
