import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:utcc_mobile/screens/fare/model/ticket_trip.dart';

import '../../constants/constant_color.dart';
import '../../service/api_service.dart';
import '../../utils/size_config.dart';
import 'fare_add.dart';
import 'model/bus_lines.dart';
import 'model/ticket.dart';

class FareDeatil extends StatefulWidget {
  final int? worksheetId;
  final String? status;
  final int? busLinesId;
  final int? busVehicleId;

  const FareDeatil(
      {Key? key,
      this.worksheetId,
      required this.status,
      required this.busVehicleId,
      required this.busLinesId})
      : super(key: key);

  @override
  State<FareDeatil> createState() => _FareDeatilState();
}

class _FareDeatilState extends State<FareDeatil>
    with SingleTickerProviderStateMixin {
  final valueFormat = new NumberFormat("#,##0.00", "en_US");
  List<int> sumList = [];
  double sum = 0;
  int sumCal = 0;
  List<TicketTrip> dataList = [];

  getData() async {
    try {
      List<TicketTrip> data =
          await ApiService.apiGetTicketByIdNew(widget.worksheetId!);
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

  AnimationController? _hideFabAnimation;
  var formatterSum = NumberFormat.currency(locale: 'th_TH', symbol: '฿');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return Scaffold(
        bottomNavigationBar:
            widget.status == 'IN_PROGRESS' ? _buttomNew(context) : null,
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

  Widget _buttomNew(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 25, right: 20, left: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0), topRight: Radius.circular(0)),
      ),
      child: elememtButtom(),
    );
  }

  Widget elememtButtom() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: FareAdd(
                              busVehicleId: widget.busVehicleId,
                              trip: dataList.length + 1,
                              worksheetId: widget.worksheetId,
                              busLinesId: widget.busLinesId),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        ).then((value) => {getData()})
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromARGB(255, 29, 45, 170),
                                  Color.fromARGB(255, 34, 50, 174),
                                ])),
                        height: 40,
                        width: double.infinity,
                        child: Text(
                          'เพิ่มรอบการเดินรถ',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
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
