import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

import '../../constants/constant_color.dart';
import '../../service/api_service.dart';
import '../../utils/size_config.dart';
import '../fare/model/ticket.dart';

class OverviewDetail extends StatefulWidget {
  final int? worksheetId;
  final String? status;
  const OverviewDetail({Key? key, this.worksheetId, required this.status})
      : super(key: key);

  @override
  State<OverviewDetail> createState() => _OverviewDetailState();
}

class _OverviewDetailState extends State<OverviewDetail> {
  final valueFormat = new NumberFormat("#,##0.00", "en_US");
  List<int> sumList = [];
  int sum = 0;
  int sumCal = 0;
  List<Ticket> dataList = [];
  getData() async {
    setState(() {
      sum = 0;
      sumList.clear();
    });
    try {
      List<Ticket> data =
          await ApiService.apiGetTicketById(widget.worksheetId!);
      for (var i = 0; i < data.length; i++) {
        sumList.add((int.parse(data[i].ticketNoSum!) * 8));
        //print(sumList);
      }
      setState(() {
        sum = sumList.reduce((a, b) => a + b);
        dataList = data;
      });
    } catch (e) {}
  }

  UpdateStats() async {
    try {
      EasyLoading.show(
        indicator: Image.asset(
          'assets/images/Loading_2.gif',
          height: 70,
        ),
      );
      await Future.delayed(Duration(seconds: 1));
      Response data = await ApiService.apiUpdateStatus(widget.worksheetId!);
      if (data.statusCode == 200) {
        Navigator.of(context).pop();
        Navigator.of(context).pop("noti");
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  void showFlushbar({
    required String message,
    required Color backgroundColor,
    required Icon icon,
    required Function() onPressed,
  }) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      icon: icon,
      message: message,
      margin: EdgeInsets.only(
        left: 60,
        right: 60,
        bottom: 10,
        top: 10,
      ),
      backgroundColor: backgroundColor,
      flushbarStyle: FlushbarStyle.FLOATING,
      borderRadius: BorderRadius.circular(8),
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 10),
      duration: Duration(milliseconds: 2000),
      animationDuration: Duration(milliseconds: 1000),
      textDirection: Directionality.of(context),
      isDismissible: false,
    ).show(context);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void notifacontionCustom(BuildContext context, String text) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              'การยืนยัน',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 57, 52),
                  fontFamily: 'prompt',
                  fontWeight: FontWeight.w900,
                  fontSize: 22),
            ),
            content: Text(
              text,
              style: TextStyle(
                  color: Color.fromARGB(255, 55, 48, 43),
                  fontFamily: 'prompt',
                  fontSize: 17),
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
                  'ยกเลิก',
                  style: TextStyle(
                    fontFamily: 'prompt',
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 223, 40, 8),
                  ),
                ),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              CupertinoDialogAction(
                onPressed: () {
                  UpdateStats();
                  setState(() {});
                },
                child: const Text(
                  'ตกลง',
                  style: TextStyle(
                    fontFamily: 'prompt',
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 32, 114, 4),
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
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return Scaffold(
          floatingActionButton: widget.status == 'IN_PROGRESS'
              ? InkWell(
                  child: Container(
                    width: 120,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_box_outlined,
                          size: 23,
                          color: Colors.white,
                        ),
                        Text(
                          " ตัดจบงาน",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 34, 52, 187),
                          Color.fromARGB(255, 37, 43, 99),
                        ])),
                  ),
                  onTap: () {
                    notifacontionCustom(context, "ต้องการยืนยันการจบงาน ?");
                    print("object");
                  },
                )
              : Container(),
          backgroundColor: Color.fromARGB(235, 235, 244, 255),
          body: Column(children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                GradientContainerHeader(size, context),
                Positioned(
                    top: size.height * .10,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (sumList.length > 0)
                            Text(
                              '฿${valueFormat.format(sum)}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: '11',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 43),
                            ),
                          if (sumList.length == 0)
                            Text(
                              '฿${0}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: '11',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 43),
                            ),
                        ])),
              ],
            ),
            if (dataList.length > 0)
              Expanded(
                child: Container(
                  child: GridView.count(
                    primary: false,
                    padding:
                        EdgeInsets.only(left: 3, right: 3, top: 10, bottom: 3),
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 1,
                    crossAxisCount: 1,
                    childAspectRatio: 2.7,
                    children: [
                      ...List.generate(dataList.length, (index) {
                        return cardDetail(dataList[index]);
                      })
                    ],
                  ),
                ),
              ),
            if (dataList.length <= 0)
              Padding(
                padding: const EdgeInsets.all(38.0),
                child: Container(
                  child: Text(
                    'ยังไม่มีรอบการเดินรถ',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
          ]));
    });
  }

  Widget cardDetail(Ticket data) {
    return Container(
      margin: EdgeInsets.only(
          top: SizeConfig.defaultSize! * 0.5,
          bottom: SizeConfig.defaultSize! * 0.5,
          left: SizeConfig.defaultSize! * 0.8,
          right: SizeConfig.defaultSize! * 0.8),
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
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
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
                      '฿${valueFormat.format(int.parse(data.ticketNoSum!) * 8)}',
                      style: TextStyle(
                          fontFamily: '11',
                          color: colorBar,
                          fontSize: 22,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              Divider(
                endIndent: 10,
                indent: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   "08:30",
                            //   style: TextStyle(
                            //       color: Color.fromARGB(255, 48, 47, 47),
                            //       fontSize: 20,
                            //       fontFamily: 'ww',
                            //       fontWeight: FontWeight.w600),
                            // ),
                            // Text(
                            //   "สนามหลวง (มหาวิทยาลัยธรรมศาสตร์)",
                            //   overflow: TextOverflow.ellipsis,
                            //   maxLines: 1,
                            //   softWrap: false,
                            //   style: TextStyle(
                            //       overflow: TextOverflow.ellipsis,
                            //       color: Color.fromARGB(255, 119, 119, 119),
                            //       fontSize: 13,
                            //       fontWeight: FontWeight.w600),
                            // ),
                          ],
                        ),
                      ),
                      // Icon(
                      //   Icons.arrow_right_alt,
                      //   size: 30,
                      // ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Text(
                            //   "11:30",
                            //   style: TextStyle(
                            //       color: Color.fromARGB(255, 48, 47, 47),
                            //       fontSize: 20,
                            //       fontFamily: 'ww',
                            //       fontWeight: FontWeight.w600),
                            // ),
                            // Text(
                            //   "อนุสาวรีย์ชัยสมรภูมิ",
                            //   overflow: TextOverflow.ellipsis,
                            //   maxLines: 1,
                            //   softWrap: false,
                            //   style: TextStyle(
                            //       color: Color.fromARGB(255, 119, 119, 119),
                            //       fontSize: 13,
                            //       fontWeight: FontWeight.w600),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "เลขหน้าตั๋วราคา 8 บาท",
                      style: TextStyle(
                          color: Color.fromARGB(255, 35, 35, 35),
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      '${data.ticketNo}',
                      style: TextStyle(
                          color: Color.fromARGB(255, 35, 35, 35),
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 10, right: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "ตั๋วลดหย่อน",
              //         style: TextStyle(
              //             color: Color.fromARGB(255, 35, 35, 35),
              //             fontSize: 13,
              //             fontWeight: FontWeight.w800),
              //       ),
              //       Text(
              //         "34 ใบ",
              //         style: TextStyle(
              //             color: Color.fromARGB(255, 35, 35, 35),
              //             fontSize: 13,
              //             fontWeight: FontWeight.w800),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ตั๋วรวม",
                      style: TextStyle(
                          color: Color.fromARGB(255, 35, 35, 35),
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      '${data.ticketNoSum} ใบ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 35, 35, 35),
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

Container GradientContainerHeader(Size size, BuildContext context) {
  return Container(
    height: size.height * 0.22,
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
