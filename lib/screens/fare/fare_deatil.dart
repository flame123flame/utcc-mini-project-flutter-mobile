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
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return Scaffold(
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
                          Text(
                            "฿3,904.00",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: '11',
                                fontWeight: FontWeight.w600,
                                fontSize: 43),
                          ),
                        ])),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 25, right: 25, top: 155),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(11)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "รอบการวิ่ง",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'ยอดตั๋วรวม',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' test ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "test",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' test ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' test ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "test",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' test ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' test ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "test",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' test ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' test ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "test",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' test ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' test ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "test",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' test ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' test ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "test",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' test ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' test ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: 13),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: GridView.count(
                  primary: false,
                  padding:
                      EdgeInsets.only(left: 3, right: 3, top: 10, bottom: 3),
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 1,
                  crossAxisCount: 1,
                  childAspectRatio: 2.2,
                  children: [
                    ...List.generate(3, (index) {
                      return cardDetail();
                    })
                  ],
                ),
                // child: ListView.builder(
                //     itemCount: 3,
                //     shrinkWrap: true,
                //     scrollDirection: Axis.vertical,
                //     // physics: ClampingScrollPhysics(),
                //     itemBuilder: (context, index) {
                //       return cardDetail();
                //     }),
              ),
            ),
          ]));
    });
  }

  Widget cardDetail() {
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
              // Padding(
              //   padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         "ตั๋วเต็มราคา",
              //         style: TextStyle(
              //             color: Color.fromARGB(255, 35, 35, 35),
              //             fontSize: 13,
              //             fontWeight: FontWeight.w800),
              //       ),
              //       Text(
              //         "300 ใบ",
              //         style: TextStyle(
              //             color: Color.fromARGB(255, 35, 35, 35),
              //             fontSize: 13,
              //             fontWeight: FontWeight.w800),
              //       ),
              //     ],
              //   ),
              // ),
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

Container GradientContainerHeader(Size size, BuildContext context) {
  return Container(
    height: size.height * 0.28,
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
