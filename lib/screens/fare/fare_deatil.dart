import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../constants/constant_color.dart';
import '../../service/api_service.dart';
import '../../utils/size_config.dart';
import 'fare_add.dart';
import 'model/ticket.dart';

class FareDeatil extends StatefulWidget {
  final int? worksheetId;

  const FareDeatil({Key? key, this.worksheetId}) : super(key: key);

  @override
  State<FareDeatil> createState() => _FareDeatilState();
}

class _FareDeatilState extends State<FareDeatil> {
  final valueFormat = new NumberFormat("#,##0.00", "en_US");
  List<int> sumList = [];
  int sum = 0;
  int sumCal = 0;
  List<Ticket> dataList = [];
  getData() async {
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
        //print(sum);
      });
    } catch (e) {}
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: FareAdd(worksheetId: widget.worksheetId),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              ).then((value) => {getData()});
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
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
                              '฿${sumList.reduce((a, b) => a + b)}',
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
