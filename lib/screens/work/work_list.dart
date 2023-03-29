import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:utcc_mobile/screens/work/work_assign.dart';

import '../../components/popup_bottom.dart';
import '../../constants/constant_color.dart';
import '../../service/api_service.dart';
import '../../utils/size_config.dart';
import '../../utils/time_format.dart';
import 'model/worksheet.dart';

class WorkList extends StatefulWidget {
  const WorkList({Key? key}) : super(key: key);

  @override
  State<WorkList> createState() => _WorkListState();
}

class _WorkListState extends State<WorkList> {
  List<Worksheet> listWorksheet = [];

  GetListBus() async {
    try {
      List<Worksheet> temp = await ApiService.apiGetListWorksheet();
      setState(() {
        listWorksheet = temp;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    GetListBus();
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
            actions: <Widget>[
              PopupFilterBottom(
                validate: false,
                list: [],
                onSelected: (index, code, value) {},
              ),
              IconButton(
                icon: Icon(Icons.add_outlined),
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: WorkAssign(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  ).then((value) => {GetListBus()});
                },
              )
            ],
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
                    child: Text('รายการล่าสุด',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'prompt',
                        ))),
                Tab(
                    child: Text('รายการย้อนหลัง',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'prompt',
                        ))),
              ],
            ),
            title: Text(
              'รายการจ่ายงาน',
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
              TabWorkList1(context, listWorksheet),
              TabWorkList2(),
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

getPopupDetail(BuildContext context) {
  showModalBottomSheet<void>(
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
          SizedBox(
            height: 200,
          ),
        ],
      );
    },
  );
}

Widget TabWorkList1(BuildContext context, List<Worksheet> list) {
  return Container(
    child: Column(
      children: [
        Padding(
            padding: EdgeInsets.only(
                bottom: SizeConfig.defaultSize! * 0.8,
                top: SizeConfig.defaultSize! * 1.5,
                left: SizeConfig.defaultSize! * 1.5,
                right: SizeConfig.defaultSize! * 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (list.length > 0)
                  Text(
                    'รายการใบจ่ายงานในระบบ ${list.length} รายการ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                // Text('data')
              ],
            )),
        if (list.length > 0)
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.only(bottom: 25, top: 10),
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  crossAxisCount: 1,
                  childAspectRatio: 4,
                  children: [
                    ...List.generate(list.length, (index) {
                      return Container(
                        child: InkWell(
                            onTap: () => {getPopupDetail(context)},
                            child: Stack(
                              children: [
                                Container(
                                  height: SizeConfig.defaultSize! * 10,
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.defaultSize! * 0.5,
                                      bottom: SizeConfig.defaultSize! * 0.5,
                                      left: SizeConfig.defaultSize! * 1.5,
                                      right: SizeConfig.defaultSize! * 1.5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.14),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
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
                                  padding: EdgeInsets.all(
                                      SizeConfig.defaultSize! * 1),
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Row(children: [
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: colorBar,
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        right: 6, left: 6),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          int.parse((index + 1)
                                                                  .toString())
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "  เลขที่ใบงาน : ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          48,
                                                                          47,
                                                                          47),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            Text(
                                                              '${list[index].worksheetId}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          48,
                                                                          47,
                                                                          47),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "  วันที่ : ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          48,
                                                                          47,
                                                                          47),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            Text(
                                                              '${converDate(list[index].worksheetDate!)}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          48,
                                                                          47,
                                                                          47),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "  สถานะใบงาน : ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          48,
                                                                          47,
                                                                          47),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            Text(
                                                              'กำลังดำเนินงาน',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          48,
                                                                          47,
                                                                          47),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                          ],
                                                        ),
                                                      ])
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
                    })
                  ],
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget TabWorkList2() {
  return Center(
    child: Container(
      child: Text(
        'Coming Soon',
        style: TextStyle(fontSize: 30),
      ),
    ),
  );
}
