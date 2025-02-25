import 'package:flutter/material.dart';

class Person with ChangeNotifier {
  late String _name = "";
  late String _id = "";
  late String _email = "";
  late String _phone = "";
  late String _gender = "";
  late String _user = "";
  late String _qualification = "";
  late String _userImageUrl = "";
  late String _pushToken = "";

  void updateUserData(Map<String, dynamic> userData) {
    _name = userData["Username"] ?? "";
    _id = userData["Id"] ?? "";
    _email = userData["Email"] ?? "";
    _phone = userData["Phone"] ?? "";
    _gender = userData["Gender"] ?? "";
    _user = userData["User"] ?? "";
    _qualification = userData["Qualification"] ?? "";
    _userImageUrl = userData["UserImage"] ?? "";
    _pushToken = userData["PushToken"] ?? "";
    notifyListeners(); // UI ko update karne ke liye zaroori hai
  }

  // Getter name
  String get Name => _name;
  // Getter id
  String get Id => _id;
  // Getter email
  String get Email => _email;
  // Getter phone
  String get Phone => _phone;
  // Getter gender
  String get Gender => _gender;
  // Getter user
  String get User => _user;
  // Getter qualification
  String get Qualification => _qualification;
  //Setter name
  String get UserImage => _userImageUrl;
  //Setter name
  String get PushToken => _pushToken;

  // Setter Name
  set Name(String newName) {
    _name = newName;
    notifyListeners();
  }

  //Setter id
  set Id(String newId) {
    _id = newId;
    notifyListeners();
  }

  //Setter email
  set Email(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  // Setter phone
  set Phone(String newPhone) {
    _phone = newPhone;
    notifyListeners();
  }

  // Setter gender
  set Gender(String newGender) {
    _gender = newGender;
    notifyListeners();
  }

  // Setter user
  set User(String newUser) {
    _user = newUser;
    notifyListeners();
  }

  // Setter qualification
  set Qualification(String newQualification) {
    _qualification = newQualification;
    notifyListeners();
  }

  // Setter User image
  set UserImage(String newUserImage) {
    _userImageUrl = newUserImage;
    notifyListeners();
  }

  // Setter User image
  set PushToken(String newPushToken) {
    _pushToken = newPushToken;
    notifyListeners();
  }
}
