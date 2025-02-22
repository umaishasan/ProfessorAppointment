class Appointment {
  Appointment({
    required this.Id,
    required this.User,
    required this.Name,
    required this.DateTimes,
    required this.Accept,
    required this.TeacherName,
    required this.TeacherQualification,
  });

  late String Id;
  late String User;
  late String Name;
  late String DateTimes;
  late bool Accept;
  late String TeacherName;
  late String TeacherQualification;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = Id;
    data['Name'] = Name;
    data['Accept'] = Accept;
    data['User'] = User;
    data['DatesTimes'] = DateTimes;
    data['TeacherName'] = TeacherName;
    data['TeaQualif'] = TeacherQualification;
    return data;
  }

  Appointment.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    Name = json['Name'];
    User = json['User'];
    Accept = json['Accept'];
    DateTimes = json['DateTime'];
    TeacherName = json['TeacherName'];
    TeacherQualification = json['TeaQualif'];
  }
}
