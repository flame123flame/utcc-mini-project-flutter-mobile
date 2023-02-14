import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model_components/main_menu.dart';
import '../screens/fare/fare_list.dart';
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
      navigate: ManageUser()),
  MainMenu(
      menu: 'ผู้จัดการสาย',
      subMenu: 'อนุมัตจบใบงาน',
      role: 'BUSSUPERVISOR',
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
