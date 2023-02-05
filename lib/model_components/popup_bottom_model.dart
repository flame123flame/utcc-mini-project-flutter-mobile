import 'package:flutter/material.dart';

class PopupBottomModel {
  String? code;
  String title;
  String subTitle;
  Icon icon;
  PopupBottomModel({
    required this.icon,
    this.code,
    required this.title,
    required this.subTitle,
  });
}
