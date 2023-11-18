class HRMData {
  String name;
  String totaldigit;
  String rate;
  String per;

  HRMData({
    required this.name,
    required this.totaldigit,
    required this.rate,
    required this.per,
  });
}

class DOBData {
  String name;
  String date;

  DOBData({
    required this.name,
    required this.date,
  });
}

class LeaveData {
  String name;
  String date;
  String reas;

  LeaveData({
    required this.name,
    required this.date,
    required this.reas,
  });
}

class EmpName {
  final String uid;
 final String name;
  final String email;
  final String image;
  final DateTime lastActive;
  final bool isOnline;



  EmpName({
    required this.name,
    required this.image,
    required this.uid,
    required this.email,
    required this.lastActive,
    this.isOnline = false,

  });
}


class UserModel {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String profil_pic;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.profil_pic,
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    return UserModel(
      id: id,
      name: json['name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      profil_pic: json['profil_pic'] as String,
    );
  }

  static List<UserModel> fromMap(Map<String, Map<String, dynamic>> map) {
    return map.entries.map((entry) => UserModel.fromJson(entry.key, entry.value)).toList();
  }
}

class Message {
  String text;
  String sender;
  int timestamp;

  Message({
    required this.text,
    required this.sender,
    required this.timestamp,
  });
}

