class BusVehicle {
  int? busVehicleId;
  String? busVehiclePlateNo;
  String? busVehiclePlateProv;
  String? busVehicleNumber;
  int? busLinesId;
  int? typeId;
  int? busDivisionId;
  String? createBy;
  String? updateBy;
  String? createDate;
  String? updateDate;

  BusVehicle(
      {this.busVehicleId,
      this.busVehiclePlateNo,
      this.busVehiclePlateProv,
      this.busVehicleNumber,
      this.busLinesId,
      this.typeId,
      this.busDivisionId,
      this.createBy,
      this.updateBy,
      this.createDate,
      this.updateDate});

  BusVehicle.fromJson(Map<String, dynamic> json) {
    busVehicleId = json['busVehicleId'];
    busVehiclePlateNo = json['busVehiclePlateNo'];
    busVehiclePlateProv = json['busVehiclePlateProv'];
    busVehicleNumber = json['busVehicleNumber'];
    busLinesId = json['busLinesId'];
    typeId = json['typeId'];
    busDivisionId = json['busDivisionId'];
    createBy = json['createBy'];
    updateBy = json['updateBy'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['busVehicleId'] = this.busVehicleId;
    data['busVehiclePlateNo'] = this.busVehiclePlateNo;
    data['busVehiclePlateProv'] = this.busVehiclePlateProv;
    data['busVehicleNumber'] = this.busVehicleNumber;
    data['busLinesId'] = this.busLinesId;
    data['typeId'] = this.typeId;
    data['busDivisionId'] = this.busDivisionId;
    data['createBy'] = this.createBy;
    data['updateBy'] = this.updateBy;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    return data;
  }
}
