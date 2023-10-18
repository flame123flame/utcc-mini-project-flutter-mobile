class BusLines {
  int? busLinesId;
  String? busLinesNo;
  String? busLinesOrigin;
  String? busLinesDestination;
  String? busLinesExpressway;
  bool? busLinesNightshift;
  String? createDate;
  String? updateDate;
  int? buslinesHbusterminalId;
  String? busTerminalName;
  int? busTerminalId;
  String? listDetail;

  BusLines(
      {this.busLinesId,
      this.busLinesNo,
      this.busLinesOrigin,
      this.busLinesDestination,
      this.busLinesExpressway,
      this.busLinesNightshift,
      this.createDate,
      this.updateDate,
      this.buslinesHbusterminalId,
      this.busTerminalName,
      this.busTerminalId,
      this.listDetail});

  BusLines.fromJson(Map<String, dynamic> json) {
    busLinesId = json['busLinesId'];
    busLinesNo = json['busLinesNo'];
    busLinesOrigin = json['busLinesOrigin'];
    busLinesDestination = json['busLinesDestination'];
    busLinesExpressway = json['busLinesExpressway'];
    busLinesNightshift = json['busLinesNightshift'];
    createDate = json['createDate'];
    updateDate = json['updateDate'];
    buslinesHbusterminalId = json['buslinesHbusterminalId'];
    busTerminalName = json['busTerminalName'];
    busTerminalId = json['busTerminalId'];
    listDetail = json['listDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['busLinesId'] = this.busLinesId;
    data['busLinesNo'] = this.busLinesNo;
    data['busLinesOrigin'] = this.busLinesOrigin;
    data['busLinesDestination'] = this.busLinesDestination;
    data['busLinesExpressway'] = this.busLinesExpressway;
    data['busLinesNightshift'] = this.busLinesNightshift;
    data['createDate'] = this.createDate;
    data['updateDate'] = this.updateDate;
    data['buslinesHbusterminalId'] = this.buslinesHbusterminalId;
    data['busTerminalName'] = this.busTerminalName;
    data['busTerminalId'] = this.busTerminalId;
    data['listDetail'] = this.listDetail;
    return data;
  }
}
