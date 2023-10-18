class TicketTrip {
  int? ticketTripId;
  int? worksheetId;
  int? trip;
  bool? ticketBegin;
  bool? ticketEnd;
  List<TicketList>? ticketList;
  double? sumPrice;
  int? sumTicket;

  TicketTrip(
      {this.ticketTripId,
      this.worksheetId,
      this.trip,
      this.ticketBegin,
      this.ticketEnd,
      this.ticketList,
      this.sumPrice,
      this.sumTicket});

  TicketTrip.fromJson(Map<String, dynamic> json) {
    ticketTripId = json['ticketTripId'];
    worksheetId = json['worksheetId'];
    trip = json['trip'];
    ticketBegin = json['ticketBegin'];
    ticketEnd = json['ticketEnd'];
    if (json['ticketList'] != null) {
      ticketList = <TicketList>[];
      json['ticketList'].forEach((v) {
        ticketList!.add(new TicketList.fromJson(v));
      });
    }
    sumPrice = json['sumPrice'];
    sumTicket = json['sumTicket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketTripId'] = this.ticketTripId;
    data['worksheetId'] = this.worksheetId;
    data['trip'] = this.trip;
    data['ticketBegin'] = this.ticketBegin;
    data['ticketEnd'] = this.ticketEnd;
    if (this.ticketList != null) {
      data['ticketList'] = this.ticketList!.map((v) => v.toJson()).toList();
    }
    data['sumPrice'] = this.sumPrice;
    data['sumTicket'] = this.sumTicket;
    return data;
  }
}

class TicketList {
  String? ticketNo;
  int? fareId;
  int? ticketTripId;
  String? fareDesc;
  double? fareValue;

  TicketList(
      {this.ticketNo,
      this.fareId,
      this.ticketTripId,
      this.fareDesc,
      this.fareValue});

  TicketList.fromJson(Map<String, dynamic> json) {
    ticketNo = json['ticketNo'];
    fareId = json['fareId'];
    ticketTripId = json['ticketTripId'];
    fareDesc = json['fareDesc'];
    fareValue = json['fareValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketNo'] = this.ticketNo;
    data['fareId'] = this.fareId;
    data['ticketTripId'] = this.ticketTripId;
    data['fareDesc'] = this.fareDesc;
    data['fareValue'] = this.fareValue;
    return data;
  }
}
