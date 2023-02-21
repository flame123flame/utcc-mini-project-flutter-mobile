import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';
import 'package:utcc_mobile/screens/supervisor/overview.dart';
import 'package:utcc_mobile/screens/users/list_role.dart';
import 'package:utcc_mobile/screens/users/list_user.dart';
import 'package:utcc_mobile/screens/users/manage_user.dart';
import 'package:utcc_mobile/screens/work/work_list.dart';
import 'package:utcc_mobile/utils/time_format.dart';
import '../constants/constant_color.dart';
import '../constants/constant_menu.dart';
import '../model/weather_main.dart';
import '../model_components/main_menu.dart';
import '../provider/user_login_provider.dart';
import '../service/api_service.dart';
import 'fare/fare_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherMain? weather;

  getCurrentWeather() async {
    try {
      WeatherMain temp = await ApiService.apiGetCurrentWeather();
      setState(() {
        weather = temp;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  UserLoginProvider? userLoginProvider;
  List<MainMenu> listMenu = listMenuConstant;
  List<MainMenu> listMenuDisplay = [];
  String? _timeString;
  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    userLoginProvider = Provider.of<UserLoginProvider>(context, listen: false);
    List<String> list = userLoginProvider!.getUserLogin.roleCode!.split(",");
    for (var i = 0; i < list.length; i++) {
      listMenuDisplay.addAll(
          listMenu.where((element) => element.role == list[i].toString()));
    }
    getCurrentWeather();
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    var minute = dateTime.minute.toString().length == 1
        ? "0" + dateTime.minute.toString()
        : dateTime.minute.toString();
    return dateTime.hour.toString().length == 1
        ? "0" + dateTime.hour.toString() + ":" + minute
        : dateTime.hour.toString() + ":" + minute;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: Color.fromARGB(235, 235, 244, 255),
          body: Column(children: [
            Stack(
              children: [
                GradientContainer(size),
                Positioned(
                    top: size.height * .10,
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
                                        "  ${value.getUserLogin.firstName} ${value.getUserLogin.lastName} ${value.getUserLogin.position}",
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
                if (weather != null)
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 17, right: 17, top: 180),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          opacity: 0.15,
                          image: AssetImage('assets/images/weather.png'),
                          fit: BoxFit.contain),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 71, 171, 242),
                          Color.fromARGB(255, 19, 99, 185),
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
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("${weather!.main!.temp!.toInt()}°",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontFamily: 'promptw',
                                                fontSize: 40)),
                                      ],
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                            "${weather!.weather![0].description}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white,
                                                fontSize: 13)),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Divider(
                              color: Color.fromARGB(255, 198, 196, 196),
                              height: 1,
                              indent: 10,
                              endIndent: 10),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "กรุงเทพมหานคร",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ' สูงสุด: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Color.fromARGB(
                                              255, 238, 238, 238),
                                          fontSize: 13),
                                    ),
                                    Text(
                                      "${weather!.main!.tempMax!.toInt()}°",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      '  ต่ำสุด: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Color.fromARGB(
                                              255, 238, 238, 238),
                                          fontSize: 13),
                                    ),
                                    Text(
                                      "${weather!.main!.tempMin!.toInt()}°",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          fontSize: 15),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${_timeString}",
                                  style: TextStyle(
                                      fontFamily: "aa",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: 50),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${Time().thaiDateTextFormatThai()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      fontSize: 16.5),
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
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 2.4,
                      children: List.generate(
                        listMenuDisplay.length,
                        (index) => GridAnimatorWidget(
                            child: Container(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(9)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.14),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
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
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                      ).toList())),
            ),
            SizedBox(
              height: 20,
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
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          image: DecorationImage(
              image: AssetImage('assets/images/logo-car.jpg'),
              fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
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
