import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:utcc_mobile/components/popup_picker.dart';
import 'package:utcc_mobile/model/role_model.dart';

import '../../constants/constant_color.dart';
import '../../model_components/popup_model.dart';
import '../../service/api_service.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({Key? key}) : super(key: key);

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController position = new TextEditingController();
  String prefix = '';
  String roleCode = '';

  bool validateUsername = false;
  bool validatePassword = false;
  bool validateConfirmPassword = false;
  bool validateFirstName = false;
  bool validateLastName = false;
  bool validateEmail = false;
  bool validatePhoneNumber = false;
  bool validatePosition = false;
  bool validatePrefix = false;
  bool validateRoleCode = false;

  List<PopupModel> listPrefix = [
    PopupModel(
      id: 0,
      lable: "นาย",
      code: "001",
    ),
    PopupModel(
      id: 1,
      lable: "นาง",
      code: "002",
    ),
    PopupModel(
      id: 2,
      lable: "นางสาว",
      code: "003",
    )
  ];

  List<PopupModel> listRole = [];

  @override
  void initState() {
    getRole();
    super.initState();
  }

  getRole() async {
    try {
      List<RoleModel> temp = await ApiService.apiGetRole();
      setState(() {
        listRole = List.generate(temp.length, ((index) {
          return PopupModel(
            id: temp[index].fwRoleId!,
            code: temp[index].roleCode,
            lable: temp[index].roleName!,
          );
        }));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  ValidateForm(BuildContext context) {
    if (prefix.isEmpty) {
      setState(() {
        validatePrefix = true;
      });
      return;
    } else {
      setState(() {
        validatePrefix = false;
      });
    }
    if (firstName.text.isEmpty) {
      setState(() {
        validateFirstName = true;
      });
      return;
    } else {
      setState(() {
        validateFirstName = false;
      });
    }
    if (lastName.text.isEmpty) {
      setState(() {
        validateLastName = true;
      });
      return;
    } else {
      validateLastName = false;
      setState(() {});
    }
    if (roleCode.isEmpty) {
      setState(() {
        validateRoleCode = true;
      });
      return;
    } else {
      validateRoleCode = false;
      setState(() {});
    }
    if (username.text.isEmpty) {
      setState(() {
        validateUsername = true;
      });
      return;
    } else {
      validateUsername = false;
      setState(() {});
    }
    if (password.text.isEmpty) {
      setState(() {
        validatePassword = true;
      });
      return;
    } else {
      validatePassword = false;
      setState(() {});
    }
    if (confirmPassword.text.isEmpty) {
      setState(() {
        validateConfirmPassword = true;
      });
      return;
    } else {
      validateConfirmPassword = false;
      setState(() {});
    }
    SaveUser(context);
  }

  SaveUser(BuildContext context) async {
    if (password.text != confirmPassword.text) {
      NotificationCustom(context, 'กรอกรหัสผ่านไม่ตรงกัน!');
      return;
    }

    try {
      EasyLoading.show(
        indicator: Image.asset(
          'assets/images/Loading_2.gif',
          height: 70,
        ),
      );
      await Future.delayed(Duration(seconds: 1));
      Response data = await ApiService.apiSaveUser(
          username.text,
          password.text,
          confirmPassword.text,
          firstName.text,
          lastName.text,
          email.text,
          phoneNumber.text,
          position.text,
          prefix,
          roleCode);
      if (data.statusCode == 200) {
        Navigator.of(context).pop();
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
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

  var maskFormatter = new MaskTextInputFormatter(
      mask: '###-#######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: colorBar,
        title: const Text('จัดการผู้ใช้งาน'),
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
              // do something
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
          reverse: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2),
                child: Row(
                  children: [
                    Text(
                      'คำนำหน้า',
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
              PopupPicker(
                validate: validatePrefix,
                list: listPrefix,
                onSelected: (index, id, code, value) {
                  if (value!.isEmpty) {
                    setState(() {
                      validatePrefix = true;
                    });
                  } else {
                    setState(() {
                      validatePrefix = false;
                      prefix = value;
                    });
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2),
                child: Row(
                  children: [
                    Text(
                      'ชื่อ',
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
                          color: validateFirstName
                              ? Colors.red
                              : Color.fromARGB(255, 221, 219, 218))),
                  child: TextFormField(
                    onChanged: (value) => {
                      if (value.isEmpty)
                        {
                          setState(() {
                            validateFirstName = true;
                          })
                        }
                      else
                        {
                          setState(() {
                            validateFirstName = false;
                          })
                        }
                    },
                    controller: firstName,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
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
                      'นามสกุล',
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
                          color: validateLastName
                              ? Colors.red
                              : Color.fromARGB(255, 221, 219, 218))),
                  child: TextFormField(
                    onChanged: (value) => {
                      if (value.isEmpty)
                        {
                          setState(() {
                            validateLastName = true;
                          })
                        }
                      else
                        {
                          setState(() {
                            validateLastName = false;
                          })
                        }
                    },
                    controller: lastName,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2),
                child: Text(
                  'ตำแหน่ง',
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
                  child: TextFormField(
                    controller: position,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2),
                child: Text(
                  'เบอร์โทรศัพท์',
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
                  child: TextFormField(
                    controller: phoneNumber,
                    inputFormatters: [maskFormatter],
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2),
                child: Text(
                  'อีเมล',
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
                  child: TextFormField(
                    controller: email,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
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
              PopupPicker(
                validate: validateRoleCode,
                list: listRole,
                onSelected: (index, id, code, value) {
                  if (value!.isEmpty) {
                    setState(() {
                      validateRoleCode = true;
                    });
                  } else {
                    setState(() {
                      roleCode = code!;
                      validateRoleCode = false;
                    });
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2),
                child: Row(
                  children: [
                    Text(
                      'ผู้ใช้งาน',
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
                          color: validateUsername
                              ? Colors.red
                              : Color.fromARGB(255, 221, 219, 218))),
                  child: TextFormField(
                    onChanged: (value) => {
                      if (value.isEmpty)
                        {
                          setState(() {
                            validateUsername = true;
                          })
                        }
                      else
                        {
                          setState(() {
                            validateUsername = false;
                          })
                        }
                    },
                    controller: username,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
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
                      'รหัสผ่าน',
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
                          color: validatePassword
                              ? Colors.red
                              : Color.fromARGB(255, 221, 219, 218))),
                  child: TextFormField(
                    onChanged: (value) => {
                      if (value.isEmpty)
                        {
                          setState(() {
                            validatePassword = true;
                          })
                        }
                      else
                        {
                          setState(() {
                            validatePassword = false;
                          })
                        }
                    },
                    obscureText: true,
                    controller: password,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: InputBorder.none,
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
                      'ยืนยันรหัสผ่าน',
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
                          color: validateConfirmPassword
                              ? Colors.red
                              : Color.fromARGB(255, 221, 219, 218))),
                  child: TextFormField(
                    obscureText: true,
                    onChanged: (value) => {
                      if (value.isEmpty)
                        {
                          setState(() {
                            validateConfirmPassword = true;
                          })
                        }
                      else
                        {
                          setState(() {
                            validateConfirmPassword = false;
                          })
                        }
                    },
                    controller: confirmPassword,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 10))
            ],
          ),
        ),
      ),
    );
  }
}
