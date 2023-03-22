import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:utcc_mobile/components/popup_bottom.dart';

import '../../components/notification.dart';
import '../../components/popup_date_picker.dart';
import '../../constants/constant_color.dart';
import '../../constants/constant_menu.dart';
import '../../model/role_model.dart';
import '../../model_components/main_menu.dart';
import '../../model_components/popup_bottom_model.dart';
import '../../provider/user_login_provider.dart';
import '../../service/api_service.dart';
import '../../utils/size_config.dart';
import '../../utils/time_format.dart';
import '../authentication/login.dart';
import 'manage_role.dart';
import 'manage_user.dart';

class ListRole extends StatefulWidget {
  const ListRole({Key? key}) : super(key: key);

  @override
  State<ListRole> createState() => _ListRoleState();
}

class _ListRoleState extends State<ListRole> {
  UserLoginProvider? userLoginProvider;
  static FlutterSecureStorage storage = new FlutterSecureStorage();

  @override
  void initState() {
    getRole();
    userLoginProvider = Provider.of<UserLoginProvider>(context, listen: false);
    super.initState();
  }

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

  List<RoleModel> listRole = [];

  getRole() async {
    try {
      List<RoleModel> temp = await ApiService.apiGetRole();
      setState(() {
        listRole = List.generate(temp.length, ((index) {
          return RoleModel(
            createDate: temp[index].createDate,
            roleCode: temp[index].roleCode,
            roleName: temp[index].roleName,
            munuList: temp[index].munuList,
            roleDescription: temp[index].roleDescription,
          );
        }));
      });
    } on DioError catch (error) {
      if (error.response!.statusCode == 401) {
        await storage.delete(key: 'jwttoken');
        await storage.delete(key: 'username');
        await storage.delete(key: 'password');
        userLoginProvider!.clearUserLogin();
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Login();
            },
          ),
          (_) => false,
        );
      }
      print(error.response!.statusCode);
    }
  }

  deleteRole(String code) async {
    try {
      Response temp = await ApiService.apiDeleteRole(code);
      if (temp.statusCode == 200) {
        getRole();
        Navigator.pop(context);
      }
    } on DioError catch (error) {
      if (error.response!.statusCode == 401) {
        await storage.delete(key: 'jwttoken');
        await storage.delete(key: 'username');
        await storage.delete(key: 'password');
        userLoginProvider!.clearUserLogin();
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Login();
            },
          ),
          (_) => false,
        );
      }
    }
  }

  List<MainMenu> listMenuData = listMenuConstant;
  getPopupDetail(BuildContext context, RoleModel roleModel) {
    List<MainMenu> listMenuDisplay = [];
    List<String> list = roleModel.munuList!;
    for (var i = 0; i < list.length; i++) {
      listMenuDisplay.addAll(
          listMenuData.where((element) => element.role == list[i].toString()));
    }
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
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Code ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5),
                      ),
                      Text(
                        roleModel.roleCode.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13.5),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "สิทธ์การใช้งาน",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5),
                      ),
                      Text(
                        roleModel.roleName.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13.5),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "รายละเอียด",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5),
                      ),
                      Text(
                        roleModel.roleDescription.toString() == "null"
                            ? "-"
                            : roleModel.roleDescription.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13.5),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "เมนูแสดงหน้าจอ",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 13.5),
                      ),
                      Text(
                        '',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13.5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...List.generate(listMenuDisplay.length, (index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "เมนูที่ " + (index + 1).toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 13.5),
                            ),
                            Text(
                              listMenuDisplay[index].menu,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 13.5),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => {deleteRole(roleModel.roleCode!)},
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
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
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
          title: Text(
            'สิทธ์การใช้งาน',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_outlined),
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: ManageRole(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                ).then((value) => {getRole()});
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
                    if (listRole.length > 0)
                      Text(
                        'รายการผู้ใช้งาน ${listRole.length} รายการ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    // Text('data')
                  ],
                )),
            if (listRole.length > 0)
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
                        ...List.generate(listRole.length, (index) {
                          return Container(
                            child: InkWell(
                                onTap: () =>
                                    {getPopupDetail(context, listRole[index])},
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
                                                                      listRole[
                                                                              index]
                                                                          .createDate!),
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
                                                                  "  สิทธ์การใช้ : ",
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
                                                                  "${listRole[index].roleName}",
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
                                                                  "  Code : ",
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
                                                                  "${listRole[index].roleCode}",
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
