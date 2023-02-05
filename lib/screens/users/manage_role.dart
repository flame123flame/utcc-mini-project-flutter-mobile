import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:utcc_mobile/components/custom_radio.dart';
import 'package:utcc_mobile/constants/constant_color.dart';

import '../../model/users_login.dart';
import '../../model_components/menu_role.dart';
import '../../service/api_service.dart';

class ManageRole extends StatefulWidget {
  const ManageRole({Key? key}) : super(key: key);

  @override
  State<ManageRole> createState() => _ManageRoleState();
}

class _ManageRoleState extends State<ManageRole> {
  bool validateCode = false;
  bool validateRole = false;
  TextEditingController code = new TextEditingController();
  TextEditingController role = new TextEditingController();
  TextEditingController detail = new TextEditingController();

  List<MenuRole>? listCheckbox = [
    MenuRole(name: "จ่ายงาน", value: 0, code: "DISPATCHER"),
    MenuRole(name: "เก็บค่าโดยสาร", value: 0, code: "FARECOLLECT"),
    MenuRole(name: "รถที่ต้องขับ", value: 0, code: "DRIVER"),
    MenuRole(name: "ผู้จัดการสาย", value: 0, code: "BUSSUPERVISOR"),
    MenuRole(name: "ผู้ใช้งานในระบบ", value: 0, code: "USER"),
    MenuRole(name: "สิทธ์การใช้งานในระบบ", value: 0, code: "ROLE")
  ];

  ValidateForm(
    BuildContext context,
  ) {
    if (code.text.trim().isEmpty) {
      validateCode = true;
      setState(() {});
      return;
    } else {
      validateCode = false;
    }
    if (role.text.trim().isEmpty) {
      validateRole = true;
      setState(() {});
      return;
    } else {
      validateRole = false;
    }

    List<MenuRole> outputList =
        listCheckbox!.where((o) => o.value == 1).toList();
    if (outputList.length == 0) {
      NotificationCustom(context, 'กรุณาเลือกเมนูที่ต้องการแสดง');
      return;
    }
    SaveForm(outputList);
  }

  SaveForm(List<MenuRole> listMenu) async {
    List<String> listMenuString = [];
    for (var i = 0; i < listMenu.length; i++) {
      listMenuString.add(listMenu[i].code.toString());
    }

    try {
      EasyLoading.show(
        indicator: Image.asset(
          'assets/images/Loading_2.gif',
          height: 70,
        ),
      );
      await Future.delayed(Duration(seconds: 1));
      Response data = await ApiService.SaveRole(
          code.text, role.text, detail.text, listMenuString.join(","));
      if (data.statusCode == 200) {
        Navigator.of(context).pop();
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
    }
  }

  void NotificationCustom(BuildContext context, String text) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              'แจ้งเตือน',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 57, 52),
                  fontFamily: 'prompt',
                  fontSize: 18),
            ),
            content: Text(
              text,
              style: TextStyle(
                  color: Color.fromARGB(255, 55, 48, 43),
                  fontFamily: 'prompt',
                  fontSize: 14),
            ),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
                child: const Text(
                  'ตกลง',
                  style: TextStyle(
                    fontFamily: 'prompt',
                    color: Colors.red,
                  ),
                ),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              // The "No" button
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: colorBar,
        title: const Text('จัดการสิทธ์การใช้งาน'),
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
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              ValidateForm(context);
            },
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 13.0, right: 13.0, top: 20),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2),
                child: Row(
                  children: [
                    Text(
                      'Code',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 42,
                  padding: EdgeInsets.only(left: 5, right: 1, bottom: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: validateCode
                              ? Colors.red
                              : Color.fromARGB(255, 221, 219, 218))),
                  child: Focus(
                    onFocusChange: (hasFocus) {},
                    child: TextFormField(
                      controller: code,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2),
                child: Row(
                  children: [
                    Text(
                      'สิทธ์การใช้งาน',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 42,
                  padding: EdgeInsets.only(left: 5, right: 1, bottom: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: validateRole
                              ? Colors.red
                              : Color.fromARGB(255, 221, 219, 218))),
                  child: Focus(
                    onFocusChange: (hasFocus) {},
                    child: TextFormField(
                      controller: role,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2),
                child: Text(
                  'รายละเอียด',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 42,
                  padding: EdgeInsets.only(left: 5, right: 1, bottom: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: Color.fromARGB(255, 221, 219, 218))),
                  child: Focus(
                    onFocusChange: (hasFocus) {},
                    child: TextFormField(
                      controller: detail,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  )),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2),
                child: Text(
                  'เลือกเมนูที่ต้องการแสดงที่หน้าจอ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Column(
                children: [
                  ...List.generate(listCheckbox!.length, ((index) {
                    return Column(
                      children: [
                        CustomRadio(
                          type: 'checkbox',
                          name: listCheckbox![index].name.toString(),
                          value: 1,
                          groupValue: listCheckbox![index].value,
                          onChanged: (value, name) {
                            setState(() {
                              if (listCheckbox![index].value == value) {
                                listCheckbox![index].value =
                                    listCheckbox![index].value == 0 ? 1 : 0;
                              } else {
                                listCheckbox![index].value = value;
                              }
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  })),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
