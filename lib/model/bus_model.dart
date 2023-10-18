class BusModel {
  String? busVehiclePlateNo;
  String? busVehiclePlateProv;
  String? busVehicleNumber;
  String? busTypeName;

  BusModel(
      {this.busVehiclePlateNo,
      this.busVehiclePlateProv,
      this.busVehicleNumber,
      this.busTypeName});

  BusModel.fromJson(Map<String, dynamic> json) {
    busVehiclePlateNo = json['busVehiclePlateNo'];
    busVehiclePlateProv = json['busVehiclePlateProv'];
    busVehicleNumber = json['busVehicleNumber'];
    busTypeName = json['busTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['busVehiclePlateNo'] = this.busVehiclePlateNo;
    data['busVehiclePlateProv'] = this.busVehiclePlateProv;
    data['busVehicleNumber'] = this.busVehicleNumber;
    data['busTypeName'] = this.busTypeName;
    return data;
  }
}
