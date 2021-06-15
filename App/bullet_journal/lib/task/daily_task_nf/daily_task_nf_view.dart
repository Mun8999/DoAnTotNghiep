// @dart=2.9
import 'dart:ui';
import 'package:bullet_journal/model/calendar/calender.dart';
import 'package:bullet_journal/task/daily_task_nf/daily_task_nf_viewmodel.dart';
import 'package:bullet_journal/task/daily_task_nf/daily_task_widget.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
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
    return SafeArea(child: DailyTask());
    // NestedScrollView(
    //   physics: NeverScrollableScrollPhysics(),
    //   // headerSliverBuilder: (context, value) {
    //   //   return [
    //   //     SliverOverlapAbsorber(
    //   //       handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
    //   //       sliver: SliverSafeArea(
    //   //           top: false,
    //   //           sliver: SliverAppBar(
    //   //             automaticallyImplyLeading: true,
    //   //             backgroundColor: Colors.transparent,
    //   //             floating: true,
    //   //             pinned: false,
    //   //             snap: true,
    //   //             elevation: 0,
    //   //             // expandedHeight: MediaQuery.of(context).size.height * 0.51,
    //   //             // flexibleSpace: FlexibleSpaceBar(
    //   //             //   background: SafeArea(
    //   //             //     // child: TableComplexExample(),
    //   //             //     child: SingleChildScrollView(
    //   //             //       physics: NeverScrollableScrollPhysics(),
    //   //             //       child: Column(
    //   //             //         children: [

    //   //             //         ],
    //   //             //       ),
    //   //             //     ),
    //   //             //   ),
    //   //             // ),
    //   //           )),
    //   //     )
    //   //   ];
    //   // },
    //   body: ,
    // );
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
