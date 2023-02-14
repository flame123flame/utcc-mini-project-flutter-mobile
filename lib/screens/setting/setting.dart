import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:utcc_mobile/constants/constant_color.dart';

import '../../provider/user_login_provider.dart';
import '../authentication/login.dart';
import 'detail_account.dart';
import 'edit_account.dart';
import 'edit_password.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  UserLoginProvider? userLoginProvider;
  static FlutterSecureStorage storage = new FlutterSecureStorage();
  @override
  void initState() {
    userLoginProvider = Provider.of<UserLoginProvider>(context, listen: false);
    super.initState();
  }

  logout() async {
    await storage.delete(key: 'jwttoken');
    await storage.delete(key: 'username');
    await storage.delete(key: 'password');
    userLoginProvider!.clearUserLogin();
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Login();
        },
      ),
      (_) => false,
    );
  }

  bool faceID = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 235, 240, 244),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          flexibleSpace: Container(
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
          ),
          // backgroundColor: colorBar,
          title: const Text(
            'การตั้งค่า',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[],
        ),
      ),
      body: Container(
        color: Colors.amber,
        child: SettingsList(
          platform: DevicePlatform.iOS,
          sections: [
            SettingsSection(
              margin: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              title: Text(
                '',
                style: TextStyle(
                    fontFamily: 'prompt', fontSize: 0, color: Colors.black),
              ),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(
                    Icons.contact_mail,
                    color: colorBar,
                  ),
                  title: Text(
                    'รายละเอียดบัญชี',
                    style: TextStyle(
                      fontFamily: 'prompt',
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                  value: Text(''),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: colorBar,
                    size: 16,
                  ),
                  onPressed: (context) => {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: DetailAccount(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    )
                  },
                ),
                SettingsTile.navigation(
                  leading: Icon(
                    Icons.edit,
                    color: colorBar,
                  ),
                  title: Text(
                    'แก้ไขข้อมูลส่วนตัว',
                    style: TextStyle(
                      fontFamily: 'prompt',
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                  value: Text(''),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: colorBar,
                    size: 16,
                  ),
                  onPressed: (context) => {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: EditAccount(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    )
                  },
                ),
                SettingsTile.navigation(
                  leading: Icon(
                    Icons.lock,
                    color: colorBar,
                  ),
                  title: Text(
                    'เปลี่ยนรหัสผ่าน',
                    style: TextStyle(
                      fontFamily: 'prompt',
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                  value: Text(''),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: colorBar,
                    size: 16,
                  ),
                  onPressed: (context) => {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: EditPassword(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    )
                  },
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {
                    setState(() {
                      faceID = value;
                    });
                  },
                  activeSwitchColor: colorBar,
                  initialValue: faceID,
                  leading: Icon(
                    Icons.touch_app_sharp,
                    color: colorBar,
                  ),
                  title: Text(
                    'เปิดใช้งาน Touch ID/Face ID',
                    style: TextStyle(
                      fontFamily: 'prompt',
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SettingsSection(
              margin: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              title: Text(''),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(
                    Icons.book,
                    color: colorBar,
                  ),
                  title: Text(
                    'ข้อตกลงและเงื่อนไข',
                    style: TextStyle(
                      fontFamily: 'prompt',
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                  value: Text(''),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: colorBar,
                    size: 16,
                  ),
                  onPressed: (context) => {},
                ),
                SettingsTile.navigation(
                  leading: Icon(
                    Icons.library_books_outlined,
                    color: colorBar,
                  ),
                  title: Text(
                    'คู่มือการใช้งาน',
                    style: TextStyle(
                      fontFamily: 'prompt',
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                  value: Text(''),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: colorBar,
                    size: 16,
                  ),
                  onPressed: (context) => {},
                ),
                SettingsTile.navigation(
                  leading: Icon(
                    Icons.contact_page,
                    color: colorBar,
                  ),
                  title: Text(
                    'ติดต่อเรา',
                    style: TextStyle(
                      fontFamily: 'prompt',
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                  value: Text(''),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: colorBar,
                    size: 16,
                  ),
                  onPressed: (context) => {},
                ),
                SettingsTile.navigation(
                  leading: Icon(
                    Icons.verified_user_outlined,
                    color: colorBar,
                  ),
                  title: Text(
                    'เวอร์ชันแอปพลิเคชัน',
                    style: TextStyle(
                      fontFamily: 'prompt',
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Text(
                    '1.0.0',
                    style: TextStyle(
                      fontFamily: 'prompt',
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: colorBar,
                    ),
                  ),
                ),
              ],
            ),
            SettingsSection(
              margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              title: Text(''),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: (context) => {logout()},
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text(
                    'ออกจากระบบ',
                    style: TextStyle(
                        fontFamily: 'prompt',
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: Colors.red),
                  ),
                  trailing: Text(
                    '',
                    style: TextStyle(fontFamily: 'prompt', fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
