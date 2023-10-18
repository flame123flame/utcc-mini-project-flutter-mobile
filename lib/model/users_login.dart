class UserLogin {
  String? jwttoken;
  String? username;
  String? role;
  String? firstName;
  String? lastName;
  String? email;
  String? prefix;
  String? phoneNumber;
  String? employeeCode;
  String? createDate;
  String? roleCode;
  String? position;
  int? employeeId;
  int? busTerminalId;
  int? buslinesId;
  String? employeeStatus;
  String? employeeShift;
  UserLogin({
    this.jwttoken,
    this.employeeId,
    this.username,
    this.role,
    this.firstName,
    this.lastName,
    this.email,
    this.prefix,
    this.phoneNumber,
    this.employeeCode,
    this.createDate,
    this.roleCode,
    this.position,
    this.busTerminalId,
    this.buslinesId,
    this.employeeStatus,
    this.employeeShift,
  });

  UserLogin.fromJson(Map<String, dynamic> json) {
    jwttoken = json['jwttoken'];
    username = json['username'];
    employeeId = json['employeeId'];
    role = json['role'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    prefix = json['prefix'];
    phoneNumber = json['phoneNumber'];
    employeeCode = json['employeeCode'];
    createDate = json['createDate'];
    roleCode = json['roleCode'];
    position = json['position'];
    busTerminalId = json['busTerminalId'];
    buslinesId = json['buslinesId'];
    employeeStatus = json['employeeStatus'];
    employeeShift = json['employeeShift'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jwttoken'] = this.jwttoken;
    data['username'] = this.username;
    data['employeeId'] = this.employeeId;
    data['role'] = this.role;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['prefix'] = this.prefix;
    data['phoneNumber'] = this.phoneNumber;
    data['employeeCode'] = this.employeeCode;
    data['createDate'] = this.createDate;
    data['roleCode'] = this.roleCode;
    data['position'] = this.position;
    data['busTerminalId'] = this.busTerminalId;
    data['buslinesId'] = this.buslinesId;
    data['employeeStatus'] = this.employeeStatus;
    data['employeeShift'] = this.employeeShift;
    return data;
  }
}
