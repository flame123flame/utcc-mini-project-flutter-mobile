import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:utcc_mobile/components/popup_picker.dart';

import '../../constants/constant_color.dart';
import '../../constants/constant_font_size.dart';
import '../../model_components/popup_model.dart';
import '../../provider/user_login_provider.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  UserLoginProvider? userLoginProvider;
  TextEditingController prefix = new TextEditingController();
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController position = new TextEditingController();

  TextEditingController username = new TextEditingController();

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

  var maskFormatter = new MaskTextInputFormatter(
      mask: '###-#######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    userLoginProvider = Provider.of<UserLoginProvider>(context, listen: false);
    prefix.text = userLoginProvider!.getUserLogin.prefix!;
    firstName.text = userLoginProvider!.getUserLogin.firstName!;
    lastName.text = userLoginProvider!.getUserLogin.lastName!;
    position.text = userLoginProvider!.getUserLogin.position!;
    email.text = userLoginProvider!.getUserLogin.email!;
    phoneNumber.text = userLoginProvider!.getUserLogin.phoneNumber!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: colorBar,
        title: const Text('แก้ไขข้อมูลส่วนตัว'),
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
      ),
      body: Container(
        width: double.infinity,
        height: 660,
        margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2),
                child: Row(
                  children: [
                    Text(
                      'ข้อมูลส่วนตัว',
                      style: TextStyle(
                          color: Color.fromARGB(255, 48, 48, 48),
                          fontSize: 19,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2, top: 10),
                child: Row(
                  children: [
                    Text(
                      'คำนำหน้า',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: fontLableInput,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: fontLableInput,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              PopupPicker(
                validate: false,
                // list: listDropdownType,
                title: prefix.text,
                list: listPrefix,
                onSelected: (index, id, code, value) {
                  log('message');
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
                          fontSize: fontLableInput,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: fontLableInput,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 42,
                  padding: EdgeInsets.only(left: 5, right: 1, bottom: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: Color.fromARGB(255, 221, 219, 218))),
                  child: Focus(
                    onFocusChange: (hasFocus) {},
                    child: TextFormField(
                      style: TextStyle(fontSize: 13),
                      controller: firstName,
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
                      'นามสกุล',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: fontLableInput,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: fontLableInput,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 42,
                  padding: EdgeInsets.only(left: 5, right: 1, bottom: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: Color.fromARGB(255, 221, 219, 218))),
                  child: Focus(
                    onFocusChange: (hasFocus) {},
                    child: TextFormField(
                      style: TextStyle(fontSize: 13),
                      controller: lastName,
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
                  'ตำแหน่ง',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: fontLableInput,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 42,
                  padding: EdgeInsets.only(left: 5, right: 1, bottom: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: Color.fromARGB(255, 221, 219, 218))),
                  child: Focus(
                    onFocusChange: (hasFocus) {},
                    child: TextFormField(
                      style: TextStyle(fontSize: 13),
                      controller: position,
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
                  'เบอร์โทรศัพท์',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: fontLableInput,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 42,
                  padding: EdgeInsets.only(left: 5, right: 1, bottom: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: Color.fromARGB(255, 221, 219, 218))),
                  child: Focus(
                    onFocusChange: (hasFocus) {},
                    child: TextFormField(
                      style: TextStyle(fontSize: 13),
                      onChanged: (value) => {log(value.length.toString())},
                      controller: phoneNumber,
                      inputFormatters: [maskFormatter],
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
                  'อีเมล',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: fontLableInput,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 42,
                  padding: EdgeInsets.only(left: 5, right: 1, bottom: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: Color.fromARGB(255, 221, 219, 218))),
                  child: Focus(
                    onFocusChange: (hasFocus) {},
                    child: TextFormField(
                      scrollPadding: EdgeInsets.only(
                          bottom:
                              MediaQuery.of(context).viewInsets.bottom + 100),
                      style: TextStyle(fontSize: 13),
                      controller: email,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  )),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
