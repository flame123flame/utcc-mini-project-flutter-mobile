import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../constants/constant_color.dart';
import '../../provider/user_login_provider.dart';
import '../../service/api_service.dart';

class DetailAccount extends StatefulWidget {
  const DetailAccount({Key? key}) : super(key: key);

  @override
  State<DetailAccount> createState() => _DetailAccountState();
}

class _DetailAccountState extends State<DetailAccount> {
  UserLoginProvider? userLoginProvider;

  @override
  void initState() {
    userLoginProvider = Provider.of<UserLoginProvider>(context, listen: false);
    super.initState();
  }

  // getDataDropdownFarmer() async {
  //   try {
  //     User temp = await ApiService.apiGetUserById(11);
  //     if (null != temp) {
  //       List.generate(temp.data!.detail!.length, (index) {
  //         dropdownFarmer.add(
  //           DropdownPicker(
  //             text: '${temp.data!.detail![index].codeDataNameMinor}',
  //             id: temp.data!.detail![index].idMinor,
  //             code: '${temp.data!.detail![index].codeDataTypeMinor}',
  //           ),
  //         );
  //       });
  //     }
  //     return dropdownFarmer;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: colorBar,
        title: const Text('รายละเอียดบัญชี'),
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
      ),
      body: Row(
        children: [
          Consumer<UserLoginProvider>(builder: (context, value, child) {
            return SettingsList(
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
                      leading: null,
                      title: Text(
                        'ชื่อ - นามสกุล',
                        style: TextStyle(fontFamily: 'prompt', fontSize: 14),
                      ),
                      trailing: Text(
                        "${value.getUserLogin.prefix}${value.getUserLogin.firstName} ${value.getUserLogin.lastName}",
                        style: TextStyle(
                            fontFamily: 'prompt',
                            fontSize: 14,
                            color: colorBar),
                      ),
                    ),
                    SettingsTile.navigation(
                      leading: null,
                      title: Text(
                        'ผู้ใช้งาน',
                        style: TextStyle(fontFamily: 'prompt', fontSize: 14),
                      ),
                      trailing: Text(
                        "${value.getUserLogin.username}",
                        style: TextStyle(
                            fontFamily: 'prompt',
                            fontSize: 14,
                            color: colorBar),
                      ),
                    ),
                    SettingsTile.navigation(
                      leading: null,
                      title: Text(
                        'ตำแหน่ง',
                        style: TextStyle(fontFamily: 'prompt', fontSize: 14),
                      ),
                      trailing: Text(
                        "${value.getUserLogin.position}",
                        style: TextStyle(
                            fontFamily: 'prompt',
                            fontSize: 14,
                            color: colorBar),
                      ),
                    ),
                    SettingsTile.navigation(
                      leading: null,
                      title: Text(
                        'เบอร์โทรศัพท์',
                        style: TextStyle(fontFamily: 'prompt', fontSize: 14),
                      ),
                      trailing: Text(
                        "${value.getUserLogin.phoneNumber!} ",
                        style: TextStyle(
                            fontFamily: 'prompt',
                            fontSize: 14,
                            color: colorBar),
                      ),
                    ),
                    SettingsTile.navigation(
                      leading: null,
                      title: Text(
                        'อีเมล',
                        style: TextStyle(fontFamily: 'prompt', fontSize: 14),
                      ),
                      trailing: Text(
                        "${value.getUserLogin.email}",
                        style: TextStyle(
                            fontFamily: 'prompt',
                            fontSize: 14,
                            color: colorBar,
                            overflow: TextOverflow.fade),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
