import 'package:flutter/material.dart';

class MainMenu {
  String menu;
  String subMenu;
  String? role;
  Icon icon;
  Color color;
  Widget navigate;

  MainMenu(
      {required this.menu,
      required this.subMenu,
      required this.icon,
      required this.color,
      this.role,
      required this.navigate});
}
