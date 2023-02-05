class User {
  int? employeeId;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? employeeCode;
  String? createDate;
  String? roleCode;
  String? position;
  int? id;

  User(
      {this.employeeId,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.employeeCode,
      this.createDate,
      this.roleCode,
      this.position,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    employeeCode = json['employeeCode'];
    createDate = json['createDate'];
    roleCode = json['roleCode'];
    position = json['position'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeId'] = this.employeeId;
    data['username'] = this.username;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['employeeCode'] = this.employeeCode;
    data['createDate'] = this.createDate;
    data['roleCode'] = this.roleCode;
    data['position'] = this.position;
    data['id'] = this.id;
    return data;
  }
}
