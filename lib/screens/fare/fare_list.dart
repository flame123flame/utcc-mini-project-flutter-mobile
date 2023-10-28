import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../components/popup_bottom.dart';
import '../../constants/constant_color.dart';
import '../../service/api_service.dart';
import '../../utils/size_config.dart';
import '../../utils/time_format.dart';
import '../driver/model/driver.dart';
import '../work/work_assign.dart';
import 'fare_deatil.dart';

class FareList extends StatefulWidget {
  const FareList({Key? key}) : super(key: key);

  @override
  State<FareList> createState() => _FareListState();
}

class _FareListState extends State<FareList> {
  List<Driver> listWorksheetProgress = [];
  List<Driver> listWorksheetSuccess = [];
  GetListFarecollectProgress() async {
    try {
      List<Driver> temp = await ApiService.apiGetListFarecollectProgress();
      setState(() {
        listWorksheetProgress = temp;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  GetListFarecollectSuccess() async {
    try {
      List<Driver> temp = await ApiService.apiGetListFarecollectSuccess();
      setState(() {
        listWorksheetSuccess = temp;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    GetListFarecollectSuccess();
    GetListFarecollectProgress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'prompt',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          backgroundColor: Color(0xffeaf4ff),
          drawerDragStartBehavior: DragStartBehavior.start,
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 23,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Color.fromARGB(255, 34, 50, 174),
                      Color.fromARGB(255, 37, 43, 99),
                    ]),
              ),
            ),
            bottom: TabBar(
              indicatorPadding: EdgeInsets.zero,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              splashBorderRadius: BorderRadius.circular(2),
              onTap: (index) {
                // Tab index when user select it, it start from zero
              },
              tabs: [
                Tab(
                    child: Text('กำลังดำเนินการ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'prompt',
                        ))),
                Tab(
                    child: Text('ดำเนินการเสร็จสิ้น',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'prompt',
                        ))),
              ],
            ),
            title: Text(
              'รายการเก็บค่าโดยสาร',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                fontFamily: 'prompt',
              ),
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              TabWorkList1(context, listWorksheetProgress),
              TabWorkList2(context, listWorksheetSuccess),
            ],
          ),
        ),
      ),
    );
  }
}

converDate(String date) {
  return Time().DateTimeToThai(DateTime.parse(date));
}

getPopupDetail(BuildContext context, Driver driver) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(13),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 4, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '',
                    style: TextStyle(
                        fontFamily: 'prompt',
                        color: Color.fromARGB(255, 12, 54, 151),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text('รายละเอียด'),
                CupertinoButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Color.fromARGB(255, 12, 54, 151),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "หมายเลขใบงาน ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.worksheetId.toString() ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "วันที่ใบจ่ายงาน",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      converDate(driver.worksheetDate.toString()),
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "เวลารับงาน",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.worksheetTimeBegin ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "เวลาตัดเลิก",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.worksheetTimeEnd ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "นายท่าผู้ตัดเลิก",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.worksheetTerminalAgent!.trim().isEmpty
                          ? '-'
                          : driver.worksheetTerminalAgent.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "เวลางาน",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.worksheetHours ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "โอที(ล่วงเวลา)",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.worksheetHoursOt ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "สายรถเมล์",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.busLinesNo ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ทะเบียนรถเมล์",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.busVehiclePlateNo ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "เลขข้างรถ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.busVehicleNumber ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "กปด.",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.busDivisionName ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ชื่อผู้จ่ายงาน",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.worksheetDispatcher ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ชื่อพนักงานขับรถ",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.worksheetDriver?.toString() ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ชื่อพนักเก็บค่าโดยสาร",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.worksheetFarecollect?.toString() ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "รับรอง(ผู้จัดการสาย)",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      driver.worksheetBuslinesManager?.toString() ?? "-",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "สถานะใบงาน",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5),
                    ),
                    Text(
                      "กำลังดำเนินงาน",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 13.5),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () => {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: FareDeatil(
                          busLinesId: driver.busLinesId,
                          busVehicleId: driver.busVehicleId,
                          status: "IN_PROGRESS",
                          worksheetId: driver.worksheetId),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    ).then((value) => {})
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(255, 29, 45, 170),
                              Color.fromARGB(255, 34, 50, 174),
                            ])),
                    height: 40,
                    width: double.infinity,
                    child: Text(
                      'ดำเนินการ',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );
    },
  );
}

Widget TabWorkList1(BuildContext context, List<Driver> list) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: Column(
      children: [
        if (list.length <= 0)
          Container(
            width: double.infinity,
            height: SizeConfig.defaultSize! * 14,
            margin: EdgeInsets.only(top: 1, left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                boxShadow: [],
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255)
                    ])),
            child: Center(child: Text('ไม่มีข้อมูล')),
          ),
        if (list.length > 0)
          Expanded(
              child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                    onTap: () => {getPopupDetail(context, list[index])},
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.defaultSize! * 0.5,
                              bottom: SizeConfig.defaultSize! * 0.5,
                              left: SizeConfig.defaultSize! * 1.5,
                              right: SizeConfig.defaultSize! * 1.5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [],
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 255, 255, 255),
                                    Color.fromARGB(255, 255, 255, 255)
                                  ])),
                          padding: EdgeInsets.all(SizeConfig.defaultSize! * 1),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 12, right: 12),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "หมายเลขใบงาน",
                                                style: TextStyle(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w800,
                                                    color: colorTextHeader),
                                              ),
                                              Text(
                                                '${list[index].worksheetId}',
                                                style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: colorTextValue),
                                              ),
                                            ]),
                                        SizedBox(height: 2),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "เลขข้างรถ",
                                                style: TextStyle(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w800,
                                                    color: colorTextHeader),
                                              ),
                                              Text(
                                                '${list[index].busVehicleNumber}',
                                                style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: colorTextValue),
                                              ),
                                            ]),
                                        SizedBox(height: 2),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "ทะเบียนรถเมล์",
                                                style: TextStyle(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w800,
                                                    color: colorTextHeader),
                                              ),
                                              Text(
                                                '${list[index].busVehiclePlateNo}',
                                                style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: colorTextValue),
                                              ),
                                            ]),
                                        SizedBox(height: 2),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "วันที่ใบจ่ายงาน",
                                                style: TextStyle(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w800,
                                                    color: colorTextHeader),
                                              ),
                                              Text(
                                                '${converDate(list[index].worksheetDate!)}',
                                                style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: colorTextValue),
                                              ),
                                            ]),
                                        SizedBox(height: 2),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "สถานะใบงาน",
                                                style: TextStyle(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w800,
                                                    color: colorTextHeader),
                                              ),
                                              Text(
                                                'กำลังดำเนินการ',
                                                style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: colorTextValue),
                                              ),
                                            ]),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              );
            },
          ))
      ],
    ),
  );
}

Widget TabWorkList2(BuildContext context, List<Driver> list) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: Column(
      children: [
        if (list.length <= 0)
          Container(
            width: double.infinity,
            height: SizeConfig.defaultSize! * 14,
            margin: EdgeInsets.only(top: 1, left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                boxShadow: [],
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255)
                    ])),
            child: Center(child: Text('ไม่มีข้อมูล')),
          ),
        if (list.length > 0)
          Expanded(
              child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                    onTap: () => {getPopupDetail(context, list[index])},
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.defaultSize! * 0.5,
                              bottom: SizeConfig.defaultSize! * 0.5,
                              left: SizeConfig.defaultSize! * 1.5,
                              right: SizeConfig.defaultSize! * 1.5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [],
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 255, 255, 255),
                                    Color.fromARGB(255, 255, 255, 255)
                                  ])),
                          padding: EdgeInsets.all(SizeConfig.defaultSize! * 1),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 12, right: 12),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "หมายเลขใบงาน",
                                                style: TextStyle(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w800,
                                                    color: colorTextHeader),
                                              ),
                                              Text(
                                                '${list[index].worksheetId}',
                                                style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: colorTextValue),
                                              ),
                                            ]),
                                        SizedBox(height: 2),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "เลขข้างรถ",
                                                style: TextStyle(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w800,
                                                    color: colorTextHeader),
                                              ),
                                              Text(
                                                '${list[index].busVehicleNumber}',
                                                style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: colorTextValue),
                                              ),
                                            ]),
                                        SizedBox(height: 2),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "ทะเบียนรถเมล์",
                                                style: TextStyle(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w800,
                                                    color: colorTextHeader),
                                              ),
                                              Text(
                                                '${list[index].busVehiclePlateNo}',
                                                style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: colorTextValue),
                                              ),
                                            ]),
                                        SizedBox(height: 2),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "วันที่ใบจ่ายงาน",
                                                style: TextStyle(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w800,
                                                    color: colorTextHeader),
                                              ),
                                              Text(
                                                '${converDate(list[index].worksheetDate!)}',
                                                style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: colorTextValue),
                                              ),
                                            ]),
                                        SizedBox(height: 2),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "สถานะใบงาน",
                                                style: TextStyle(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w800,
                                                    color: colorTextHeader),
                                              ),
                                              Text(
                                                'กำลังดำเนินการ',
                                                style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: colorTextValue),
                                              ),
                                            ]),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              );
            },
          ))
      ],
    ),
  );
}
