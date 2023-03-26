class Ticket {
  String? ticketNo;
  String? ticketNoSum;
  bool? ticketBegin;
  bool? ticketEnd;
  int? fareId;
  int? worksheetId;
  int? trip;

  Ticket(
      {this.ticketNo,
      this.ticketNoSum,
      this.ticketBegin,
      this.ticketEnd,
      this.fareId,
      this.worksheetId,
      this.trip});

  Ticket.fromJson(Map<String, dynamic> json) {
    ticketNo = json['ticketNo'];
    ticketNoSum = json['ticketNoSum'];
    ticketBegin = json['ticketBegin'];
    ticketEnd = json['ticketEnd'];
    fareId = json['fareId'];
    worksheetId = json['worksheetId'];
    trip = json['trip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketNo'] = this.ticketNo;
    data['ticketNoSum'] = this.ticketNoSum;
    data['ticketBegin'] = this.ticketBegin;
    data['ticketEnd'] = this.ticketEnd;
    data['fareId'] = this.fareId;
    data['worksheetId'] = this.worksheetId;
    data['trip'] = this.trip;
    return data;
  }
}
