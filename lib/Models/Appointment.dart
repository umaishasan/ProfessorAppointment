class Appointment {
  Appointment({
    required this.Id,
    required this.DocId,
    required this.User,
    required this.Name,
    required this.DateTimes,
    required this.Accept,
    required this.TeacherName,
    required this.TeacherId,
    required this.TeacherQualification,
    required this.UserImage,
  });

  late String Id;
  late String DocId;
  late String User;
  late String Name;
  late String DateTimes;
  late bool Accept;
  late String TeacherName;
  late String TeacherId;
  late String TeacherQualification;
  late String UserImage;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = Id;
    data['DocId'] = DocId;
    data['Name'] = Name;
    data['Accept'] = Accept;
    data['User'] = User;
    data['DatesTimes'] = DateTimes;
    data['TeacherName'] = TeacherName;
    data['TeacherId'] = TeacherId;
    data['TeaQualif'] = TeacherQualification;
    data['UserImage'] = UserImage;
    return data;
  }

  Appointment.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    DocId = json['DocId'];
    Name = json['Name'];
    User = json['User'];
    Accept = json['Accept'];
    DateTimes = json['DateTime'];
    TeacherName = json['TeacherName'];
    TeacherId = json['TeacherId'];
    TeacherQualification = json['TeaQualif'];
    UserImage = json['UserImage'];
  }
}
