class Appointment {
  Appointment({
    required this.Id,
    required this.User,
    required this.Name,
    required this.DateTimes,
    required this.Accept,
  });

  late String Id;
  late String User;
  late String Name;
  late String DateTimes;
  late bool Accept;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = Id;
    data['Name'] = Name;
    data['Accept'] = Accept;
    data['User'] = User;
    data['DatesTimes'] = DateTimes;
    return data;
  }

  Appointment.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    Name = json['Name'];
    User = json['User'];
    Accept = json['Accept'];
    DateTimes = json['DateTime'];
  }
}
