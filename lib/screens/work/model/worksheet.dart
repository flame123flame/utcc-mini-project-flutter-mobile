class Worksheet {
  int? worksheetId;
  String? worksheetDate;
  String? worksheetTimeBegin;
  String? worksheetTimeEnd;
  String? worksheetStatus;
  String? busVehiclePlateNo;
  String? worksheetDispatcher;
  String? worksheetDriver;
  String? worksheetFarecollect;
  String? worksheetBuslinesManager;
  String? createBy;
  String? updateBy;
  String? createDate;
  String? updateDate;

  Worksheet(
      {this.worksheetId,
      this.worksheetDate,
      this.worksheetTimeBegin,
      this.worksheetTimeEnd,
      this.worksheetStatus,
      this.busVehiclePlateNo,
      this.worksheetDispatcher,
      this.worksheetDriver,
      this.worksheetFarecollect,
      this.worksheetBuslinesManager,
      this.createBy,
      this.updateBy,
      this.createDate,
      this.updateDate});

  Worksheet.fromJson(Map<String, dynamic> json) {
    worksheetId = json['worksheetId'];
    worksheetDate = json['worksheetDate'];
    worksheetTimeBegin = json['worksheetTimeBegin'];
    worksheetTimeEnd = json['worksheetTimeEnd'];
    worksheetStatus = json['worksheetStatus'];
    busVehiclePlateNo = json['busVehiclePlateNo'];
    worksheetDispatcher = json['worksheetDispatcher'];
    worksheetDriver = json['worksheetDriver'];
    worksheetFarecollect = json['worksheetFarecollect'];
    worksheetBuslinesManager = json['worksheetBuslinesManager'];
    createBy = json['createBy'];
    updateBy = json['updateBy'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['worksheetId'] = this.worksheetId;
    data['worksheetDate'] = this.worksheetDate;
    data['worksheetTimeBegin'] = this.worksheetTimeBegin;
    data['worksheetTimeEnd'] = this.worksheetTimeEnd;
    data['worksheetStatus'] = this.worksheetStatus;
    data['busVehiclePlateNo'] = this.busVehiclePlateNo;
    data['worksheetDispatcher'] = this.worksheetDispatcher;
    data['worksheetDriver'] = this.worksheetDriver;
    data['worksheetFarecollect'] = this.worksheetFarecollect;
    data['worksheetBuslinesManager'] = this.worksheetBuslinesManager;
    data['createBy'] = this.createBy;
    data['updateBy'] = this.updateBy;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    return data;
  }
}
