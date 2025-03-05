class Schedule {
  Schedule(
      {required this.Status,
      required this.Qualification,
      required this.Name,
      required this.DateTimes,
      required this.Id,
      required this.UserImage});

  late String Status;
  late String Name;
  late String Id;
  late String Qualification;
  late String UserImage;
  late List<String> DateTimes = [];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = Id;
    data['Name'] = Name;
    data['Qualification'] = Qualification;
    data['Status'] = Status;
    data['DatesTimes'] = DateTimes;
    data['UserImage'] = UserImage;
    return data;
  }

  Schedule.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    Name = json['Name'];
    Qualification = json['Qualification'];
    Status = json['Status'];
    UserImage = json['UserImage'];
    DateTimes = List<String>.from(json['DatesTimes'] ?? []);
  }
}
