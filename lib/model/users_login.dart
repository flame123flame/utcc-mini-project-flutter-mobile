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
  UserLogin(
      {this.jwttoken,
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
      this.position});

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
    return data;
  }
}
