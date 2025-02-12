class Model {
  late String _name;
  late String _email;
  late String _phon;
  late String _gender;
  late String _user;

  // Getter
  // ignore: non_constant_identifier_names, unnecessary_getters_setters
  String get Name => _name;
  // Getter
  // ignore: non_constant_identifier_names, unnecessary_getters_setters
  String get Email => _email;
  // Getter
  // ignore: non_constant_identifier_names, unnecessary_getters_setters
  String get Phone => _phon;
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
  }

  // Setter
  // ignore: non_constant_identifier_names
  set Email(String newEmail) {
    _email = newEmail;
  }

  // Setter
  // ignore: non_constant_identifier_names
  set Phone(String newPhone) {
    _phon = newPhone;
  }

  // Setter
  // ignore: non_constant_identifier_names
  set Gender(String newGender) {
    _gender = newGender;
  }

  // Setter
  // ignore: non_constant_identifier_names
  set User(String newUser) {
    _user = newUser;
  }
}
