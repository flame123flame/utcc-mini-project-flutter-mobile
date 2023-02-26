import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/size_config.dart';

class NotificationCustom {
  static showNotification(
      String text, Color color, IconData? icon, BuildContext context) {
    Flushbar(
        margin: EdgeInsets.all(6.0),
        flushbarPosition: FlushbarPosition.TOP,
        message: text,
        backgroundColor: color,
        flushbarStyle: FlushbarStyle.FLOATING,
        borderRadius: BorderRadius.circular(12),
        icon: Icon(
          icon,
          size: 28.0,
          color: Colors.white,
        ),
        padding: EdgeInsets.only(top: 8, bottom: 8),
        duration: Duration(seconds: 1),
        textDirection: Directionality.of(context),
        isDismissible: false)
      ..show(context);
  }

  void notification(BuildContext context, String textHeader, String text) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              textHeader,
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 57, 52),
                  fontFamily: 'anupark',
                  fontSize: SizeConfig.defaultSize! * 1.9),
            ),
            content: Text(
              text,
              style: TextStyle(
                  color: Color.fromARGB(255, 55, 48, 43),
                  fontFamily: 'anupark',
                  fontSize: SizeConfig.defaultSize! * 1.5),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'ตกลง',
                  style: TextStyle(
                    color: Color(0xff536830),
                  ),
                ),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
            ],
          );
        });
  }
}
