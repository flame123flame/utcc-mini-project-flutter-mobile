import 'dart:developer';

import 'package:dio/dio.dart';
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
import '../model_components/deather.dart';
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

  // Future getCurrentWeather() async {
  //   Weather weather;
  //   String city = "calgary";
  //   String apiKey = "YOUR API KEY";
  //   var url =
  //       "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

  //   final response = await Uri.https(url);
  //   print(response);

  // }

  getCurrentWeather() async {
    String city = "calgary";
    String apiKey = "d1416ca41c9f44ee6512f540d55b4e69";
    try {
      var response = await Dio().get(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
      print(response);
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
        navigate: ListRole()),
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
    // getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 235, 240, 244),
          body: Column(children: [
            Stack(
              children: [
                GradientContainer(size),
                Positioned(
                    top: size.height * .09,
                    left: 30,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image(
                              image: AssetImage("assets/images/logo3.png"),
                              fit: BoxFit.fill,
                              width: 60,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    " บัตรรถเมล์อิเล็กทรอนิกส์",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 23),
                                  ),
                                  Consumer<UserLoginProvider>(
                                      builder: (context, value, child) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(top: 6, bottom: 5),
                                      child: Text(
                                        "  ${value.getUserLogin.firstName} ${value.getUserLogin.lastName}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16),
                                      ),
                                    );
                                  }),
                                ]),
                          ],
                        ),
                      ],
                    )),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 17, right: 17, top: 168),
                  height: 185,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        // Color.fromARGB(255, 100, 180, 238),
                        // Color(0xff2c79c1),
                        Color.fromARGB(255, 36, 145, 223),
                        Color.fromARGB(255, 12, 54, 151),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              'สภาพอากาศกรุงเทพมหานครวันนี้',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Image(
                                  image:
                                      AssetImage("assets/images/weather.png"),
                                  fit: BoxFit.fill,
                                  width: 100,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("27",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontSize: 52)),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 17),
                                        child: Icon(CupertinoIcons.circle,
                                            color: Colors.white,
                                            weight: 0.5,
                                            size: 15,
                                            grade: 30,
                                            textDirection: TextDirection.rtl),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'สูงสุด: 32',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Icon(CupertinoIcons.circle,
                                    color: Colors.white,
                                    weight: 10.0,
                                    size: 8,
                                    textDirection: TextDirection.rtl),
                              ),
                              Text(
                                '  ต่ำสุด: 24',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Icon(CupertinoIcons.circle,
                                    color: Colors.white,
                                    weight: 0.5,
                                    size: 8,
                                    textDirection: TextDirection.rtl),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    'เมนูในระบบ',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: GridView.count(
                  primary: false,
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 2.25,
                  children: [
                    ...List.generate(listMenuDisplay.length, (index) {
                      return Container(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(9)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.14),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 255, 255, 255)
                                        .withOpacity(0.40),
                                    Color.fromARGB(255, 255, 255, 255)
                                        .withOpacity(0.60),
                                    Color.fromARGB(255, 255, 255, 255)
                                        .withOpacity(0.80)
                                  ])),
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
                            child: ClipPath(
                              child: Container(
                                child: Center(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor:
                                            listMenuDisplay[index].color,
                                        child: listMenuDisplay[index].icon),
                                    title: Text(
                                      '${listMenuDisplay[index].menu.toString()}',
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 59, 58, 58),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 13),
                                    ),
                                    // subtitle: Text(
                                    //   '${listMenuDisplay[index].subMenu.toString()}',
                                    //   style: const TextStyle(
                                    //       color: Color.fromARGB(
                                    //           255, 12, 54, 151),
                                    //       fontWeight: FontWeight.w700,
                                    //       fontSize: 13.5),
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ]));
    });
  }

  Container GradientContainer(Size size) {
    return Container(
      height: size.height * 0.28,
      width: size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16)),
          image: DecorationImage(
              image: AssetImage('assets/images/logo-car.jpg'),
              fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 25, 67, 144).withOpacity(.20),
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  colorBar.withOpacity(0.40),
                  colorBar.withOpacity(0.60),
                  colorBar.withOpacity(0.80)
                ])),
      ),
    );
  }
}
