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
  TextEditingController busVehiclePlateNo = new TextEditingController();
  TextEditingController busVehicleNumber = new TextEditingController();
  String busVehiclePlateProv = '';

  bool validateBusVehiclePlateNo = false;
  bool validateBusVehicleNumber = false;
  bool validateBusVehiclePlateProv = false;

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
      mask: '#-#####', type: MaskAutoCompletionType.eager);
  var maskFormatterBusPlate = new MaskTextInputFormatter(
      mask: '##-####', type: MaskAutoCompletionType.eager);
  var maskFormatterMoney = new MaskTextInputFormatter(
      filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  ValidateForm() {
    if (busVehicleNumber.text.trim().isEmpty) {
      validateBusVehicleNumber = true;
      setState(() {});
      return;
    } else {
      validateBusVehicleNumber = false;
      setState(() {});
    }

    if (busVehiclePlateNo.text.trim().isEmpty) {
      validateBusVehiclePlateNo = true;
      setState(() {});
      return;
    } else {
      validateBusVehiclePlateNo = false;
      setState(() {});
    }

    if (busVehiclePlateProv.trim().isEmpty) {
      validateBusVehiclePlateProv = true;
      setState(() {});
      return;
    } else {
      validateBusVehiclePlateProv = false;
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
      Response data = await ApiService.apiSaveBus(
          busVehicleNumber.text, busVehiclePlateNo.text, busVehiclePlateProv);
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
          backgroundColor: colorBar(context),
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
                            fontWeight: FontWeight.w900),
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
                            color: validateBusVehicleNumber
                                ? Colors.red
                                : Color.fromARGB(255, 221, 219, 218))),
                    child: Focus(
                      onFocusChange: (hasFocus) {},
                      child: TextFormField(
                        controller: busVehicleNumber,
                        onChanged: (value) => {
                          if (value.isEmpty)
                            {
                              setState(() {
                                validateBusVehicleNumber = true;
                              })
                            }
                          else
                            {
                              setState(() {
                                validateBusVehicleNumber = false;
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
                            fontWeight: FontWeight.w900),
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
                            color: validateBusVehiclePlateNo
                                ? Colors.red
                                : Color.fromARGB(255, 221, 219, 218))),
                    child: TextFormField(
                      controller: busVehiclePlateNo,
                      onChanged: (value) => {
                        if (value.isEmpty)
                          {
                            setState(() {
                              validateBusVehiclePlateNo = true;
                            })
                          }
                        else
                          {
                            setState(() {
                              validateBusVehiclePlateNo = false;
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
                            fontWeight: FontWeight.w900),
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
                  validate: validateBusVehiclePlateProv,
                  list: listProvince,
                  onSelected: (index, id, code, value) {
                    if (value!.isEmpty) {
                      setState(() {
                        validateBusVehiclePlateProv = true;
                      });
                    } else {
                      setState(() {
                        busVehiclePlateProv = value;
                        validateBusVehiclePlateProv = false;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
