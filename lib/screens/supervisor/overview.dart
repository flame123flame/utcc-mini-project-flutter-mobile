import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../components/popup_bottom.dart';
import '../../components/popup_date_picker.dart';
import '../../constants/constant_color.dart';
import '../../model_components/popup_bottom_model.dart';
import '../../service/api_service.dart';
import '../../utils/size_config.dart';
import '../../utils/time_format.dart';
import '../work/model/worksheet.dart';
import '../work/work_assign.dart';
import 'overview_detail.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  int tabActive = 0;
  List<Worksheet> listWorksheetProgress = [];
  List<Worksheet> listWorksheetSuccess = [];
  TextEditingController NumberSearchTab1 = new TextEditingController();
  TextEditingController NumberSearchTab2 = new TextEditingController();
  String activeSearch = 'code01';

  List<PopupBottomModel> listMenu = [
    PopupBottomModel(
      code: 'code01', //ชื่อ
      title: 'ทั้งหมด',
      subTitle: 'ค้นหารายการทั้งหมด',
      icon: Icon(
        Icons.all_inbox,
        color: Colors.white,
      ),
    ),
    PopupBottomModel(
      code: 'code02',
      title: 'วันที่',
      subTitle: 'ค้นหารายการด้วยวันที่',
      icon: Icon(
        Icons.dataset_linked,
        color: Colors.white,
      ),
    ),
    PopupBottomModel(
      code: 'code03',
      title: 'เลขที่ใบงาน',
      subTitle: 'ค้นหารายการด้วยเลขที่ใบงาน',
      icon: Icon(
        Icons.numbers,
        color: Colors.white,
      ),
    ),
  ];

  GetListWorksheetProgress() async {
    try {
      List<Worksheet> temp = await ApiService.apiGetListWorksheetProgress();
      setState(() {
        listWorksheetProgress = temp;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  GetListWorksheetSuccess(String date, int? id) async {
    try {
      List<Worksheet> temp =
          await ApiService.apiGetListWorksheetSuccess(date, id);
      setState(() {
        listWorksheetSuccess = temp;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    GetListWorksheetProgress();
    GetListWorksheetSuccess("", null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        child: Scaffold(
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
              if (tabActive == 1)
                PopupFilterBottom(
                  validate: false,
                  list: listMenu,
                  onSelected: (index, code, value) {
                    setState(() {
                      activeSearch = code.toString();
                    });
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
                setState(() {
                  tabActive = index;
                });
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
              TabWorkList1(context, listWorksheetProgress),
              TabWorkList2(context, listWorksheetSuccess),
            ],
          ),
        ),
      ),
    );
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

  void showFlushbar({
    required String message,
    required Color backgroundColor,
    required Icon icon,
    required Function() onPressed,
  }) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      icon: icon,
      message: message,
      margin: EdgeInsets.only(
        left: 60,
        right: 60,
        bottom: 10,
        top: 10,
      ),
      backgroundColor: backgroundColor,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius: BorderRadius.circular(8),
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 10),
      duration: Duration(milliseconds: 2000),
      animationDuration: Duration(milliseconds: 1000),
      textDirection: Directionality.of(context),
      isDismissible: false,
    ).show(context);
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
                      'รายการใบงานในระบบ ${list.length} รายการ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  // Text('data')
                ],
              )),
          if (list.length <= 0)
            Container(
              margin: EdgeInsets.only(top: 1),
              child: Text('ไม่มีข้อมูล'),
            ),
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
                              onTap: () => {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: OverviewDetail(
                                          status: "IN_PROGRESS",
                                          worksheetId: list[index].worksheetId),
                                      withNavBar: false,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    ).then((value) => {
                                          print(value),
                                          if (value.toString() == "noti")
                                            {
                                              setState(() {
                                                showFlushbar(
                                                  icon: Icon(
                                                    CupertinoIcons
                                                        .check_mark_circled,
                                                    size: 23,
                                                    color: Colors.white,
                                                  ),
                                                  message: "ปิดจบงานสำเร็จ",
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 58, 150, 76),
                                                  onPressed: () {},
                                                );
                                              })
                                            },
                                          GetListWorksheetProgress(),
                                        })
                                  },
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
                                            color:
                                                Colors.grey.withOpacity(0.14),
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
                                                            int.parse((index +
                                                                        1)
                                                                    .toString())
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
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
                                                                    fontSize:
                                                                        13,
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
                                                                    fontSize:
                                                                        13,
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
                                                                    fontSize:
                                                                        13,
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
                                                                    fontSize:
                                                                        13,
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
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            207,
                                                                            114,
                                                                            38),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            6.0),
                                                                    border: Border.all(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            232,
                                                                            122,
                                                                            32))),
                                                                child: Text(
                                                                  'กำลังดำเนินงาน',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          244,
                                                                          231,
                                                                          231),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800),
                                                                ),
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

  Widget TabWorkList2(BuildContext context, List<Worksheet> list) {
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
                      'รายการใบงานในระบบ ${list.length} รายการ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  // Text('data')
                ],
              )),
          Visibility(
            visible: activeSearch != "code01",
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9.0),
                  border: Border.all(color: Colors.white)),
              padding: EdgeInsets.only(bottom: SizeConfig.defaultSize! * 2.8),
              margin: EdgeInsets.only(
                  top: SizeConfig.defaultSize! * 1.5,
                  left: SizeConfig.defaultSize! * 1.5,
                  right: SizeConfig.defaultSize! * 1.5),
              child: Column(
                children: [
                  Visibility(
                    visible: activeSearch == "code02",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.defaultSize! * 1.5,
                              right: SizeConfig.defaultSize! * 1.5),
                          child: Text(
                            'วันที่สร้างผู้ใช้งาน',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.defaultSize! * 1.5,
                              right: SizeConfig.defaultSize! * 1.5),
                          child: Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.defaultSize! * 0.1,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                            ),
                            child: PopupDatePicker(
                              validate: false,
                              onSelected: (datetime) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (activeSearch == 'code03'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.defaultSize! * 0.7,
                              left: SizeConfig.defaultSize! * 1.5,
                              right: SizeConfig.defaultSize! * 1.5),
                          child: Text(
                            'เลขที่ใบงาน',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.defaultSize! * 1.5,
                              right: SizeConfig.defaultSize! * 1.5),
                          child: Container(
                              margin: EdgeInsets.only(
                                top: SizeConfig.defaultSize! * 0.4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                              ),
                              child: Container(
                                  width: double.infinity,
                                  height: 42,
                                  padding: EdgeInsets.only(
                                      left: 5, right: 1, bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.0),
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 221, 219, 218))),
                                  child: Focus(
                                    child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => {
                                              if (value.isEmpty)
                                                {
                                                  GetListWorksheetSuccess(
                                                      "", null)
                                                }
                                              else
                                                {
                                                  GetListWorksheetSuccess(
                                                      "", int.parse(value))
                                                }
                                            },
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.0,
                                                top:
                                                    6), // add padding to adjust icon
                                            child: Icon(Icons.search_outlined,
                                                size: 30,
                                                color: Color.fromARGB(
                                                    255, 165, 164, 163)),
                                          ),
                                        )),
                                  ))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (list.length <= 0)
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text('ไม่มีข้อมูล'),
            ),
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
                              onTap: () => {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: OverviewDetail(
                                          status: "SUCCESS",
                                          worksheetId: list[index].worksheetId),
                                      withNavBar: false,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    ).then((value) => {})
                                  },
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
                                            color:
                                                Colors.grey.withOpacity(0.14),
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
                                                            int.parse((index +
                                                                        1)
                                                                    .toString())
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
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
                                                                    fontSize:
                                                                        13,
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
                                                                    fontSize:
                                                                        13,
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
                                                                    fontSize:
                                                                        13,
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
                                                                    fontSize:
                                                                        13,
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
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            99,
                                                                            161,
                                                                            6),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            6.0),
                                                                    border: Border.all(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            105,
                                                                            187,
                                                                            33))),
                                                                child: Text(
                                                                  'ดำเนินการเสร็จสิ้น',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          244,
                                                                          231,
                                                                          231),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800),
                                                                ),
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
}
