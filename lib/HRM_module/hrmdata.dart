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
