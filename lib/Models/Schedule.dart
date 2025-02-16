class Schedule {
  Schedule({
    required this.Status,
    required this.Qualification,
    required this.Name,
    required this.Time,
    required this.Date,
    required this.Id,
  });
  late final String Status;
  late final String Name;
  late final String Time;
  late final String Id;
  late final String Qualification;
  late final String Date;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Date'] = Date;
    data['Id'] = Id;
    data['Name'] = Name;
    data['Qualification'] = Qualification;
    data['Status'] = Status;
    data['Time'] = Time;
    return data;
  }

  Schedule.fromJson(Map<String, dynamic> json) {
    Date = json['Date'];
    Id = json['Id'];
    Name = json['Name'];
    Qualification = json['Qualification'];
    Status = json['Status'];
    Time = json['Time'];
  }
}
