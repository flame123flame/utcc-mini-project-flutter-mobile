class Worksheet {
  String? worksheetDate;
  int? worksheetId;
  String? worksheetTimeBegin;
  String? worksheetTimeEnd;
  int? worksheetHours;
  int? worksheetHoursOt;
  int? busLinesId;
  String? busLinesNo;
  int? busDivisionId;
  String? busDivisionName;
  int? busVehicleId;
  String? busVehiclePlateNo;
  String? busVehicleNumber;
  String? worksheetDispatcher;
  String? worksheetDriver;
  String? worksheetFarecollect;
  String? worksheetTerminalAgent;
  String? worksheetBuslinesManager;
  String? worksheetStatus;

  Worksheet(
      {this.worksheetDate,
      this.worksheetId,
      this.worksheetTimeBegin,
      this.worksheetTimeEnd,
      this.worksheetHours,
      this.worksheetHoursOt,
      this.busLinesId,
      this.busLinesNo,
      this.busDivisionId,
      this.busDivisionName,
      this.busVehicleId,
      this.busVehiclePlateNo,
      this.busVehicleNumber,
      this.worksheetDispatcher,
      this.worksheetDriver,
      this.worksheetFarecollect,
      this.worksheetTerminalAgent,
      this.worksheetBuslinesManager,
      this.worksheetStatus});

  Worksheet.fromJson(Map<String, dynamic> json) {
    worksheetDate = json['worksheetDate'];
    worksheetId = json['worksheetId'];
    worksheetTimeBegin = json['worksheetTimeBegin'];
    worksheetTimeEnd = json['worksheetTimeEnd'];
    worksheetHours = json['worksheetHours'];
    worksheetHoursOt = json['worksheetHoursOt'];
    busLinesId = json['busLinesId'];
    busLinesNo = json['busLinesNo'];
    busDivisionId = json['busDivisionId'];
    busDivisionName = json['busDivisionName'];
    busVehicleId = json['busVehicleId'];
    busVehiclePlateNo = json['busVehiclePlateNo'];
    busVehicleNumber = json['busVehicleNumber'];
    worksheetDispatcher = json['worksheetDispatcher'];
    worksheetDriver = json['worksheetDriver'];
    worksheetFarecollect = json['worksheetFarecollect'];
    worksheetTerminalAgent = json['worksheetTerminalAgent'];
    worksheetBuslinesManager = json['worksheetBuslinesManager'];
    worksheetStatus = json['worksheetStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['worksheetDate'] = this.worksheetDate;
    data['worksheetId'] = this.worksheetId;
    data['worksheetTimeBegin'] = this.worksheetTimeBegin;
    data['worksheetTimeEnd'] = this.worksheetTimeEnd;
    data['worksheetHours'] = this.worksheetHours;
    data['worksheetHoursOt'] = this.worksheetHoursOt;
    data['busLinesId'] = this.busLinesId;
    data['busLinesNo'] = this.busLinesNo;
    data['busDivisionId'] = this.busDivisionId;
    data['busDivisionName'] = this.busDivisionName;
    data['busVehicleId'] = this.busVehicleId;
    data['busVehiclePlateNo'] = this.busVehiclePlateNo;
    data['busVehicleNumber'] = this.busVehicleNumber;
    data['worksheetDispatcher'] = this.worksheetDispatcher;
    data['worksheetDriver'] = this.worksheetDriver;
    data['worksheetFarecollect'] = this.worksheetFarecollect;
    data['worksheetTerminalAgent'] = this.worksheetTerminalAgent;
    data['worksheetBuslinesManager'] = this.worksheetBuslinesManager;
    data['worksheetStatus'] = this.worksheetStatus;
    return data;
  }
}
