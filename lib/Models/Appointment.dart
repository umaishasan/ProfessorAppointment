class Appointment {
  Appointment({
    required this.User,
    required this.Name,
    required this.DateTimes,
    required this.Accept,
  });

  late String User;
  late String Name;
  late String DateTimes;
  late bool Accept;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Name'] = Name;
    data['Accept'] = Accept;
    data['User'] = User;
    data['DatesTimes'] = DateTimes;
    return data;
  }

  Appointment.fromJson(Map<String, dynamic> json) {
    Name = json['Name'];
    User = json['User'];
    Accept = json['Accept'];
    DateTimes = json['DateTime'];
  }
}
