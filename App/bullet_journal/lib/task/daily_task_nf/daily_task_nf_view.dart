// @dart=2.9
import 'dart:ui';
import 'package:bullet_journal/model/calendar/calender.dart';
import 'package:bullet_journal/task/daily_task_nf/daily_task.dart';
import 'package:bullet_journal/task/daily_task_nf/daily_task_nf_viewmodel.dart';
import 'package:bullet_journal/model/calendar/time.dart';
import 'package:bullet_journal/task/daily_task_nf/monthly_task.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:percent_indicator/percent_indicator.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:bullet_journal/widget/calendar/calendar_widget.dart';

class DailyTaskNewsFeedView extends StatefulWidget {
  @override
  _DailyTaskNewsFeedViewState createState() => _DailyTaskNewsFeedViewState();
}

// Calender calender = Calender();
DailyTaskNewsFeedViewModel dailyTaskNewsFeedViewModel;
// String _monthSelected;
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
List<String> _weekdays = ['Mon', 'Tue', 'Wes', 'Thu', 'Fri', 'Sat', 'Sun'];

int _monthSelected = DateTime.now().month - 1;
DateTime _dayNow = DateTime.now();
DateTime _dateSelected;
Color _dateBackgroundColor = Colors.transparent;
Color _dateTextColor = Colors.black;

class _DailyTaskNewsFeedViewState extends State<DailyTaskNewsFeedView> {
  // List<String> list = [];
  @override
  void initState() {
    super.initState();
    dailyTaskNewsFeedViewModel = DailyTaskNewsFeedViewModel();
  }

  @override
  Widget build(BuildContext context) {
    // calender.getStringMonth.forEach((element) {
    //   print(element);
    // });
    _size = MediaQuery.of(context).size;
    return NestedScrollView(
      physics: NeverScrollableScrollPhysics(),
      headerSliverBuilder: (context, value) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  automaticallyImplyLeading: true,
                  backgroundColor: Colors.transparent,
                  floating: true,
                  pinned: false,
                  snap: true,
                  elevation: 0,
                  expandedHeight: MediaQuery.of(context).size.height * 0.51,
                  flexibleSpace: FlexibleSpaceBar(
                    background: SafeArea(
                      // child: TableComplexExample(),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  child: Container(
                                    width: _size.width,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Colors.red[400],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    // child:
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 30, top: 20),
                                  child: StreamBuilder<Year>(
                                      stream: dailyTaskNewsFeedViewModel
                                          .getCalendarController,
                                      initialData: Year(),
                                      builder: (context, year) {
                                        return Text(
                                          year.data.getYear.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }),
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: StreamBuilder<Year>(
                                        initialData: Year(),
                                        stream: dailyTaskNewsFeedViewModel
                                            .getCalendarController,
                                        builder: (context, year) {
                                          return FocusedMenuHolder(
                                              openWithTap: true,
                                              blurSize: 0,
                                              menuOffset: 0,
                                              menuWidth: _size.width / 4,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, bottom: 10),
                                                  child: Text(
                                                    year
                                                        .data
                                                        .getMonth[
                                                            _monthSelected]
                                                        .getStringMonth
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )),
                                              onPressed: () {},
                                              menuItems:
                                                  dailyTaskNewsFeedViewModel
                                                      .getMonthList
                                                      .asMap()
                                                      .entries
                                                      .map((e) => _monthItem(e))
                                                      .toList());
                                          // Text(snapshot
                                          //     .data.getMonth[0].getStringMonth);
                                        })),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
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
      body: SafeArea(child: DailyTask()),
    );
  }

  Widget buildGridCalender() {
    return Container(
      height: _size.width * 0.95,
      width: _size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        // color: Colors.black,
        border: Border.all(color: Colors.red[400], width: 2),
      ),
      padding: EdgeInsets.all(5),
      child: Align(
        alignment: Alignment.center,
        child: StreamBuilder<List<DayCalendar>>(
            initialData: [],
            stream: dailyTaskNewsFeedViewModel.getDayController,
            builder: (context, days) {
              return GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: days.data.length + 7,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    // DateTime dt;
                    // if (index > 7) {
                    //   print('498> now ' + _dateSelected.toString());
                    //   _dateSelected = DateTime(
                    //       _dayNow.year,
                    //       days.data[index - 7].getMonth,
                    //       days.data[index - 7].getDay);
                    // }
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.circle,
                                // color: index <= _weekDayOfMonth
                                //     ? Colors.transparent
                                //     : Colors.white.withOpacity(0.2),
                                // color: (index > 7 && _dateSelected == dt)
                                color: _dateBackgroundColor
                                // color: _dayNow == _dateSelected
                                //     ? Colors.red
                                //     : Colors.transparent
                                ),
                            alignment: Alignment.center,
                            // && index + 1 % 7 <= _daysInMonth
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            index < 7
                                ? _weekdays[index]
                                : days.data[index - 7].getDay.toString(),
                            style: TextStyle(
                                // color: index == 20
                                //     ? Colors.white
                                //     : index < 7
                                //         ? Colors.red[500]
                                //         : _monthSelected ==
                                //                 days.data[index - 7].getMonth
                                //             ? Colors.black.withOpacity(0.7)
                                //             : Colors.black.withOpacity(0.2),
                                color: _dateTextColor,
                                fontWeight: index < 7
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ),
                      ],
                    );
                  });
            }),
      ),
    );
  }

  FocusedMenuItem _monthItem(MapEntry<int, Month> e) {
    return FocusedMenuItem(
        onPressed: () {
          dailyTaskNewsFeedViewModel.setDayInMonth(e.value.getMonth);
          setState(() {
            _monthSelected = e.key;
          });
          //
          // dailyTaskNewsFeedViewModel.
        },
        title: Text(e.value.getStringMonth));
  }
}
// Container(
//                       height: 250,
//                       child: Stack(children: [
//                         Container(
//                           height: 250,
//                           decoration: BoxDecoration(
//                               color: Colors.black,
//                               // color: 100 * (index % 9) == 0
//                               //     ? Colors.pink[50]
//                               //     : Colors.pink[100 * (index % 9)],
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     spreadRadius: 5,
//                                     blurRadius: 7,
//                                     offset: Offset(0, 3))
//                               ]),
//                           // child:
//                         ),
//                         Positioned(
//                           left: index % 2 == 0 ? 0 : null,
//                           right: index % 2 != 0 ? 0 : null,
//                           child: Container(
//                             width: 150,
//                             height: 250,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: index % 2 == 0
//                                     ? BorderRadius.only(
//                                         topLeft: Radius.circular(10),
//                                         bottomLeft: Radius.circular(10))
//                                     : BorderRadius.only(
//                                         topRight: Radius.circular(10),
//                                         bottomRight: Radius.circular(10))),
//                           ),
//                         ),
//                         Positioned(
//                             left: index % 2 == 0 ? 0 : null,
//                             right: index % 2 != 0 ? 0 : null,
//                             child: Container(
//                               width: 150,
//                               height: 200,
//                               child: Column(
//                                 children: [
//                                   SizedBox(
//                                     height: 70,
//                                   ),
//                                   Text(
//                                     '09',
//                                     style: TextStyle(fontSize: 50),
//                                   ),
//                                   Text(
//                                     '09/2021',
//                                     style: TextStyle(fontSize: 20),
//                                   )
//                                 ],
//                               ),
//                             )),
//                         Positioned(
//                             right: index % 2 == 0 ? 0 : null,
//                             left: index % 2 != 0 ? 0 : null,
//                             child: Container(
//                               width: MediaQuery.of(context).size.width - 170,
//                               height: 250,
//                               child: ListView.builder(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemCount: 4,
//                                 itemBuilder: (context, index) {
//                                   return Row(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(20),
//                                         child: Stack(
//                                           children: [
//                                             Container(
//                                               height: 20,
//                                               width: 20,
//                                               decoration: BoxDecoration(
//                                                   color: Colors.yellow[800]
//                                                       .withOpacity(0.5),
//                                                   shape: BoxShape.circle),
//                                             ),
//                                             Positioned(
//                                               top: 5,
//                                               left: 5,
//                                               child: Container(
//                                                 height: 10,
//                                                 width: 10,
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.yellow[800],
//                                                     shape: BoxShape.circle),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Text(
//                                         '5:00 ',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Text(
//                                         'Chạy bộ',
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 16),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                             )),
//                       ]),
//                     ),
