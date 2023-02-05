import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../components/popup_picker.dart';
import '../../constants/constant_color.dart';
import '../../model_components/popup_model.dart';
import '../../service/api_service.dart';

class ManageBus extends StatefulWidget {
  const ManageBus({Key? key}) : super(key: key);

  @override
  State<ManageBus> createState() => _ManageBusState();
}

class _ManageBusState extends State<ManageBus> {
  TextEditingController busNo = new TextEditingController();
  TextEditingController busPlate = new TextEditingController();
  TextEditingController fare = new TextEditingController();
  TextEditingController discountFare = new TextEditingController();
  String busType = '';
  String busProvince = '';
  bool validateBusNo = false;
  bool validateFare = false;
  bool validateDiscountFare = false;
  bool validateBusType = false;
  bool validateBusPlate = false;
  bool validateBusProvince = false;

  List<PopupModel> listPrefix = [
    PopupModel(
      id: 0,
      lable: "ปอ.ก๊าซ BONLUCK",
      code: "001",
    ),
    PopupModel(
      id: 1,
      lable: "ครีมแดง HINO",
      code: "002",
    ),
    PopupModel(
      id: 2,
      lable: "ปอ.ยูโรทู HINO 44",
      code: "003",
    ),
    PopupModel(
      id: 3,
      lable: "ปอ.ยูโรทู HINO 45",
      code: "004",
    ),
    PopupModel(
      id: 4,
      lable: "ปอ.ยูโรทู ISUZU 55",
      code: "005",
    ),
    PopupModel(
      id: 4,
      lable: "ปอ.ยูโรทู ISUZU 56",
      code: "005",
    ),
    PopupModel(
      id: 5,
      lable: "ครีมแดง ISUZU",
      code: "006",
    ),
  ];

  List<PopupModel> listProvince = [
    PopupModel(
      id: 0,
      lable: "กรุงเทพมหานคร",
      code: "001",
    ),
    PopupModel(
      id: 1,
      lable: "ปทุมธานี",
      code: "002",
    ),
    PopupModel(
      id: 2,
      lable: "นนทบุรี",
      code: "003",
    ),
    PopupModel(
      id: 3,
      lable: "สมุทรปราการ",
      code: "004",
    ),
    PopupModel(
      id: 4,
      lable: "สมุทรสาคร",
      code: "005",
    ),
    PopupModel(
      id: 5,
      lable: "นครปฐม",
      code: "006",
    )
  ];

  var maskFormatterBusNo = new MaskTextInputFormatter(
      mask: '#-##### / ##-#####', type: MaskAutoCompletionType.eager);
  var maskFormatterBusPlate = new MaskTextInputFormatter(
      mask: '##-####', type: MaskAutoCompletionType.eager);
  var maskFormatterMoney = new MaskTextInputFormatter(
      filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  ValidateForm() {
    if (busNo.text.trim().isEmpty) {
      validateBusNo = true;
      setState(() {});
      return;
    } else {
      validateBusNo = false;
      setState(() {});
    }
    if (busPlate.text.trim().isEmpty) {
      validateBusPlate = true;
      setState(() {});
      return;
    } else {
      validateBusPlate = false;
      setState(() {});
    }
    if (busProvince.trim().isEmpty) {
      validateBusProvince = true;
      setState(() {});
      return;
    } else {
      validateBusProvince = false;
      setState(() {});
    }
    if (busType.trim().isEmpty) {
      validateBusType = true;
      setState(() {});
      return;
    } else {
      validateBusType = false;
      setState(() {});
    }
    if (fare.text.trim().isEmpty) {
      validateFare = true;
      setState(() {});
      return;
    } else {
      validateFare = false;
      setState(() {});
    }
    if (discountFare.text.trim().isEmpty) {
      validateDiscountFare = true;
      setState(() {});
      return;
    } else {
      validateDiscountFare = false;
      setState(() {});
    }

    SaveForm();
  }

  SaveForm() async {
    try {
      EasyLoading.show(
        indicator: Image.asset(
          'assets/images/Loading_2.gif',
          height: 70,
        ),
      );
      await Future.delayed(Duration(seconds: 1));
      Response data = await ApiService.apiSaveBus(busNo.text, fare.text,
          discountFare.text, busType, busPlate.text, busProvince);
      if (data.statusCode == 200) {
        Navigator.of(context).pop();
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: new Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: colorBar,
          title: const Text('จัดการรถเมล์'),
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
                ValidateForm();
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
                        'เลขข้างรถ',
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
                            color: validateBusNo
                                ? Colors.red
                                : Color.fromARGB(255, 221, 219, 218))),
                    child: Focus(
                      onFocusChange: (hasFocus) {},
                      child: TextFormField(
                        controller: busNo,
                        onChanged: (value) => {
                          if (value.isEmpty)
                            {
                              setState(() {
                                validateBusNo = true;
                              })
                            }
                          else
                            {
                              setState(() {
                                validateBusNo = false;
                              })
                            }
                        },
                        inputFormatters: [maskFormatterBusNo],
                        keyboardType: TextInputType.number,
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
                        'เลขทะเบียนรถ',
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
                            color: validateBusPlate
                                ? Colors.red
                                : Color.fromARGB(255, 221, 219, 218))),
                    child: TextFormField(
                      controller: busPlate,
                      onChanged: (value) => {
                        if (value.isEmpty)
                          {
                            setState(() {
                              validateBusNo = true;
                            })
                          }
                        else
                          {
                            setState(() {
                              validateBusNo = false;
                            })
                          }
                      },
                      inputFormatters: [maskFormatterBusPlate],
                      keyboardType: TextInputType.number,
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
                        'จังหวัด',
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
                  validate: validateBusProvince,
                  list: listProvince,
                  onSelected: (index, id, code, value) {
                    if (value!.isEmpty) {
                      setState(() {
                        validateBusProvince = true;
                      });
                    } else {
                      setState(() {
                        busProvince = value;
                        validateBusProvince = false;
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
                        'ประเภทรถ',
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
                  validate: validateBusType,
                  list: listPrefix,
                  onSelected: (index, id, code, value) {
                    setState(() {
                      busType = value!;
                      validateBusType = false;
                    });
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
                        'ราคาเต็ม',
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
                            color: validateFare
                                ? Colors.red
                                : Color.fromARGB(255, 221, 219, 218))),
                    child: TextFormField(
                      controller: fare,
                      onChanged: (value) => {
                        if (value.isEmpty)
                          {
                            setState(() {
                              validateFare = true;
                            })
                          }
                        else
                          {
                            setState(() {
                              validateFare = false;
                            })
                          }
                      },
                      textInputAction: TextInputAction.next,
                      inputFormatters: [maskFormatterMoney],
                      keyboardType: TextInputType.datetime,
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
                        'ราคาลดหย่อน',
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
                            color: validateDiscountFare
                                ? Colors.red
                                : Color.fromARGB(255, 221, 219, 218))),
                    child: Focus(
                      onFocusChange: (hasFocus) {},
                      child: TextFormField(
                        controller: discountFare,
                        inputFormatters: [maskFormatterMoney],
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => {
                          if (value.isEmpty)
                            {
                              setState(() {
                                validateDiscountFare = true;
                              })
                            }
                          else
                            {
                              setState(() {
                                validateDiscountFare = false;
                              })
                            }
                        },
                      ),
                    )),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
