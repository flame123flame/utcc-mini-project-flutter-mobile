import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model_components/main_menu.dart';
import '../model_components/menu_role.dart';
import '../screens/driver/driver_list.dart';
import '../screens/fare/fare_list.dart';
import '../screens/news/news_list_manage.dart';
import '../screens/supervisor/overview.dart';
import '../screens/users/list_role.dart';
import '../screens/users/list_user.dart';
import '../screens/users/manage_user.dart';
import '../screens/work/work_list.dart';

List<MainMenu> listMenuConstant = [
  MainMenu(
      menu: 'จ่ายงาน',
      subMenu: 'ผู้จ่ายงาน',
      role: 'DISPATCHER',
      color: Colors.amber,
      icon: Icon(
        Icons.book,
        color: Colors.white,
      ),
      navigate: WorkList()),
  MainMenu(
      menu: 'เก็บค่าโดยสาร',
      subMenu: 'พนักงานเก็บค่าโดยสาร (กระเป๋า)',
      role: 'FARECOLLECT',
      color: Color.fromARGB(255, 56, 223, 53),
      icon: Icon(
        Icons.money,
        color: Colors.white,
      ),
      navigate: FareList()),
  MainMenu(
      menu: 'รถที่ต้องขับ',
      subMenu: 'พนักงานขับรถ',
      role: 'DRIVER',
      color: Color.fromARGB(255, 163, 46, 37),
      icon: Icon(
        CupertinoIcons.bus,
        color: Colors.white,
      ),
      navigate: DriverList()),
  MainMenu(
      menu: 'ผู้จัดการสาย',
      subMenu: 'อนุมัตจบใบงาน',
      role: 'BUSLINESMANAGER',
      color: Color.fromARGB(255, 2, 71, 161),
      icon: Icon(
        CupertinoIcons.person,
        color: Colors.white,
      ),
      navigate: Overview()),
  MainMenu(
      menu: 'เพิ่มข่าวสาร',
      subMenu: 'เพิ่มข่าวสาร',
      role: 'NEWS',
      color: Color.fromARGB(255, 50, 148, 37),
      icon: Icon(
        CupertinoIcons.news,
        color: Colors.white,
      ),
      navigate: NewsListManage()),
  MainMenu(
      menu: 'ประเภทรถเมล์',
      subMenu: 'ประเภทรถเมล์',
      role: 'BUSTYPE',
      color: Color.fromARGB(255, 170, 92, 32),
      icon: Icon(
        CupertinoIcons.rectangle_grid_2x2,
        color: Colors.white,
      ),
      navigate: Overview()),
  MainMenu(
      menu: 'ผู้ใช้งานในระบบ',
      subMenu: 'จัดการผู้ใช้งานในระบบ',
      role: 'USER',
      color: Color.fromARGB(255, 232, 95, 32),
      icon: Icon(
        Icons.group,
        color: Colors.white,
      ),
      navigate: ListUser()),
  MainMenu(
      menu: 'สิทธ์การใช้งานในระบบ',
      subMenu: 'จัดการสิทธ์การใช้งานในระบบ',
      role: 'ROLE',
      color: Color.fromARGB(255, 30, 215, 187),
      icon: Icon(
        Icons.roller_shades,
        color: Colors.white,
      ),
      navigate: ListRole()),
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
