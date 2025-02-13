import 'package:flutter/material.dart';

class Model with ChangeNotifier {
  late String _name = "";
  late String _email = "";
  late String _phone = "";
  late String _gender = "";
  late String _user = "";

  void updateUserData(Map<String, dynamic> userData) {
    _name = userData["Username"] ?? "";
    _email = userData["Email"] ?? "";
    _phone = userData["Phone"] ?? "";
    _gender = userData["Gender"] ?? "";
    _user = userData["User"] ?? "";

    notifyListeners(); // UI ko update karne ke liye zaroori hai
  }

  // Getter
  // ignore: non_constant_identifier_names, unnecessary_getters_setters
  String get Name => _name;
  // Getter
  // ignore: non_constant_identifier_names, unnecessary_getters_setters
  String get Email => _email;
  // Getter
  // ignore: non_constant_identifier_names, unnecessary_getters_setters
  String get Phone => _phone;
  // Getter
  // ignore: non_constant_identifier_names, unnecessary_getters_setters
  String get Gender => _gender;
  // Getter
  // ignore: non_constant_identifier_names, unnecessary_getters_setters
  String get User => _user;

  // Setter
  // ignore: non_constant_identifier_names
  set Name(String newName) {
    _name = newName;
    notifyListeners();
  }

  // Setter
  // ignore: non_constant_identifier_names
  set Email(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  // Setter
  // ignore: non_constant_identifier_names
  set Phone(String newPhone) {
    _phone = newPhone;
    notifyListeners();
  }

  // Setter
  // ignore: non_constant_identifier_names
  set Gender(String newGender) {
    _gender = newGender;
    notifyListeners();
  }

  // Setter
  // ignore: non_constant_identifier_names
  set User(String newUser) {
    _user = newUser;
    notifyListeners();
  }
}
