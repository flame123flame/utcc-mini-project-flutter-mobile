class RoleModel {
  int? fwRoleId;
  String? roleCode;
  String? roleName;
  List<String>? munuList;
  String? roleDescription;
  String? createBy;
  String? createDate;
  String? updateBy;
  String? updateDate;

  RoleModel(
      {this.fwRoleId,
      this.roleCode,
      this.roleName,
      this.munuList,
      this.roleDescription,
      this.createBy,
      this.createDate,
      this.updateBy,
      this.updateDate});

  RoleModel.fromJson(Map<String, dynamic> json) {
    fwRoleId = json['fwRoleId'];
    roleCode = json['roleCode'];
    roleName = json['roleName'];
    munuList = json['munuList'].cast<String>();
    roleDescription = json['roleDescription'];
    createBy = json['createBy'];
    createDate = json['createDate'];
    updateBy = json['updateBy'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fwRoleId'] = this.fwRoleId;
    data['roleCode'] = this.roleCode;
    data['roleName'] = this.roleName;
    data['munuList'] = this.munuList;
    data['roleDescription'] = this.roleDescription;
    data['createBy'] = this.createBy;
    data['createDate'] = this.createDate;
    data['updateBy'] = this.updateBy;
    data['updateDate'] = this.updateDate;
    return data;
  }
}
