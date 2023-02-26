import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../components/dropdown_bus.dart';
import '../../components/dropdown_user.dart';
import '../../components/popup_bottom.dart';
import '../../components/popup_date_picker.dart';
import '../../components/text_input.dart';
import '../../utils/size_config.dart';

class WorkAssign extends StatefulWidget {
  const WorkAssign({Key? key}) : super(key: key);

  @override
  State<WorkAssign> createState() => _WorkAssignState();
}

class _WorkAssignState extends State<WorkAssign> {
  TextEditingController type = new TextEditingController(text: '');
  String busTypeDisplay = "";
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
              onPressed: () {},
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
            'จ่ายงาน',
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
                Row(
                  children: [
                    Text(
                      'วันที่มอบหมายงาน',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.defaultSize! * 0.1,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: PopupDatePicker(
                    validate: false,
                    onSelected: (datetime) {},
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      'เวลารับงานจริง',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.defaultSize! * 0.1,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: PopupDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    validate: false,
                    onSelected: (datetime) {},
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, left: 2),
                  child: Row(
                    children: [
                      Text(
                        'เลขข้างรถ',
                        style: TextStyle(
                            fontFamily: 'prompt',
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        ' *',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                Container(child: DropdownBus(
                  onSelect: (id, busNo, busType) {
                    setState(() {
                      type.text = busType;
                    });
                  },
                )),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, left: 2),
                  child: Row(
                    children: [
                      Text(
                        'ประเภทรถ',
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: TextInput(
                    validate: false,
                    enabled: false,
                    controller: type,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, left: 2),
                  child: Row(
                    children: [
                      Text(
                        'พนักงานขับรถ',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'prompt',
                            fontSize: 13,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        ' *',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                Container(child: DropdownUser()),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5, left: 2),
                  child: Row(
                    children: [
                      Text(
                        'พนักงานเก็บค่าโดยสาร',
                        style: TextStyle(
                            fontFamily: 'prompt',
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        ' *',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                Container(child: DropdownUser()),
              ],
            ),
          ),
        ));
  }
}
