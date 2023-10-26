import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/constant_color.dart';
import '../model_components/popup_model.dart';
import '../utils/size_config.dart';
import '../utils/time_format.dart';

class PickerTime extends StatefulWidget {
  final Function(DateTime?) onSelected;
  final CupertinoDatePickerMode mode;
  final String title;
  late bool validate;
  PickerTime(
      {Key? key,
      required this.onSelected,
      this.mode = CupertinoDatePickerMode.date,
      required this.validate,
      this.title = 'ลงเวลา'})
      : super(key: key);

  @override
  State<PickerTime> createState() => _PickerTimeState();
}

class _PickerTimeState extends State<PickerTime> {
  DateTime? dateSelected;
  DateTime? tempDateSelected;
  DateTime? dateSelectedToUse;
  DateTime now = new DateTime.now();
  bool validate = false;
  void _showDialog(Widget child, context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.4,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = new DateTime(now.year + 543, now.month, now.day);

    return Column(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
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
              '${widget.title}',
              style: TextStyle(
                  fontFamily: 'prompt',
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15,
                  fontWeight: FontWeight.w900),
            ),
          ),
          onPressed: () => _showDialog(
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CupertinoButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'ปิด',
                                style: TextStyle(
                                    fontFamily: 'prompt',
                                    color: Color.fromARGB(255, 12, 54, 151),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                widget.validate = false;
                                setState(() {
                                  dateSelected =
                                      tempDateSelected ?? currentDate;
                                  if (null != tempDateSelected) {
                                    dateSelectedToUse = DateTime(
                                      tempDateSelected!.year - 543,
                                      tempDateSelected!.month,
                                      tempDateSelected!.day,
                                      tempDateSelected!.hour,
                                      tempDateSelected!.minute,
                                    );
                                  } else {
                                    dateSelectedToUse = DateTime(
                                      currentDate.year - 543,
                                      currentDate.month,
                                      currentDate.day,
                                      currentDate.hour,
                                      currentDate.minute,
                                    );
                                    widget.onSelected.call(dateSelectedToUse);
                                  }
                                  widget.onSelected.call(dateSelectedToUse);
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text(
                                'ตกลง',
                                style: TextStyle(
                                    fontFamily: 'prompt',
                                    color: Color.fromARGB(255, 12, 54, 151),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: widget.mode,
                      use24hFormat: true,
                      initialDateTime: dateSelected ?? currentDate,
                      dateOrder: DatePickerDateOrder.dmy,
                      onDateTimeChanged: (DateTime newDateTime) {
                        tempDateSelected = newDateTime;
                      },
                    ),
                  ),
                ],
              ),
              context),
        ),
        Visibility(
          visible: widget.validate,
          child: Container(
              color: Color(0xffEFF3F8),
              padding: EdgeInsets.only(left: 10, top: 1),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'กรุณากรอกข้อมูล',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                        fontSize: 11),
                  ))),
        )
      ],
    );
  }
}
