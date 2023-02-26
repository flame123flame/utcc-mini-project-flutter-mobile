import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../components/popup_bottom.dart';
import '../../components/popup_date_picker.dart';
import '../../constants/constant_color.dart';
import '../../model/user.dart';
import '../../model_components/popup_bottom_model.dart';
import '../../service/api_service.dart';
import '../../utils/size_config.dart';
import '../../utils/time_format.dart';
import 'manage_user.dart';

class ListUser extends StatefulWidget {
  const ListUser({Key? key}) : super(key: key);

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
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
      title: 'วันที่สร้างและผู้ใช้งาน',
      subTitle: 'ค้นหารายการด้วยวันที่สร้างและผู้ใช้งาน',
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
      title: 'ชื่อผู้ใช้งาน',
      subTitle: 'ค้นหารายการด้วยชื่อผู้ใช้งาน',
      icon: Icon(
        Icons.person,
        color: Colors.white,
      ),
    ),
  ];

  List<User> listUser = [];

  getUser() async {
    try {
      List<User> temp = await ApiService.apiGetUser();
      if (temp.length == 0) {
        return;
      }
      setState(() {
        listUser = List.generate(temp.length, ((index) {
          return User(
            id: temp[index].id,
            username: temp[index].username,
            firstName: temp[index].firstName,
            lastName: temp[index].lastName,
            email: temp[index].email,
            position: temp[index].position,
            phoneNumber: temp[index].phoneNumber,
            roleCode: temp[index].roleCode,
            createDate: temp[index].createDate,
          );
        }));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  deleteRole(String username) async {
    try {
      Response temp = await ApiService.apiDeleteUser(username);
      if (temp.statusCode == 200) {
        getUser();
        Navigator.pop(context);
      }
    } on DioError catch (error) {}
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getPopupDetail(BuildContext context, User user) {
    showModalBottomSheet<void>(
      useSafeArea: false,
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
                        "ชื่อ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5),
                      ),
                      Text(
                        user.firstName.toString() +
                            " " +
                            user.lastName.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13.5),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ตำแหน่ง",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5),
                      ),
                      Text(
                        user.position.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13.5),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "เบอร์โทรศัพท์",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5),
                      ),
                      Text(
                        user.phoneNumber.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13.5),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "อีเมล",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5),
                      ),
                      Text(
                        user.email.toString() == "null"
                            ? "-"
                            : user.email.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13.5),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "สิทธ์การใช้งาน (Code)",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5),
                      ),
                      Text(
                        user.roleCode.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13.5),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ผู้ใช้งาน",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5),
                      ),
                      Text(
                        user.username.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13.5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => {deleteRole(user.username!)},
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
                                Color.fromARGB(255, 216, 6, 6).withOpacity(0.80)
                              ])),
                      height: 40,
                      width: double.infinity,
                      child: Text(
                        'ลบข้อมูล',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 235, 240, 244),
        appBar: AppBar(
          backgroundColor: colorBar,
          title: const Text(
            'ผู้ใช้งาน',
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
                  screen: ManageUser(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                ).then((value) => {getUser()});
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
                              'ชื่อผู้ใช้งาน',
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
                        'รายการผู้ใช้งาน ${listUser.length} รายการ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
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
                      childAspectRatio: 4.2,
                      children: [
                        ...List.generate(listUser.length, (index) {
                          return Container(
                            child: InkWell(
                                onTap: () =>
                                    {getPopupDetail(context, listUser[index])},
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
                                                                  "  วันที่สร้าง : ",
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
                                                                  "  ชื่อผู้ใช้งาน : ",
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
                                                                  "${listUser[index].firstName} ${listUser[index].lastName}",
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
