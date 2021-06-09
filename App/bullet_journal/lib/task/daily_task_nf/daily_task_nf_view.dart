// @dart=2.9
import 'dart:ui';
import 'package:bullet_journal/task/daily_task_nf/daily_task_nf_viewmodel.dart';
import 'package:bullet_journal/model/time.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
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
List<Color> _colors = [
  Colors.yellow[100],
  Colors.red[100],
  Colors.pink[100],
  Colors.teal[100]
];
List<Color> _boderColor = [
  Colors.yellow[300],
  Colors.red[300],
  Colors.pink[300],
  Colors.teal[300]
];
List<String> _tasks = ['Tập thể dục', 'Đọc sách', 'Nghe nhạc', 'Làm việc'];
List<CircularStackEntry> data = <CircularStackEntry>[
  new CircularStackEntry(
    <CircularSegmentEntry>[
      new CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
      new CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
      new CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
      new CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
    ],
    rankKey: 'Quarterly Profits',
  ),
];
final GlobalKey<AnimatedCircularChartState> _chartKey =
    new GlobalKey<AnimatedCircularChartState>();
int _daysInMonth = 0;
int _weekDayOfMonth = 0;
int _dayIndex = 1;
// DateTime _selectedDay, _focusedDay;
// CalendarFormat _calendarFormat;

class _DailyTaskNewsFeedViewState extends State<DailyTaskNewsFeedView> {
  // List<String> list = [];
  @override
  void initState() {
    super.initState();
    dailyTaskNewsFeedViewModel = DailyTaskNewsFeedViewModel();
    // _monthSelected = dailyTaskNewsFeedViewModel.getStringMonths[0];
    _daysInMonth = dailyTaskNewsFeedViewModel.getDayData(2021, 1);
    DateTime dateTime = DateTime(2021, 1, 1);
    _weekDayOfMonth = MyDateTime(dateTime).getDate.getWeekday * 2;
    // _selectedDay = DateTime.now();
    // _focusedDay = DateTime.now();
    // _calendarFormat = CalendarFormat.month;
    print('\ndaysInMonth ' + _daysInMonth.toString());
    print('\nweekDayOfMonth ' + _weekDayOfMonth.toString());
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
                  expandedHeight: MediaQuery.of(context).size.height * 0.45,
                  flexibleSpace: FlexibleSpaceBar(
                    background: SafeArea(
                      // child: TableComplexExample(),
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(10),
                            //     child: Text(
                            //       '2021',
                            //       style: TextStyle(
                            //           fontSize: 20,
                            //           fontWeight: FontWeight.bold),
                            //     ),
                            //   ),
                            // ),
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
                                Align(
                                  alignment: Alignment.center,
                                  child: FocusedMenuHolder(
                                      openWithTap: true,
                                      blurSize: 0,
                                      menuOffset: 0,
                                      menuWidth: _size.width / 4,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 10),
                                        child: StreamBuilder<String>(
                                            initialData:
                                                dailyTaskNewsFeedViewModel
                                                    .getStringMonths[0],
                                            stream: dailyTaskNewsFeedViewModel
                                                .getMonthSelectedStream,
                                            builder: (context, month) {
                                              return Text(
                                                month.data,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              );
                                            }),
                                      ),
                                      onPressed: () {},
                                      menuItems: dailyTaskNewsFeedViewModel
                                          .getStringMonths
                                          .asMap()
                                          .entries
                                          .map((e) => _monthItem(e))
                                          .toList()),
                                ),
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
      body: SafeArea(
        child: Container(
            height: _size.height * 0.5,
            color: Colors.white,
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                ListView.separated(
                  /// de o day de khong scroll theo cai nay
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _colors.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: _size.width * 0.2,
                          width: _size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: _boderColor[index],
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              Container(
                                width: _size.width * 0.25 * (index + 1),
                                decoration: BoxDecoration(
                                    color: _colors[index],
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    (25 * (index + 1)).toString() + '%',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    _tasks[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                    height: _size.width * 0.05,
                                    width: _size.width * 0.3,
                                    margin: EdgeInsets.all(5),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, index) =>
                                          Icon(Icons.check),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                ),
                // Container(
                //   child: AnimatedCircularChart(
                //     key: _chartKey,
                //     size: Size(_size.width, _size.width),
                //     initialChartData: <CircularStackEntry>[
                //       new CircularStackEntry(
                //         <CircularSegmentEntry>[
                //           new CircularSegmentEntry(
                //             33.33,
                //             Colors.blue[400],
                //             rankKey: 'completed',
                //           ),
                //           new CircularSegmentEntry(
                //             66.67,
                //             Colors.blueGrey[600],
                //             rankKey: 'remaining',
                //           ),
                //         ],
                //         rankKey: 'progress',
                //       ),
                //     ],
                //     chartType: CircularChartType.Radial,
                //     edgeStyle: SegmentEdgeStyle.round,
                //     percentageValues: true,
                //   ),
                // )
              ],
            )),
      ),
    );
  }

  Widget buildGridCalender() {
    return Container(
      height: _size.width * 0.82,
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
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 42,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, crossAxisSpacing: 5, mainAxisSpacing: 5),
            itemBuilder: (context, index) {
              if (_dayIndex > 31) {
                _dayIndex = 1;
              }
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
                          color: index == 20
                              ? Colors.red[400]
                              : Colors.transparent),
                      alignment: Alignment.center,
                      // && index + 1 % 7 <= _daysInMonth
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      index < 7
                          ? _weekdays[index]
                          : ((index <= _weekDayOfMonth)
                              ? '0'
                              : (_dayIndex++).toString()),
                      style: TextStyle(
                          color: index == 20
                              ? Colors.white
                              : index < 7
                                  ? Colors.red[500]
                                  : index <= _weekDayOfMonth
                                      ? Colors.black.withOpacity(0.2)
                                      : Colors.black.withOpacity(0.7),
                          fontWeight:
                              index < 7 ? FontWeight.bold : FontWeight.normal),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  FocusedMenuItem _monthItem(MapEntry<int, String> e) {
    return FocusedMenuItem(
        onPressed: () {
          dailyTaskNewsFeedViewModel.setMonthSelected(e.value);
          dailyTaskNewsFeedViewModel.getDayData(2021, 1);
        },
        title: Text(e.value));
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