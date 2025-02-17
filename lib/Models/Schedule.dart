class Schedule {
  Schedule({
    required this.Status,
    required this.Qualification,
    required this.Name,
    required this.DateTimes,
    required this.Id,
  });

  late String Status;
  late String Name;
  late String Id;
  late String Qualification;
  late List<String> DateTimes = [];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = Id;
    data['Name'] = Name;
    data['Qualification'] = Qualification;
    data['Status'] = Status;
    data['DateTimes'] = DateTimes;
    return data;
  }

  Schedule.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    Name = json['Name'];
    Qualification = json['Qualification'];
    Status = json['Status'];
    DateTimes = List<String>.from(json['DatesTimes'] ?? []);
  }
}
