class Model {
  late String Name;
  // Getter
  String get name => Name;

  // Setter
  set name(String newName) {
    if (newName.isNotEmpty) {
      // Optional validation
      Name = newName;
    } else {
      print("Name cannot be empty");
    }
  }
}
