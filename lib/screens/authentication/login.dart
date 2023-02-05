import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:utcc_mobile/constants/constant_font_size.dart';
import 'package:utcc_mobile/screens/authentication/pin.dart';
import 'package:utcc_mobile/screens/navigation_menu_bar.dart';

import '../../constants/constant_color.dart';
import '../../model/users_login.dart';
import '../../provider/user_login_provider.dart';
import '../../service/api_service.dart';
import '../../utils/size_config.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static FlutterSecureStorage storageToken = new FlutterSecureStorage();

  UserLoginProvider? userLoginProvider;
  bool isOpen = false;
  bool isClick = true;
  PanelController _panelController = new PanelController();
  String username = '';
  String password = '';
  bool validateUsername = false;
  bool validatePassword = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool focusUsername = false;
  bool focusPassword = false;
  bool _passwordVisible = false;
  String? token;
  String? getUserName;
  String? getPassword;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      userLoginProvider =
          Provider.of<UserLoginProvider>(context, listen: false);
      token = await storageToken.read(key: 'jwttoken');
      if (null != token) {
        getUserName = await storageToken.read(key: 'username');
        getPassword = await storageToken.read(key: 'password');
        if (getUserName != null && getPassword != null) {
          usernameController.text = getUserName ?? '';
          passwordController.text = getPassword ?? '';
          OnLoginPin();
          GotoPin();
        }
      } else {}
    });
    super.initState();
    initialize();
  }

  checkLogin() async {
    final accessToken = await storageToken.read(key: 'jwttoken');
    if (accessToken != null) {
      GotoPin();
    }
  }

  ValidateFrom() async {
    if (usernameController.text.trim().isEmpty) {
      setState(() {
        validateUsername = true;
      });
      return;
    } else {
      setState(() {
        validateUsername = false;
      });
    }
    if (passwordController.text.trim().isEmpty) {
      setState(() {
        validatePassword = true;
      });
      return;
    } else {
      setState(() {
        validatePassword = false;
      });
    }
    OnLogin();
  }

  OnLoginPin() async {
    try {
      EasyLoading.show(
        indicator: Image.asset(
          'assets/images/Loading_2.gif',
          height: 70,
        ),
      );
      await Future.delayed(Duration(seconds: 1));
      UserLogin temp = await ApiService.Login(
          usernameController.text, passwordController.text);
      await userLoginProvider?.setUserLogin(temp);
      EasyLoading.dismiss();
      // GotoHome();
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      _delete(context, 'username หรือ password ไม่ถูกต้อง!');
    }
  }

  OnLogin() async {
    try {
      EasyLoading.show(
        indicator: Image.asset(
          'assets/images/Loading_2.gif',
          height: 70,
        ),
      );
      await Future.delayed(Duration(seconds: 1));
      UserLogin temp = await ApiService.Login(
          usernameController.text, passwordController.text);
      await userLoginProvider?.setUserLogin(temp);
      EasyLoading.dismiss();
      GotoPin();
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      _delete(context, 'username หรือ password ไม่ถูกต้อง!');
    }
  }

  GotoPin() {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        settings: RouteSettings(name: "/pin"),
        builder: (BuildContext context) {
          return Pin();
        },
      ),
      (_) => false,
    );
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

  void initialize() async {
    await Future.delayed(Duration(seconds: 4));
    FlutterNativeSplash.remove();
  }

  void _delete(BuildContext context, String text) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              'แจ้งเตือนเข้าสู่ระบบ',
              style: TextStyle(
                  color: Color.fromARGB(255, 65, 57, 52),
                  fontFamily: 'prompt',
                  fontSize: 21),
            ),
            content: Text(
              text,
              style: TextStyle(
                  color: Color.fromARGB(255, 55, 48, 43),
                  fontFamily: 'prompt',
                  fontSize: 17),
            ),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    isClick = true;
                    Navigator.of(context).pop();
                  });
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
              // The "No" button
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SlidingUpPanel(
            defaultPanelState: PanelState.CLOSED,
            isDraggable: false,
            controller: _panelController,
            onPanelOpened: () {
              setState(() {
                isOpen = false;
              });
            },
            onPanelClosed: () {
              setState(() {
                FocusScope.of(context).requestFocus(FocusNode());
                isOpen = false;
              });
            },
            maxHeight: 620,
            backdropEnabled: true,
            color: Colors.transparent,
            panel: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        BarIndicatorColor(),
                        Column(children: [
                          SizedBox(
                            height: 17,
                          ),
                          Text(
                            "ระบบบัตรโดยสารรถเมล์อิเล็กทรอนิกส์",
                            style: TextStyle(
                                color: colorBar,
                                fontSize: 21,
                                fontWeight: FontWeight.w700),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              "ยินดีต้อนรับเจ้าหน้าที่ ขสมก.",
                              style: TextStyle(color: colorBar, fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 30, right: 30, top: 22, bottom: 10),
                            child: Column(
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 7),
                                        child: Text(
                                          'ผู้ใช้งาน',
                                          style: TextStyle(
                                              color: colorBar,
                                              fontSize: fontLableInput,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                          width: double.infinity,
                                          height: 42,
                                          padding: EdgeInsets.only(
                                              left: 5,
                                              right: 1,
                                              top: 12,
                                              bottom: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              border: Border.all(
                                                  color: focusUsername
                                                      ? colorBar
                                                      : validateUsername
                                                          ? Colors.red
                                                          : Color.fromARGB(255,
                                                              221, 219, 218))),
                                          child: Focus(
                                            onFocusChange: (hasFocus) {
                                              setState(() {
                                                focusUsername = hasFocus;
                                              });
                                              if (usernameController.text
                                                  .trim()
                                                  .isEmpty) {
                                                setState(() {
                                                  validateUsername = true;
                                                });
                                                return;
                                              } else {
                                                setState(() {
                                                  validateUsername = false;
                                                });
                                              }
                                            },
                                            child: TextFormField(
                                              scrollPadding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                          .viewInsets
                                                          .bottom +
                                                      20),
                                              textInputAction:
                                                  TextInputAction.next,
                                              controller: usernameController,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 7),
                                        child: Text(
                                          'รหัสผ่าน',
                                          style: TextStyle(
                                              color: colorBar,
                                              fontSize: fontLableInput,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 42,
                                        padding: EdgeInsets.only(
                                            left: 5, right: 1, bottom: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            border: Border.all(
                                                color: focusPassword
                                                    ? colorBar
                                                    : validatePassword
                                                        ? Colors.red
                                                        : Color.fromARGB(255,
                                                            221, 219, 218))),
                                        child: Focus(
                                            onFocusChange: (hasFocus) {
                                              setState(() {
                                                focusPassword = hasFocus;
                                              });
                                              if (passwordController.text
                                                  .trim()
                                                  .isEmpty) {
                                                setState(() {
                                                  validatePassword = true;
                                                });
                                                return;
                                              } else {
                                                setState(() {
                                                  validatePassword = false;
                                                });
                                              }
                                            },
                                            child: TextFormField(
                                              scrollPadding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                          .viewInsets
                                                          .bottom +
                                                      100),
                                              textInputAction:
                                                  TextInputAction.done,
                                              controller: passwordController,
                                              obscureText: !_passwordVisible,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    _passwordVisible
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: colorBar,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _passwordVisible =
                                                          !_passwordVisible;
                                                    });
                                                  },
                                                ),
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      'ลืมรหัสผ่าน ?',
                                      style: TextStyle(
                                          color: colorBar,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Material(
                                    color: colorBar,
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: InkWell(
                                      onTap: () => {
                                        if (isClick)
                                          {isClick = false, ValidateFrom()}
                                      },
                                      child: Container(
                                        height: 40.0,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'เข้าสู่ระบบ',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom))
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            collapsed: InkWell(
              onTap: () {
                _panelController.open();
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromARGB(255, 25, 25, 25),
                      colorBar,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(1),
                    topRight: Radius.circular(1),
                  ),
                ),
                child: Column(
                  children: [
                    BarIndicator(),
                    Center(
                      child: Text(
                        "ลงชื่อเข้าใช้ระบบ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Stack(
              children: [
                Image(
                  image: AssetImage("assets/images/splash.jpeg"),
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Center(
                          child: Container(
                        padding: EdgeInsets.only(top: 1.2, bottom: 1.3),
                        margin: EdgeInsets.only(left: 7, right: 7),
                        child: SvgPicture.asset(
                          'assets/images/Logo1.svg',
                          width: 170,
                        ),
                      )),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 12, left: 18, right: 20, bottom: 13),
                      margin: EdgeInsets.only(
                        top: 20,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color.fromRGBO(255, 255, 255, 0.7)),
                      child: Text(
                        'ระบบบัตรโดยสารรถเมล์อิเล็กทรอนิกส์',
                        style: TextStyle(
                            color: Color.fromARGB(255, 14, 14, 130),
                            fontSize: 18.3),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class BarIndicatorColor extends StatelessWidget {
  const BarIndicatorColor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        width: 70,
        height: 5,
        decoration: BoxDecoration(
          color: colorBar,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}

class BarIndicator extends StatelessWidget {
  const BarIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        width: 70,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
