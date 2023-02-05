import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:utcc_mobile/screens/setting/setting.dart';
import 'package:utcc_mobile/screens/users/list_user.dart';
import 'package:utcc_mobile/screens/bus/list_bus.dart';

import '../constants/constant_color.dart';
import '../utils/size_config.dart';
import 'home.dart';

class NavigationMenuBar extends StatefulWidget {
  final String? selectPage;
  const NavigationMenuBar({Key? key, this.selectPage}) : super(key: key);

  @override
  State<NavigationMenuBar> createState() => _NavigationMenuBarState();
}

class _NavigationMenuBarState extends State<NavigationMenuBar> {
  PersistentTabController? _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorSecondary: CupertinoColors.black,
        icon: Icon(CupertinoIcons.home),
        title: ("หน้าหลัก"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
        textStyle: TextStyle(fontSize: 25, color: Colors.amber),
      ),
      PersistentBottomNavBarItem(
        inactiveColorSecondary: CupertinoColors.black,
        icon: Icon(CupertinoIcons.bus),
        title: ("รถเมล์"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
        textStyle: TextStyle(fontSize: 25, color: Colors.amber),
      ),
      PersistentBottomNavBarItem(
        inactiveColorSecondary: CupertinoColors.black,
        icon: Icon(CupertinoIcons.settings_solid),
        title: ("ตั้งค่า"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.white,
        textStyle: TextStyle(fontSize: 25, color: Colors.amber),
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [Home(), ListBus(), Setting()];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      hideNavigationBar: false,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      // floatingActionButton: Icon(CupertinoIcons.add_circled),
      // backgroundColor: Colors.black12,
      decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              colorBar,
              colorBar,
            ],
          )),

      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.once,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 250),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
