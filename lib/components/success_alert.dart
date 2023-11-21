import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessAlert {
  void noti(BuildContext context, String text) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              'แก้ไขข้อมูล',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 57, 52),
                  fontFamily: 'prompt',
                  fontWeight: FontWeight.w900,
                  fontSize: 19),
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
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'ตกลง',
                  style: TextStyle(
                    fontFamily: 'prompt',
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 4, 101, 18),
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
}
