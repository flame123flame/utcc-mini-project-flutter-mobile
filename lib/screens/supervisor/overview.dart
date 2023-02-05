import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../constants/constant_color.dart';
import '../../utils/time_format.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  int indexActiveTabDay = DateTime.now().day - 1;
  int indexActiveTabMounth = DateTime.now().month - 1;
  int indexActiveTabYear = 10;
  @override
  void initState() {
    super.initState();
  }

  List<int> getYears(int year) {
    int currentYear = DateTime.now().year;

    List<int> yearsTilPresent = [];

    while (year <= currentYear) {
      yearsTilPresent.add(year);
      year++;
    }

    return yearsTilPresent;
  }

  int getDay() {
    int daysInMonth(DateTime date) => DateTimeRange(
            start: DateTime(date.year, date.month, 1),
            end: DateTime(date.year, date.month + 1))
        .duration
        .inDays;
    return daysInMonth(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: MaterialApp(
        home: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.start,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 23,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: colorBar,
            bottom: TabBar(
              indicatorPadding: EdgeInsets.zero,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              splashBorderRadius: BorderRadius.circular(10),
              onTap: (index) {
                // Tab index when user select it, it start from zero
              },
              tabs: [
                Tab(
                    child: Text('วัน',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'prompt',
                        ))),
                Tab(
                    child: Text('เดือน',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'prompt',
                        ))),
                Tab(
                    child: Text('ปี',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'prompt',
                        ))),
              ],
            ),
            title: Text(
              'ภาพรวม',
              style: TextStyle(
                fontFamily: 'prompt',
              ),
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              WidgetTabDay(),
              WidgetTabMounth(),
              WidgetTabYear(),
            ],
          ),
        ),
      ),
    );
  }

  Widget WidgetTabDay() {
    return Column(
      children: [
        Container(
          height: 60,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Row(
                children: List.generate(getDay(), (index) {
                  return InkWell(
                    onTap: () => {
                      setState(() {
                        indexActiveTabDay = index;
                      })
                    },
                    child: Container(
                      height: 35,
                      width: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: indexActiveTabDay == index
                              ? colorBar
                              : Color.fromARGB(255, 223, 223, 222)),
                      margin: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                            " " +
                                int.parse((index + 1).toString()).toString() +
                                " ",
                            style: TextStyle(
                              fontSize: 17,
                              color: indexActiveTabDay == index
                                  ? Colors.white
                                  : Color.fromARGB(255, 38, 38, 38),
                              fontFamily: 'prompt',
                            )),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        Container(
          child: Text('dwqdqw'),
        )
      ],
    );
  }

  Widget WidgetTabMounth() {
    return Column(
      children: [
        Container(
          height: 60,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Row(
                children: List.generate(Time().listMonthThai.length, (index) {
                  return InkWell(
                    onTap: () => {
                      setState(() {
                        indexActiveTabMounth = index;
                      })
                    },
                    child: Container(
                      height: 35,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: indexActiveTabMounth == index
                              ? colorBar
                              : Color.fromARGB(255, 223, 223, 222)),
                      margin: EdgeInsets.all(5),
                      child: Center(
                        child: Text(" " + Time().listMonthThai[index] + " ",
                            style: TextStyle(
                              fontSize: 17,
                              color: indexActiveTabMounth == index
                                  ? Colors.white
                                  : Color.fromARGB(255, 38, 38, 38),
                              fontFamily: 'prompt',
                            )),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        Container(
          child: Text('dwqdqw'),
        )
      ],
    );
  }

  Widget WidgetTabYear() {
    return Column(
      children: [
        Container(
          height: 60,
          width: double.infinity,
          child: ListView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Row(
                children: List.generate(
                    getYears(DateTime.now().year - 10).length, (index) {
                  return InkWell(
                    onTap: () => {
                      setState(() {
                        indexActiveTabYear = index;
                      })
                    },
                    child: Container(
                      height: 35,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: indexActiveTabYear == index
                              ? colorBar
                              : Color.fromARGB(255, 223, 223, 222)),
                      margin: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                            " " +
                                getYears(DateTime.now().year - 10)[index]
                                    .toString() +
                                " ",
                            style: TextStyle(
                              fontSize: 17,
                              color: indexActiveTabYear == index
                                  ? Colors.white
                                  : Color.fromARGB(255, 38, 38, 38),
                              fontFamily: 'prompt',
                            )),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        Container(
          child: Text('dwqdqw'),
        )
      ],
    );
  }
}
