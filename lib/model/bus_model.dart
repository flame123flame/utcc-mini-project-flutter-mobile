class BusModel {
  int? id;
  String? busNo;
  double? fare;
  double? discountFare;
  String? busType;
  String? createDate;

  BusModel(
      {this.id,
      this.busNo,
      this.fare,
      this.discountFare,
      this.busType,
      this.createDate});

  BusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    busNo = json['busNo'];
    fare = json['fare'];
    discountFare = json['discountFare'];
    busType = json['busType'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['busNo'] = this.busNo;
    data['fare'] = this.fare;
    data['discountFare'] = this.discountFare;
    data['busType'] = this.busType;
    data['createDate'] = this.createDate;
    return data;
  }
}
