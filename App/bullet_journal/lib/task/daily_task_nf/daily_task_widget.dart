// @dart=2.9
import 'package:bullet_journal/database/db_dailytask.dart';
import 'package:bullet_journal/model/calendar/calender.dart';
import 'package:bullet_journal/task/daily_task_nf/daily_task_nf_viewmodel.dart';
import 'package:bullet_journal/task/daily_task_nf/daily_task_widget_model.dart';
import 'package:bullet_journal/widget/calendar/calendar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

/// nhớ add thư viện này dô dùm cái mẹ

class DailyTask extends StatefulWidget {
  const DailyTask({Key key}) : super(key: key);

  @override
  _DailyTaskState createState() => _DailyTaskState();
}

Size _size;
Box<DailyTaskDB> _dailyTaskBox;
DailyTaskWidgetViewModel _dailyTaskWidgetViewModel;
DailyTaskNewsFeedViewModel dailyTaskNewsFeedViewModel;
int _monthSelected = DateTime.now().month - 1;
Color _dateBackgroundColor = Colors.transparent;
Color _dateTextColor = Colors.black;
List<String> _weekdays = ['Mon', 'Tue', 'Wes', 'Thu', 'Fri', 'Sat', 'Sun'];
ScrollController _scrollController;

class _DailyTaskState extends State<DailyTask> {
  @override
  void initState() {
    super.initState();
    _dailyTaskBox = Hive.box<DailyTaskDB>('dailytasks');
    dailyTaskNewsFeedViewModel = DailyTaskNewsFeedViewModel();
    _dailyTaskWidgetViewModel = DailyTaskWidgetViewModel();
    _scrollController = ScrollController();
    // _dailyTaskWidgetViewModel.prepareTask(_dailyTaskBox);
  }

  DailyTaskDB _dailyTaskDB;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: _size.width * 0.02,
                right: _size.width * 0.02,
                left: _size.width * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_size.width * 0.05),
                  topRight: Radius.circular(_size.width * 0.1),
                  bottomLeft: Radius.circular(_size.width * 0.05),
                  bottomRight: Radius.circular(_size.width * 0.1)),
              color: Colors.orange[300],
              // border: Border.all(color: Colors.red[400], width: 2),
            ),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: StreamBuilder<Year>(
                        initialData: Year(),
                        stream:
                            dailyTaskNewsFeedViewModel.getCalendarController,
                        builder: (context, year) {
                          return FocusedMenuHolder(
                              openWithTap: true,
                              blurSize: 0,
                              menuOffset: 0,
                              menuWidth: _size.width / 4,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: _size.width * 0.02),
                                child: Text(
                                  year.data.getMonth[_monthSelected]
                                      .getStringMonth
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              onPressed: () {},
                              menuItems: dailyTaskNewsFeedViewModel.getMonthList
                                  .asMap()
                                  .entries
                                  .map((e) => _monthItem(e))
                                  .toList());
                          // Text(snapshot
                          //     .data.getMonth[0].getStringMonth);
                        })),
                Padding(
                  padding: EdgeInsets.only(
                      left: _size.width * 0.02,
                      right: _size.width * 0.02,
                      bottom: _size.width * 0.02),
                  child: Center(child: buildGridCalender()),
                ),
              ],
            ),
          ),
          Container(
            height: _size.height * 0.8,
            margin: EdgeInsets.all(_size.width * 0.02),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_size.width * 0.05),
                    topRight: Radius.circular(_size.width * 0.1),
                    bottomLeft: Radius.circular(_size.width * 0.05),
                    bottomRight: Radius.circular(_size.width * 0.05)),
                color: Colors.orange[100]),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(_size.width * 0.05),
                      child: Container(
                        height: _size.height * 0.07,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 9,
                              child: Text(
                                'HOẠT ĐỘNG',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: ButtonTheme(
                                minWidth: _size.height * 0.07,
                                height: _size.height * 0.07,
                                child: RaisedButton(
                                  focusElevation: 2,
                                  shape: CircleBorder(),
                                  color: Colors.white,
                                  child: Icon(Icons.add),
                                  elevation: 1,
                                  onPressed: () {},
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _dailyTaskBox.listenable(),
                    builder: (context, Box<DailyTaskDB> dailyTask, child) {
                      return Container(
                        alignment: Alignment.topLeft,
                        height: _size.height * 0.8,
                        width: _size.width * 0.8,
                        child: ListView.separated(
                          /// de o day de khong scroll theo cai nay
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: dailyTask.values.length,
                          itemBuilder: (context, index) {
                            _dailyTaskDB = dailyTask.getAt(index);
                            return Slidable(
                              actionPane: SlidableScrollActionPane(),
                              actionExtentRatio: 1 / 5,
                              actions: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('Cảnh báo',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                          content: const Text(
                                              'Bạn có chắc chắn muốn xóa\nhoạt động này không?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                dailyTask.deleteAt(index);
                                                Navigator.pop(context, 'Có');
                                              },
                                              child: const Text('Có'),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Không'),
                                              child: const Text('Không'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.delete))
                              ],
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: _size.width * 0.02,
                                    right: _size.width * 0.02),
                                child: Container(
                                  height: _size.width * 0.2,
                                  // width: _size.width * 0.6,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              _size.width * 0.01),
                                          topRight: Radius.circular(
                                              _size.width * 0.05),
                                          bottomLeft: Radius.circular(
                                              _size.width * 0.05),
                                          bottomRight: Radius.circular(
                                              _size.width * 0.05))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              _size.width * 0.03),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                    dailyTask
                                                        .getAt(index)
                                                        .dailyTaskContent,
                                                    style: GoogleFonts.muli(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20)),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      dailyTask
                                                              .getAt(index)
                                                              .dailyTaskTimeStart
                                                              .hour
                                                              .toString() +
                                                          ':' +
                                                          dailyTask
                                                              .getAt(index)
                                                              .dailyTaskTimeStart
                                                              .minute
                                                              .toString(),
                                                      style: GoogleFonts.muli(
                                                          fontSize: 13),
                                                    ),
                                                    Text(
                                                      dailyTask
                                                              .getAt(index)
                                                              .dailyTaskTimeEnd
                                                              .hour
                                                              .toString() +
                                                          ':' +
                                                          dailyTask
                                                              .getAt(index)
                                                              .dailyTaskTimeEnd
                                                              .minute
                                                              .toString(),
                                                      style: GoogleFonts.muli(
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Checkbox(
                                                activeColor: Colors.orange[900],
                                                value: dailyTask
                                                    .getAt(index)
                                                    .dailyTaskState,
                                                onChanged: (value) {
                                                  _dailyTaskDB =
                                                      dailyTask.getAt(index);
                                                  _dailyTaskDB.dailyTaskState =
                                                      value;
                                                  dailyTask.putAt(
                                                      index, _dailyTaskDB);
                                                },
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: _size.height * 0.02,
                                              child: Container(
                                                height: _size.height * 0.05,
                                                width: _size.height * 0.05,
                                                child: CircleAvatar(
                                                  child: SvgPicture.asset(
                                                      'assets/icons/emotion/001-unicorn.svg'),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: _size.height * 0.04,
                                              top: _size.height * 0.02,
                                              child: Container(
                                                height: _size.height * 0.05,
                                                width: _size.height * 0.05,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/bg_login_1.jpg'),
                                                        fit: BoxFit.cover)),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Transform.scale(
                                                scale: 0.7,
                                                child: CupertinoSwitch(
                                                  activeColor:
                                                      Colors.orange[900],
                                                  value: dailyTask
                                                      .getAt(index)
                                                      .reminder,
                                                  onChanged: (value) {
                                                    _dailyTaskDB =
                                                        dailyTask.getAt(index);
                                                    _dailyTaskDB.reminder =
                                                        value;
                                                    dailyTask.putAt(
                                                        index, _dailyTaskDB);
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: _size.height * 0.05,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
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

  Widget buildGridCalender() {
    return Container(
      height: _size.width * 0.9,
      width: _size.width,
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
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
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
}
