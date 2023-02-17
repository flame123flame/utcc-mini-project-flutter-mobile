import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../constants/constant_color.dart';
import '../../utils/size_config.dart';

class FareDeatil extends StatefulWidget {
  const FareDeatil({Key? key}) : super(key: key);

  @override
  State<FareDeatil> createState() => _FareDeatilState();
}

class _FareDeatilState extends State<FareDeatil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 235, 240, 244),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180.0),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          flexibleSpace: Center(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          Color.fromARGB(255, 34, 50, 174),
                          Color.fromARGB(255, 37, 43, 99),
                        ]),
                  ),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(''),
                              Text(
                                '฿2,783.00',
                                style: TextStyle(
                                    fontFamily: '11',
                                    color: Colors.white,
                                    fontSize: 42,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(''),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'เต็มราคา',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        '฿300',
                                        style: TextStyle(
                                            fontFamily: '11',
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'ลดหย่อน',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        '฿58',
                                        style: TextStyle(
                                            fontFamily: '11',
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'เต็ม/ลดหย่อน(ใบ)',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        '534/43',
                                        style: TextStyle(
                                            fontFamily: '11',
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // backgroundColor: colorBar,
          title: const Text(
            '',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 1),
            child: Container(
              margin: EdgeInsets.only(top: 2),
              child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return test();
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Widget test() {
    return Container(
      margin: EdgeInsets.only(
          top: SizeConfig.defaultSize! * 0.5,
          bottom: SizeConfig.defaultSize! * 0.5,
          left: SizeConfig.defaultSize! * 0.8,
          right: SizeConfig.defaultSize! * 0.8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xfff4f7ff),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.14),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
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
                      "฿576",
                      style: TextStyle(
                          fontFamily: '11',
                          color: colorBar,
                          fontSize: 26,
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
                            Text(
                              "08:30",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 48, 47, 47),
                                  fontSize: 20,
                                  fontFamily: 'ww',
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "สนามหลวง (มหาวิทยาลัยธรรมศาสตร์)",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Color.fromARGB(255, 119, 119, 119),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
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
                              "11:30",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 48, 47, 47),
                                  fontSize: 20,
                                  fontFamily: 'ww',
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "อนุสาวรีย์ชัยสมรภูมิ",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 119, 119, 119),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ตั๋วเต็มราคา",
                      style: TextStyle(
                          color: Color.fromARGB(255, 35, 35, 35),
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "300 ใบ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 35, 35, 35),
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ตั๋วลดหย่อน",
                      style: TextStyle(
                          color: Color.fromARGB(255, 35, 35, 35),
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "34 ใบ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 35, 35, 35),
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "รวม",
                      style: TextStyle(
                          color: Color.fromARGB(255, 35, 35, 35),
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "334 ใบ",
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
