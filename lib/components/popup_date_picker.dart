import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/size_config.dart';
import '../utils/time_format.dart';

class PopupDatePicker extends StatefulWidget {
  final Function(DateTime?) onSelected;
  final CupertinoDatePickerMode mode;
  final String title;
  late bool validate;
  PopupDatePicker(
      {Key? key,
      required this.onSelected,
      this.mode = CupertinoDatePickerMode.date,
      required this.validate,
      this.title = 'กรุณาเลือก'})
      : super(key: key);

  @override
  State<PopupDatePicker> createState() => _PopupDatePickerState();
}

class _PopupDatePickerState extends State<PopupDatePicker> {
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
            ));
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = new DateTime(now.year + 543, now.month, now.day);

    return Column(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(22, 6, 19, 6),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: widget.validate == false
                      ? Color.fromARGB(255, 221, 219, 218)
                      : Colors.red),
              borderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    null != dateSelected
                        ? (CupertinoDatePickerMode.date == widget.mode
                                ? Time()
                                    .thaiDateTextFormat(dateSelected!, false)
                                : DateFormat.Hm().format(dateSelected!))
                            .toString()
                        : CupertinoDatePickerMode.date != widget.mode
                            ? DateFormat.Hm().format(now)
                            : Time().StringCutTimeToGetDate(now.toString()),
                    style: TextStyle(
                        color: widget.validate == false
                            ? Color.fromARGB(204, 23, 23, 23)
                            : Colors.red,
                        fontFamily: 'prompt',
                        fontSize: SizeConfig.defaultSize! * 1.5,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Icon(
                  CupertinoDatePickerMode.date == widget.mode
                      ? Icons.calendar_month
                      : Icons.access_time,
                  color:
                      widget.validate == false ? Color(0xFFD0D5DB) : Colors.red,
                  size: 24.0,
                ),
              ],
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
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
