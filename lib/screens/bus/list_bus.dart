import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:utcc_mobile/screens/bus/manage_bus.dart';

import '../../components/popup_bottom.dart';
import '../../components/popup_date_picker.dart';
import '../../constants/constant_color.dart';
import '../../model/bus_model.dart';
import '../../model_components/popup_bottom_model.dart';
import '../../service/api_service.dart';
import '../../utils/size_config.dart';
import '../../utils/time_format.dart';
import 'model/bus_vehicle.dart';

class ListBus extends StatefulWidget {
  const ListBus({Key? key}) : super(key: key);

  @override
  State<ListBus> createState() => _ListBusState();
}

class _ListBusState extends State<ListBus> {
  String activeSearch = 'code01';
  List<int> userList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
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
      title: 'วันที่สร้างและเลขข้างรถ',
      subTitle: 'ค้นหารายการด้วยวันที่สร้างและเลขข้างรถ',
      icon: Icon(
        Icons.dataset_linked,
        color: Colors.white,
      ),
    ),
    PopupBottomModel(
      code: 'code03',
      title: 'วันที่สร้าง',
      subTitle: 'ค้นหารายการด้วยวันที่สร้าง',
      icon: Icon(
        Icons.calendar_month,
        color: Colors.white,
      ),
    ),
    PopupBottomModel(
      code: 'code04',
      title: 'เลขรถเมล์',
      subTitle: 'ค้นหารายการด้วยเลขข้างรถ',
      icon: Icon(
        Icons.person,
        color: Colors.white,
      ),
    ),
  ];
  List<BusVehicle> listBus = [];

  GetListBus() async {
    try {
      List<BusVehicle> temp = await ApiService.apiListBus();
      setState(() {
        listBus = temp;
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

  deleteRole(int id) async {
    try {
      Response temp = await ApiService.apiDeleteBusVehicle(id);
      if (temp.statusCode == 200) {
        GetListBus();
        Navigator.pop(context);
      }
    } on DioError catch (error) {
      print(error);
    }
  }

  getPopupDetail(BuildContext context, BusVehicle busModel) {
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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "เลขข้างรถ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5),
                      ),
                      Text(
                        '${busModel.busVehicleNumber}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13.5),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ทะเบียนรถ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5),
                      ),
                      Text(
                        '${busModel.busVehiclePlateNo}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13.5),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "จังหวัด",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5),
                      ),
                      Text(
                        '${busModel.busVehiclePlateProv}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13.5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => {deleteRole(busModel.busVehicleId!)},
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 204, 136, 28)
                                          .withOpacity(0.80),
                                      Color.fromARGB(255, 204, 136, 28)
                                          .withOpacity(0.80),
                                      Color.fromARGB(255, 204, 136, 28)
                                          .withOpacity(0.80)
                                    ])),
                            height: 40,
                            width: double.infinity,
                            child: Text(
                              'แก้ไขข้อมูล',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => {deleteRole(busModel.busVehicleId!)},
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 216, 6, 6)
                                          .withOpacity(0.80),
                                      Color.fromARGB(255, 216, 6, 6)
                                          .withOpacity(0.80),
                                      Color.fromARGB(255, 216, 6, 6)
                                          .withOpacity(0.80)
                                    ])),
                            height: 40,
                            width: double.infinity,
                            child: Text(
                              'ลบข้อมูล',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                    ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 235, 240, 244),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[
                      Color.fromARGB(255, 34, 50, 174),
                      Color.fromARGB(255, 37, 43, 99),
                    ]),
              ),
            ),
            // backgroundColor: colorBar,
            title: const Text(
              'รถเมล์ในระบบ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              PopupFilterBottom(
                validate: false,
                list: listMenu,
                onSelected: (index, code, value) {
                  setState(() {
                    activeSearch = code.toString();
                  });
                  log('message ' + code.toString());
                },
              ),
              IconButton(
                icon: Icon(Icons.add_outlined),
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: ManageBus(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  ).then((value) => {GetListBus()});
                },
              )
            ],
          ),
        ),
        body: Container(
            child: Column(
          children: [
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
                      visible:
                          activeSearch == "code02" || activeSearch == 'code03',
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
                                onSelected: (datetime) {
                                  log(datetime.toString());
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: (activeSearch == "code02" ||
                          activeSearch == 'code04'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.defaultSize! * 0.7,
                                left: SizeConfig.defaultSize! * 1.5,
                                right: SizeConfig.defaultSize! * 1.5),
                            child: Text(
                              'เลขข้างรถ',
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
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 221, 219, 218))),
                                    child: Focus(
                                      child: TextFormField(
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
            Padding(
                padding: EdgeInsets.only(
                    bottom: SizeConfig.defaultSize! * 0.8,
                    top: SizeConfig.defaultSize! * 1.5,
                    left: SizeConfig.defaultSize! * 1.5,
                    right: SizeConfig.defaultSize! * 1.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (listBus.length > 0)
                      Text(
                        'รายการรถเมล์ในระบบ ${listBus.length} รายการ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    // Text('data')
                  ],
                )),
            if (listBus.length > 0)
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
                      childAspectRatio: 4.2,
                      children: [
                        ...List.generate(listBus.length, (index) {
                          return Container(
                            child: InkWell(
                                onTap: () =>
                                    {getPopupDetail(context, listBus[index])},
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
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.10),
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
                                                Color.fromARGB(
                                                        255, 255, 255, 255)
                                                    .withOpacity(0.40),
                                                Color.fromARGB(
                                                        255, 255, 255, 255)
                                                    .withOpacity(0.60),
                                                Color.fromARGB(
                                                        255, 255, 255, 255)
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
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
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
                                                                  "  เลขข้างรถ : ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color: Color.fromARGB(
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
                                                                  '${listBus[index].busVehicleNumber}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color:
                                                                          colorBar,
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
                                                                  "  เลขทะเบียนรถ : ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color: Color.fromARGB(
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
                                                                  '${listBus[index].busVehiclePlateNo}',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color:
                                                                          colorBar,
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800),
                                                                ),
                                                              ],
                                                            ),
                                                          ])
                                                    ])
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 20.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          log("message");
                                        },
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: CircleAvatar(
                                            radius: 17.0,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.edit_note,
                                              color: Color.fromARGB(
                                                  255, 227, 171, 4),
                                              size: 30,
                                            ),
                                          ),
                                        ),
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
        )));
  }
}
