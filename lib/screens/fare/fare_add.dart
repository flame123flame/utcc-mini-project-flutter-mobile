import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:utcc_mobile/components/dropdown_user.dart';

import '../../components/dropdown_bus.dart';
import '../../components/popup_date_picker.dart';
import '../../components/popup_picker.dart';
import '../../components/text_input.dart';
import '../../model_components/popup_model.dart';
import '../../service/api_service.dart';
import '../../utils/size_config.dart';

class FareAdd extends StatefulWidget {
  final int? worksheetId;
  const FareAdd({Key? key, this.worksheetId}) : super(key: key);

  @override
  State<FareAdd> createState() => _FareAddState();
}

class _FareAddState extends State<FareAdd> {
  TextEditingController number = new TextEditingController();
  String? trip = "0";
  String? ticket;

  SaveForm() async {
    try {
      EasyLoading.show(
        indicator: Image.asset(
          'assets/images/Loading_2.gif',
          height: 70,
        ),
      );
      await Future.delayed(Duration(seconds: 1));
      Response data = await ApiService.apiSaveTicket(
          number.text, trip!, ticket!, widget.worksheetId!);
      if (data.statusCode == 200) {
        Navigator.of(context).pop();
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  List<PopupModel> listNumber = [];
  List<PopupModel> listTicket = [
    PopupModel(
      id: 0,
      lable: "ตั๋วเริ่มต้น",
      code: "btrue",
    ),
    PopupModel(
      id: 0,
      lable: "ตั๋วสิ้นสุด",
      code: "etrue",
    ),
    PopupModel(
      id: 0,
      lable: "ตั๋วปกติ",
      code: "false",
    )
  ];
  @override
  void initState() {
    for (var i = 1; i <= 10; i++) {
      listNumber.add(PopupModel(
        id: i,
        lable: i.toString(),
        code: i.toString(),
      ));
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                SaveForm();
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
          title: Text(
            'กรอกเลขหน้าตั๋ว',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              fontFamily: 'prompt',
            ),
          ),
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
                        'รอบตั๋ว',
                        style: TextStyle(
                            fontFamily: 'prompt',
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
                PopupPicker(
                  validate: false,
                  list: listTicket,
                  onSelected: (index, id, code, value) {
                    setState(() {
                      ticket = code;
                    });
                    if (value!.isEmpty) {
                    } else {}
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, left: 2),
                  child: Row(
                    children: [
                      Text(
                        'รอบที่(ขา)',
                        style: TextStyle(
                            fontFamily: 'prompt',
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
                PopupPicker(
                  validate: false,
                  list: listNumber,
                  onSelected: (index, id, code, value) {
                    setState(() {
                      trip = value;
                    });
                    if (value!.isEmpty) {
                    } else {}
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, left: 2),
                  child: Row(
                    children: [
                      Text(
                        'เลขหน้าตั๋ว 8 บาท',
                        style: TextStyle(
                            fontFamily: 'prompt',
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w800),
                      )
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
                            color: Color.fromARGB(255, 221, 219, 218))),
                    child: Focus(
                      onFocusChange: (hasFocus) {},
                      child: TextFormField(
                        controller: number,
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
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 10))
              ],
            ),
          ),
        ));
  }
}
