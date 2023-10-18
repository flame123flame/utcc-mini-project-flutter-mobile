class RequestTicket {
  late int fareId;
  late String ticketNo;

  RequestTicket({required this.fareId, required this.ticketNo});

  RequestTicket.fromJson(Map<String, dynamic> json) {
    fareId = json['fareId'];
    ticketNo = json['ticketNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fareId'] = fareId;
    data['ticketNo'] = ticketNo;
    return data;
  }
}
