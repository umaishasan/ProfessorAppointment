class Messaging {
  Messaging({
    required this.Message,
    required this.Name,
    required this.MesageTime,
    required this.Id,
    required this.UserImage,
  });
  late final String Message;
  late final String Name;
  late final String MesageTime;
  late final String Id;
  late final String UserImage;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Message'] = Message;
    data['Name'] = Name;
    data['MesageTime'] = MesageTime;
    data['Id'] = Id;
    data['UserImage'] = UserImage;
    return data;
  }

  Messaging.fromJson(Map<String, dynamic> json) {
    Message = json['Message'];
    Name = json['Name'];
    MesageTime = json['MesageTime'];
    Id = json['Id'];
    UserImage = json['UserImage'];
  }
}
