import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:utcc_mobile/screens/navigation_menu_bar.dart';

import '../../constants/constant_color.dart';
import '../../model/user.dart';
import '../../provider/user_login_provider.dart';
import '../../service/api_service.dart';
import 'login.dart';
import 'num_pad.dart';

class Pin extends StatefulWidget {
  const Pin({Key? key}) : super(key: key);

  @override
  State<Pin> createState() => _PinState();
}

class _PinState extends State<Pin> {
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();
  UserLoginProvider? userLoginProvider;
  @override
  void initState() {
    userLoginProvider = Provider.of<UserLoginProvider>(context, listen: false);
    super.initState();
    initialize();
  }

  String pinText = 'กรุณากรอกรหัสผ่าน';
  void initialize() async {
    // await getPin("xxxxxx");
    // if (checkStatus == "NOT_SUCCESS") {
    //   setState(() {
    //     pinText = "กรุณาใส่รหัสผ่าน";
    //   });
    // }
    await Future.delayed(Duration(seconds: 4));
    FlutterNativeSplash.remove();
  }

  int length = 6;

  String pinError = '';
  List<String> listCheck = [];
  String checkStatus = ''; // NOT_DATA , NOT_SUCCESS , SUCCESS

  getPin(String pin) async {
    try {
      Response response = await ApiService.apiGetPin(pin);
      checkStatus = response.data['data'];
    } catch (e) {
      print(e.toString());
    }
  }

  setPin(String pin) async {
    EasyLoading.show(
      indicator: Image.asset(
        'assets/images/Loading_2.gif',
        height: 70,
      ),
    );
    await Future.delayed(Duration(seconds: 1));
    try {
      Response response = await ApiService.apiSetPin(pin);
      if (response.statusCode == 200) {
        GotoHome();
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      print(e.toString());
    }
  }

  onChange(String number) async {
    if (number.length == length) {
      await getPin(number.toString());
      print(checkStatus);
      if (checkStatus == "NOT_DATA") {
        setState(() {
          pinText = 'กรุณาตั้งรหัสผ่าน';
        });
        listCheck.add(number.toString());
        if (listCheck.length == 1) {
          setState(() {
            pinText = 'ยืนยันรหัสผ่านอีกครั้ง';
          });
        }
        if (listCheck.length == 2) {
          if (listCheck[0] == listCheck[1]) {
            setPin(listCheck[0]);
          } else if (listCheck[0] != listCheck[1]) {
            listCheck.removeAt(1);
            notificationCustom(context, 'รหัสผ่านไม่ตรงกัน');
          }
        }
      } else if (checkStatus == "NOT_SUCCESS") {
        notificationCustom(context, 'รหัสผ่านของคุณไม่ถูกต้อง');
      } else if (checkStatus == "SUCCESS") {
        EasyLoading.show(
          indicator: Image.asset(
            'assets/images/Loading_2.gif',
            height: 70,
          ),
        );
        await Future.delayed(Duration(seconds: 1));
        GotoHome();
        EasyLoading.dismiss();
      }
    }
  }

  GotoHome() {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        settings: RouteSettings(name: "/MenuBar"),
        builder: (BuildContext context) {
          return NavigationMenuBar();
        },
      ),
      (_) => false,
    );
  }

  void notificationCustom(BuildContext context, String text) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              'แจ้งเตือน!',
              style: TextStyle(
                  color: Color.fromARGB(255, 5, 5, 5),
                  fontFamily: 'prompt',
                  fontWeight: FontWeight.w900,
                  fontSize: 18),
            ),
            content: Text(
              text,
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 57, 52),
                  fontFamily: 'prompt',
                  fontSize: 15),
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
                  'ตกลง',
                  style: TextStyle(
                    fontFamily: 'prompt',
                    fontWeight: FontWeight.w900,
                    color: Colors.red,
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

  logout() async {
    await storageToken.delete(key: 'jwttoken');
    await storageToken.delete(key: 'username');
    await storageToken.delete(key: 'password');

    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Login();
        },
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   // title: Text(pinText),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: Icon(Icons.close),
        //       onPressed: () {
        //         logout();
        //       },
        //     )
        //   ],
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.close),
                iconSize: 30,
                onPressed: () {
                  logout();
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Center(
                        child: Container(
                      padding: EdgeInsets.only(bottom: 1.3),
                      margin: EdgeInsets.only(left: 7, right: 7),
                      child: SvgPicture.asset(
                        'assets/images/Logo1.svg',
                        width: 120,
                      ),
                    )),
                  ),
                  Text(
                    pinText,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Numpad(
                    textError: pinError,
                    length: length,
                    onChange: onChange,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
