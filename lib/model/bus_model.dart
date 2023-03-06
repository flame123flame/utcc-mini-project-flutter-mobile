class BusModel {
  String? busVehiclePlateNo;
  String? busVehiclePlateProv;
  String? busVehicleNumber;
  String? typeName;

  BusModel(
      {this.busVehiclePlateNo,
      this.busVehiclePlateProv,
      this.busVehicleNumber,
      this.typeName});

  BusModel.fromJson(Map<String, dynamic> json) {
    busVehiclePlateNo = json['busVehiclePlateNo'];
    busVehiclePlateProv = json['busVehiclePlateProv'];
    busVehicleNumber = json['busVehicleNumber'];
    typeName = json['typeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['busVehiclePlateNo'] = this.busVehiclePlateNo;
    data['busVehiclePlateProv'] = this.busVehiclePlateProv;
    data['busVehicleNumber'] = this.busVehicleNumber;
    data['typeName'] = this.typeName;
    return data;
  }
}
