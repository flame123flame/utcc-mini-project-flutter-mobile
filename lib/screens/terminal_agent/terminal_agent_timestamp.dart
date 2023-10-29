import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../components/picker_time.dart';
import '../../constants/constant_color.dart';
import '../../service/api_service.dart';
import '../../utils/size_config.dart';
import '../fare/fare_add.dart';
import '../fare/model/ticket_trip.dart';

class TerminalAgentTimestamp extends StatefulWidget {
  final int? worksheetId;
  final String? status;
  final int? busLinesId;
  final int? busVehicleId;
  const TerminalAgentTimestamp(
      {Key? key,
      this.worksheetId,
      required this.status,
      required this.busVehicleId,
      required this.busLinesId})
      : super(key: key);

  @override
  State<TerminalAgentTimestamp> createState() => _TerminalAgentTimestampState();
}

class _TerminalAgentTimestampState extends State<TerminalAgentTimestamp>
    with SingleTickerProviderStateMixin {
  final valueFormat = new NumberFormat("#,##0.00", "en_US");
  List<int> sumList = [];
  double sum = 0;
  int sumCal = 0;
  List<TicketTrip> dataList = [];

  getData() async {
    try {
      List<TicketTrip> data =
          await ApiService.apiGetTicketByIdTimestamp(widget.worksheetId!);
      sum = 0;
      for (var i = 0; i < data.length; i++) {
        sum += data[i].sumPrice!;
      }
      setState(() {
        dataList = data;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setTimestamp(int terminalTimestampId, String terminalTimeDeparture,
      BuildContext context) async {
    try {
      print(terminalTimestampId);
      print(terminalTimeDeparture);
      Response data = await ApiService.setTimestamp(
          terminalTimestampId, terminalTimeDeparture);
      notifacontionCustom(
          context, "ลงเวลาออกจากท่า " + terminalTimeDeparture + " สำเร็จ");
      setState(() {});
    } catch (e) {}
  }

  setTimestampEnd(int terminalTimestampId, int worksheetId,
      String terminalTimeDeparture, BuildContext context) async {
    try {
      print(terminalTimestampId);
      print(terminalTimeDeparture);
      Response data = await ApiService.setTimestampEnd(
          terminalTimestampId, worksheetId, terminalTimeDeparture);
      notifacontionCustom(
          context, "ตัดเลิกสำเร็จ " + terminalTimeDeparture + " สำเร็จ");
      setState(() {});
    } catch (e) {}
  }

  void notifacontionCustom(BuildContext context, String text) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              'การลงเวลา',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 57, 52),
                  fontFamily: 'prompt',
                  fontWeight: FontWeight.w900,
                  fontSize: 21),
            ),
            content: Text(
              text,
              style: TextStyle(
                  color: Color.fromARGB(255, 55, 48, 43),
                  fontFamily: 'prompt',
                  fontSize: 15),
            ),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
                child: const Text(
                  'ตกลง',
                  style: TextStyle(
                    fontFamily: 'prompt',
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 12, 60, 156),
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

  AnimationController? _hideFabAnimation;
  var formatterSum = NumberFormat.currency(locale: 'th_TH', symbol: '฿');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: Color.fromARGB(235, 235, 244, 255),
        body: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                GradientContainerHeader(size, context),
                Positioned(
                  top: size.height * .11,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${formatterSum.format(sum)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: '11',
                          fontWeight: FontWeight.w600,
                          fontSize: 34,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (dataList.length > 0)
              Expanded(
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return cardDetail(dataList[index], dataList);
                  },
                ),
              ),
            if (dataList.isEmpty)
              Padding(
                padding: EdgeInsets.all(38.0),
                child: Text(
                  'ยังไม่มีรอบการเดินรถ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
          ],
        ),
      );
    });
  }

  var formatter = NumberFormat.currency(locale: 'th_TH', symbol: '฿');
  var formatterTicket = NumberFormat.currency(
    locale: 'th_TH',
    symbol: '',
    decimalDigits: 0, // Set the number of decimal places to 0
  );

  Widget cardDetail(TicketTrip data, List<TicketTrip> ticketTripList) {
    return Container(
      margin: EdgeInsets.only(
        top: SizeConfig.defaultSize! * 0.5,
        bottom: SizeConfig.defaultSize! * 0.5,
        left: SizeConfig.defaultSize! * 0.8,
        right: SizeConfig.defaultSize! * 0.8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xfff4f7ff),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.14),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(SizeConfig.defaultSize! * 1),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage("assets/images/logo-bmta-th.png"),
                    height: 40,
                  ),
                  Text(
                    '${formatter.format(data.sumPrice)} ',
                    style: TextStyle(
                      fontFamily: '11',
                      color: colorBar,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Divider(endIndent: 10, indent: 10),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data.terminalTimeDeparture ?? 'รอนายท่าลงเวลา'} ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 48, 47, 47),
                            fontSize: 20,
                            fontFamily: 'ww',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${data.busTerminalDepartureDes} ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Color.fromARGB(255, 119, 119, 119),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_right_alt,
                    size: 30,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${data.terminalTimeArrive ?? ''} ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 48, 47, 47),
                            fontSize: 20,
                            fontFamily: 'ww',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${data.busTerminalArrive ?? ''} ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            color: Color.fromARGB(255, 119, 119, 119),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ListView.builder(
              itemCount: data.ticketList!.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, indexTrip) {
                return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "เลขหน้าตั๋ว ${data.ticketList![indexTrip].fareDesc}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 35, 35, 35),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${data.ticketList![indexTrip].ticketNo}",
                        style: TextStyle(
                          color: Color.fromARGB(255, 35, 35, 35),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ตั๋วรวมขาที่ ${data.trip}",
                    style: TextStyle(
                      color: Color.fromARGB(255, 35, 35, 35),
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '${formatterTicket.format(data.sumTicket)} ใบ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 35, 35, 35),
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            if (!data.isTimestamp!) Divider(endIndent: 10, indent: 10),
            if (!data.isTimestamp!)
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ชื่อนายท่าที่ลงเวลา",
                      style: TextStyle(
                        color: Color.fromARGB(255, 35, 35, 35),
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '${data.busTerminalAgentName}',
                      style: TextStyle(
                        color: Color.fromARGB(255, 35, 35, 35),
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 6,
            ),
            if (data.isTimestamp!)
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: PickerTime(
                      mode: CupertinoDatePickerMode.time,
                      title: 'ลงเวลา',
                      validate: false,
                      onSelected: (datetime) {
                        setTimestamp(
                            data.terminalTimestampId!,
                            DateFormat.Hm().format(datetime!).toString(),
                            context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: PickerTime(
                      mode: CupertinoDatePickerMode.time,
                      title: 'ตัดเลิก',
                      validate: false,
                      onSelected: (datetime) {
                        setTimestampEnd(
                            data.terminalTimestampId!,
                            data.worksheetId!,
                            DateFormat.Hm().format(datetime!).toString(),
                            context);
                        print(DateFormat.Hm().format(datetime!).toString());
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Container GradientContainerHeader(Size size, BuildContext context) {
    return Container(
      height: size.height * 0.20,
      width: size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(0), bottomRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 25, 67, 144).withOpacity(.20),
                offset: Offset(0, 10),
                blurRadius: 20,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color.fromARGB(255, 34, 50, 174),
                Color.fromARGB(255, 37, 43, 99),
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 43, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 23,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
