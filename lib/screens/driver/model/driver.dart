class Driver {
  int? worksheetId;
  String? worksheetDate;
  bool? worksheetTimeBegin;
  bool? worksheetTimeEnd;
  String? busVehiclePlateNo;
  String? worksheetDispatcher;
  String? worksheetDriver;
  String? worksheetFarecollect;
  String? busVehicleNumber;

  Driver(
      {this.worksheetId,
      this.worksheetDate,
      this.worksheetTimeBegin,
      this.worksheetTimeEnd,
      this.busVehiclePlateNo,
      this.worksheetDispatcher,
      this.worksheetDriver,
      this.worksheetFarecollect,
      this.busVehicleNumber});

  Driver.fromJson(Map<String, dynamic> json) {
    worksheetId = json['worksheetId'];
    worksheetDate = json['worksheetDate'];
    worksheetTimeBegin = json['worksheetTimeBegin'];
    worksheetTimeEnd = json['worksheetTimeEnd'];
    busVehiclePlateNo = json['busVehiclePlateNo'];
    worksheetDispatcher = json['worksheetDispatcher'];
    worksheetDriver = json['worksheetDriver'];
    worksheetFarecollect = json['worksheetFarecollect'];
    busVehicleNumber = json['busVehicleNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['worksheetId'] = this.worksheetId;
    data['worksheetDate'] = this.worksheetDate;
    data['worksheetTimeBegin'] = this.worksheetTimeBegin;
    data['worksheetTimeEnd'] = this.worksheetTimeEnd;
    data['busVehiclePlateNo'] = this.busVehiclePlateNo;
    data['worksheetDispatcher'] = this.worksheetDispatcher;
    data['worksheetDriver'] = this.worksheetDriver;
    data['worksheetFarecollect'] = this.worksheetFarecollect;
    data['busVehicleNumber'] = this.busVehicleNumber;
    return data;
  }
}
