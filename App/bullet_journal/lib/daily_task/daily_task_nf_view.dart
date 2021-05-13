// @dart=2.9
import 'dart:ui';

import 'package:bullet_journal/daily_task/daily_task_nf_viewmodel.dart';
import 'package:bullet_journal/diary/diary_edit/diary_edit_view.dart';
import 'package:bullet_journal/model/diary.dart';
import 'package:bullet_journal/model/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyTaskNewsFeedView extends StatefulWidget {
  @override
  _DailyTaskNewsFeedViewState createState() => _DailyTaskNewsFeedViewState();
}

// Calender calender = Calender();
DailyTaskNewsFeedViewModel dailyTaskNewsFeedViewModel;
String _monthSelected;
Size _size;
List<String> images = [
  'assets/images/FB_IMG_1618988919479.jpg',
  'assets/images/FB_IMG_1619003669083.jpg',
  'assets/images/FB_IMG_1619004242859.jpg',
  'assets/images/FB_IMG_1619006556060.jpg',
  'assets/images/FB_IMG_1619006780237.jpg',
  'assets/images/FB_IMG_1619007243993.jpg',
  'assets/images/FB_IMG_1619007315847.jpg',
  'assets/images/FB_IMG_1619032982645.jpg',
  'assets/images/FB_IMG_1619035711744.jpg',
  'assets/images/FB_IMG_1619035803604.jpg',
  'assets/images/FB_IMG_1619036146750.jpg',
  'assets/images/FB_IMG_1619036516420.jpg',
  'assets/images/FB_IMG_1619037184892.jpg',
  'assets/images/FB_IMG_1619088169362.jpg',
  'assets/images/FB_IMG_1619096684228.jpg',
  'assets/images/FB_IMG_1619157271674.jpg'
];
List<String> weekdays = ['Mon', 'Tue', 'Wes', 'Thu', 'Fri', 'Sat', 'Sun'];
int _daysInMonth = 0;
int _weekDayOfMonth = 0;
int _dayIndex = 1;

class _DailyTaskNewsFeedViewState extends State<DailyTaskNewsFeedView> {
  // List<String> list = [];
  @override
  void initState() {
    dailyTaskNewsFeedViewModel = DailyTaskNewsFeedViewModel();
    _monthSelected = dailyTaskNewsFeedViewModel.getStringMonths[0];
    _daysInMonth = dailyTaskNewsFeedViewModel.getDayData(2021, 1);
    DateTime dateTime = DateTime(2021, 1, 1);
    _weekDayOfMonth = MyDateTime(dateTime).getDate.getWeekday * 2;
    print('\ndaysInMonth ' + _daysInMonth.toString());
    print('\nweekDayOfMonth ' + _weekDayOfMonth.toString());
    // list = dailyTaskNewsFeedViewModel.getMonth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // calender.getStringMonth.forEach((element) {
    //   print(element);
    // });
    _size = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, value) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    actions: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search_rounded,
                            color: Colors.black,
                          ))
                    ],
                    floating: true,
                    pinned: true,
                    snap: false,
                    elevation: 0,
                    expandedHeight: MediaQuery.of(context).size.height * 0.53,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SafeArea(
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    '2021',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: Container(
                                      child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                        value: _monthSelected,
                                        items: dailyTaskNewsFeedViewModel
                                            .getStringMonths
                                            .map((String value) =>
                                                DropdownMenuItem<String>(
                                                  value: value.toString(),
                                                  child: new Text(
                                                      value.toString()),
                                                ))
                                            .toList(),
                                        onChanged: (String value) {
                                          setState(() {
                                            _monthSelected = value;
                                          });
                                        },
                                      )),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Center(child: buildGridCalender()),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            )
          ];
        },
        body: Container(
            height: _size.height,
            color: Colors.white,
            child: ListView.separated(
              /// de o day de khong scroll theo cai nay
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 250,
                      child: Stack(children: [
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              // color: 100 * (index % 9) == 0
                              //     ? Colors.pink[50]
                              //     : Colors.pink[100 * (index % 9)],
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3))
                              ]),
                          // child:
                        ),
                        Positioned(
                          left: index % 2 == 0 ? 0 : null,
                          right: index % 2 != 0 ? 0 : null,
                          child: Container(
                            width: 150,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: index % 2 == 0
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))
                                    : BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                          ),
                        ),
                        Positioned(
                            left: index % 2 == 0 ? 0 : null,
                            right: index % 2 != 0 ? 0 : null,
                            child: Container(
                              width: 150,
                              height: 200,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 70,
                                  ),
                                  Text(
                                    '09',
                                    style: TextStyle(fontSize: 50),
                                  ),
                                  Text(
                                    '09/2021',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            )),
                        Positioned(
                            right: index % 2 == 0 ? 0 : null,
                            left: index % 2 != 0 ? 0 : null,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 170,
                              height: 250,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Colors.yellow[800]
                                                      .withOpacity(0.5),
                                                  shape: BoxShape.circle),
                                            ),
                                            Positioned(
                                              top: 5,
                                              left: 5,
                                              child: Container(
                                                height: 10,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow[800],
                                                    shape: BoxShape.circle),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '5:00 ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Chạy bộ',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )),
                      ]),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 30,
                );
              },
            )),
      ),
    );
  }

  Widget buildGridCalender() {
    return Container(
      height: _size.width * 0.82,
      width: _size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black,
          border: Border.all(color: Colors.yellow[900], width: 2),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ]),
      padding: EdgeInsets.all(5),
      child: Align(
        alignment: Alignment.center,
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 42,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, crossAxisSpacing: 5, mainAxisSpacing: 5),
            itemBuilder: (context, index) {
              if (_dayIndex > 31) {
                _dayIndex = 1;
              }
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(
                  //     color: index < 7 ? Colors.transparent : Colors.yellow[900]),
                  color: Colors.black,
                ),
                alignment: Alignment.center,
                // && index + 1 % 7 <= _daysInMonth
                child: Text(
                  index < 7
                      ? weekdays[index]
                      : ((index <= _weekDayOfMonth)
                          ? '0'
                          : (_dayIndex++).toString()),
                  style: TextStyle(
                      color: index < 7
                          ? Colors.yellow[800]
                          : index <= _weekDayOfMonth
                              ? Colors.white.withOpacity(0.3)
                              : Colors.white,
                      fontWeight:
                          index < 7 ? FontWeight.bold : FontWeight.normal),
                ),
              );
            }),
      ),
    );
  }
}
