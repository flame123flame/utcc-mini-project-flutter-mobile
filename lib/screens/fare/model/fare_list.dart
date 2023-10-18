import 'package:flutter/material.dart';

class FareListModel {
  int? fareId;
  String? fareDesc;
  String? fareValue;
  TextEditingController? ticketValue;

  FareListModel({
    this.fareId,
    this.fareDesc,
    this.fareValue,
    this.ticketValue,
  });

  factory FareListModel.fromJson(Map<String, dynamic> json) {
    return FareListModel(
      fareId: json['fareId'],
      fareDesc: json['fareDesc'],
      fareValue: json['fareValue'],
      ticketValue: TextEditingController(text: json['ticketValue']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fareId': fareId,
      'fareDesc': fareDesc,
      'fareValue': fareValue,
      'ticketValue': ticketValue?.text,
    };
  }
}
