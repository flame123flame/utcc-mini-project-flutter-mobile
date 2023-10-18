import 'dart:math';

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
import 'fare_list.dart';
import 'model/bus_lines.dart';
import 'model/fare_list.dart';
import 'model/request_ticket.dart';

class FareAdd extends StatefulWidget {
  final int? worksheetId;
  final int? busLinesId;
  final int? trip;
  final int? busVehicleId;

  const FareAdd(
      {Key? key,
      this.worksheetId,
      this.busVehicleId,
      required this.busLinesId,
      required this.trip})
      : super(key: key);

  @override
  State<FareAdd> createState() => _FareAddState();
}

class _FareAddState extends State<FareAdd> {
  TextEditingController number = new TextEditingController();
  // String? trip = "0";
  String? ticket;
  int? busTerminalId;
  List<RequestTicket> requestTicketList = [];
  SaveForm() async {
    List<RequestTicket> requestTicketList = fareList.map((fareItem) {
      return RequestTicket(
        fareId: fareItem.fareId!,
        ticketNo: fareItem.ticketValue!.text,
      );
    }).toList();
    try {
      EasyLoading.show(
        indicator: Image.asset(
          'assets/images/Loading_2.gif',
          height: 70,
        ),
      );
      await Future.delayed(Duration(seconds: 1));
      Response data = await ApiService.apiSaveTicket(
          widget.trip!, widget.worksheetId!, busTerminalId!, requestTicketList);
      if (data.statusCode == 200) {
        Navigator.of(context).pop();
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  // List<BusLines> busLines = [];
  List<PopupModel> busLines = [];
  Future<void> apiFindBusLinesId() async {
    try {
      List<BusLines> data =
          await ApiService.apiFindBusLinesId(widget.busLinesId!);

      busLines = data
          .map((busLine) => PopupModel(
                id: busLine.busTerminalId!,
                lable: busLine.busTerminalName!,
                code: busLine.busTerminalName!,
              ))
          .toList();
      setState(() {});
    } catch (e) {
      // Handle errors here
    }
  }

  List<FareListModel> fareList = [];

  Future<void> apiFindWorkSheetId() async {
    try {
      List<FareListModel> data =
          await ApiService.apiFindWorksheetId(widget.worksheetId!);

      setState(() {
        fareList = data;
      });
    } catch (e) {
      // Handle errors here
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
    apiFindBusLinesId();
    apiFindWorkSheetId();

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
                  padding: EdgeInsets.only(bottom: 9, left: 2),
                  child: Row(
                    children: [
                      Text(
                        'เที่ยวการเดินรถที่ ${widget.trip}',
                        style: TextStyle(
                            fontFamily: 'prompt',
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, left: 2),
                  child: Row(
                    children: [
                      Text(
                        'ท่ารถเมล์',
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
                  list: busLines,
                  onSelected: (index, id, code, value) {
                    setState(() {
                      busTerminalId = id!;
                    });
                    if (value!.isEmpty) {
                    } else {}
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                ...List.generate(
                  fareList.length,
                  ((index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5, left: 2, top: 7),
                          child: Row(
                            children: [
                              Text(
                                'เลขหน้าตั๋ว ${fareList[index].fareDesc}',
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
                          padding:
                              EdgeInsets.only(left: 5, right: 1, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: Color.fromARGB(255, 221, 219, 218),
                            ),
                          ),
                          child: Focus(
                            onFocusChange: (hasFocus) {},
                            child: TextFormField(
                              controller: fareList[index].ticketValue,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
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
