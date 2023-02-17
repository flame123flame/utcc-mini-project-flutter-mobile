import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../components/popup_bottom.dart';
import '../../constants/constant_color.dart';
import 'fare_deatil.dart';

class FareList extends StatefulWidget {
  const FareList({Key? key}) : super(key: key);

  @override
  State<FareList> createState() => _FareListState();
}

class _FareListState extends State<FareList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        home: Scaffold(
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
              PopupFilterBottom(
                validate: false,
                list: [],
                onSelected: (index, code, value) {},
              ),
              IconButton(
                icon: Icon(Icons.add_outlined),
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
            bottom: TabBar(
              indicatorPadding: EdgeInsets.zero,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              splashBorderRadius: BorderRadius.circular(2),
              onTap: (index) {
                // Tab index when user select it, it start from zero
              },
              tabs: [
                Tab(
                    child: Text('รายการล่าสุด',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'prompt',
                        ))),
                Tab(
                    child: Text('รายการย้อนหลัง',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'prompt',
                        ))),
              ],
            ),
            title: Text(
              'รายการเก็บค่าโดยสาร',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                fontFamily: 'prompt',
              ),
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              InkWell(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: FareDeatil(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    ).then((value) => {});
                  },
                  child: Container(color: Colors.amber, child: Text('data'))),
              Text('data'),
            ],
          ),
        ),
      ),
    );
  }
}
