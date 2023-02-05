import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:utcc_mobile/screens/supervisor/overview.dart';
import 'package:utcc_mobile/screens/users/list_role.dart';
import 'package:utcc_mobile/screens/users/list_user.dart';
import 'package:utcc_mobile/screens/users/manage_user.dart';
import '../constants/constant_color.dart';
import '../model/users_login.dart';
import '../model_components/main_menu.dart';
import '../provider/user_login_provider.dart';
import '../service/api_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getDataDropdownFarmer() async {
    try {
      UserLogin temp = await ApiService.apiGetUserById(11);
    } catch (e) {
      print(e);
    }
  }

  UserLoginProvider? userLoginProvider;
  List<MainMenu> listMenu = [
    MainMenu(
        menu: 'จ่ายงาน',
        subMenu: 'ผู้จ่ายงาน',
        role: 'DISPATCHER',
        color: Colors.amber,
        icon: Icon(
          Icons.book,
          color: Colors.white,
        ),
        navigate: ManageUser()),
    MainMenu(
        menu: 'เก็บค่าโดยสาร',
        subMenu: 'พนักงานเก็บค่าโดยสาร (กระเป๋า)',
        role: 'FARECOLLECT',
        color: Color.fromARGB(255, 56, 223, 53),
        icon: Icon(
          Icons.money,
          color: Colors.white,
        ),
        navigate: ManageUser()),
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
          CupertinoIcons.chart_bar,
          color: Colors.white,
        ),
        navigate: Overview()),
    MainMenu(
        menu: 'ผู้ใช้งานในระบบ',
        subMenu: 'จัดการผู้ใช้งานในระบบ',
        role: 'USER',
        color: Color.fromARGB(255, 232, 95, 32),
        icon: Icon(
          Icons.person,
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
        navigate: ListRole())
  ];
  List<MainMenu> listMenuDisplay = [];

  @override
  void initState() {
    userLoginProvider = Provider.of<UserLoginProvider>(context, listen: false);
    List<String> list = userLoginProvider!.getUserLogin.roleCode!.split(",");
    for (var i = 0; i < list.length; i++) {
      listMenuDisplay.addAll(
          listMenu.where((element) => element.role == list[i].toString()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: Color(0xfff5f7fa),
          body: Column(children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.27,
                  width: size.width,
                ),
                GradientContainer(size),
                Positioned(
                    top: size.height * .10,
                    left: 30,
                    child: Row(
                      children: [
                        // SvgPicture.asset(
                        //   'assets/images/Logo1.svg',
                        //   width: 100,
                        // ),
                        Image(
                          image: AssetImage("assets/images/logo3.png"),
                          fit: BoxFit.fill,
                          width: 60,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                " บัตรรถเมล์อิเล็กทรอนิกส์",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 23),
                              ),
                              Consumer<UserLoginProvider>(
                                  builder: (context, value, child) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 6, bottom: 5),
                                  child: Text(
                                    "  ${value.getUserLogin.prefix}${value.getUserLogin.firstName} ${value.getUserLogin.lastName} ${value.getUserLogin.position}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16),
                                  ),
                                );
                              }),
                              Row(children: []),
                            ]),
                      ],
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    'เมนูในระบบ',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Container(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(14),
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    crossAxisCount: 1,
                    childAspectRatio: 3.9,
                    children: [
                      ...List.generate(listMenuDisplay.length, (index) {
                        return Container(
                          child: InkWell(
                            onTap: () => {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: listMenuDisplay[index].navigate,
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              )
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                child: ClipPath(
                                  clipper: ShapeBorderClipper(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4))),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color:
                                                  listMenuDisplay[index].color,
                                              width: 5)),
                                    ),
                                    child: Center(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                            backgroundColor:
                                                listMenuDisplay[index].color,
                                            child: listMenuDisplay[index].icon),
                                        title: Text(
                                          '${listMenuDisplay[index].menu.toString()}',
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 80, 78, 78),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17.5),
                                        ),
                                        subtitle: Text(
                                          '${listMenuDisplay[index].subMenu.toString()}',
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 152, 151, 151),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ]));
    });
  }

  Container GradientContainer(Size size) {
    return Container(
      height: size.height * 0.25,
      width: size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          image: DecorationImage(
              image: AssetImage('assets/images/Logo.png'), fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(13),
                bottomRight: Radius.circular(13)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [colorBar.withOpacity(0.57), colorBar.withOpacity(1)])),
      ),
    );
  }
}
