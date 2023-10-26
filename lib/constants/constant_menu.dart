import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model_components/main_menu.dart';
import '../model_components/menu_role.dart';
import '../screens/driver/driver_list.dart';
import '../screens/fare/fare_list.dart';
import '../screens/news/news_list_manage.dart';
import '../screens/supervisor/overview.dart';
import '../screens/terminal_agent/terminal_agent_list.dart';
import '../screens/users/list_role.dart';
import '../screens/users/list_user.dart';
import '../screens/users/manage_user.dart';
import '../screens/work/work_list.dart';

List<MainMenu> listMenuConstant = [
  MainMenu(
      menu: 'จ่ายงาน',
      subMenu: 'เจ้าหน้าที่จ่ายงาน',
      role: 'DISPATCHER',
      color: Colors.amber,
      icon: Icon(
        Icons.book,
        color: Colors.white,
      ),
      navigate: WorkList()),
  MainMenu(
      menu: 'พนักงานขับรถ',
      subMenu: 'พนักงานขับรถโดยสาร',
      role: 'DRIVER',
      color: Color.fromARGB(255, 56, 223, 53),
      icon: Icon(
        CupertinoIcons.bus,
        color: Colors.white,
      ),
      navigate: DriverList()),
  MainMenu(
      menu: 'เก็บค่าโดยสาร',
      subMenu: 'พนักงานเก็บค่าโดยสาร (กระเป๋ารถเมล์)',
      role: 'FARECOLLECT',
      color: Color.fromARGB(255, 56, 223, 53),
      icon: Icon(
        Icons.money,
        color: Colors.white,
      ),
      navigate: FareList()),
  MainMenu(
      menu: 'นายท่า',
      subMenu: 'พนักงานตรวจอนุมัตจบใบงาน',
      role: 'TERMINALAGENT',
      color: Color.fromARGB(255, 2, 71, 161),
      icon: Icon(
        CupertinoIcons.person,
        color: Colors.white,
      ),
      navigate: TerminalAgentList()),
  MainMenu(
      menu: 'จัดการสาย',
      subMenu: 'จัดการสายรถเมล์',
      role: 'BUSLINESMANAGER',
      color: Color.fromARGB(255, 2, 71, 161),
      icon: Icon(
        CupertinoIcons.person,
        color: Colors.white,
      ),
      navigate: Overview()),
];

List<MenuRole>? listCheckboxRole = [
  MenuRole(name: "จ่ายงาน", value: 0, code: "DISPATCHER"),
  MenuRole(name: "เก็บค่าโดยสาร", value: 0, code: "FARECOLLECT"),
  MenuRole(name: "รถที่ต้องขับ", value: 0, code: "DRIVER"),
  MenuRole(name: "ผู้จัดการสาย", value: 0, code: "BUSLINESMANAGER"),
  MenuRole(name: "เพิ่มข่าวสาร", value: 0, code: "NEWS"),
  MenuRole(name: "ประเภทรถเมล์", value: 0, code: "BUSTYPE"),
  MenuRole(name: "ผู้ใช้งานในระบบ", value: 0, code: "USER"),
  MenuRole(name: "สิทธ์การใช้งานในระบบ", value: 0, code: "ROLE")
];
