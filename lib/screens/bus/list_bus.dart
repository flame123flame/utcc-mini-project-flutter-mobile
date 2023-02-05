import 'dart:developer';

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
  List<BusModel> listUser = [];

  GetListBus() async {
    try {
      List<BusModel> temp = await ApiService.apiGetListBus();
      setState(() {
        listUser = List.generate(temp.length, ((index) {
          return BusModel(
            id: temp[index].id,
            busNo: temp[index].busNo,
            createDate: temp[index].createDate,
          );
        }));
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffEFF3F8),
        appBar: AppBar(
          backgroundColor: colorBar,
          title: const Text('รถเมล์ในระบบ'),
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
                    if (listUser.length > 0)
                      Text(
                        'รายการรถเมล์ในระบบ ${listUser.length} รายการ',
                        style:
                            TextStyle(fontSize: SizeConfig.defaultSize! * 1.7),
                      ),
                    // Text('data')
                  ],
                )),
            if (listUser.length > 0)
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
                        ...List.generate(listUser.length, (index) {
                          return Container(
                            child: InkWell(
                                onTap: () => {},
                                child: Container(
                                  height: SizeConfig.defaultSize! * 8,
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
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 0,
                                        blurRadius: 0,
                                        offset: Offset(0,
                                            2.2), // changes position of shadow
                                      ),
                                    ],
                                  ),
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
                                                              "  วันที่สร้าง : ",
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
                                                                      SizeConfig
                                                                              .defaultSize! *
                                                                          1.6,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            Text(
                                                              Time().DatetimeToDateThaiString(
                                                                  listUser[
                                                                          index]
                                                                      .createDate!),
                                                              //  "${listUser[index].createDate}",
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
                                                                      SizeConfig
                                                                              .defaultSize! *
                                                                          1.6,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "  เลขรถเมล์ : ",
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
                                                                      SizeConfig
                                                                              .defaultSize! *
                                                                          1.6,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            Text(
                                                              "${listUser[index].busNo}",
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
                                                                      SizeConfig
                                                                              .defaultSize! *
                                                                          1.6,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
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
