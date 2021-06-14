// @dart=2.9
import 'package:bullet_journal/model/db_dailytask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DailyTask extends StatefulWidget {
  const DailyTask({Key key}) : super(key: key);

  @override
  _DailyTaskState createState() => _DailyTaskState();
}

Size _size;
List<Color> _colors = [
  Colors.yellow[100],
  Colors.orange[100],
  Colors.red[100],
  Colors.teal[100],
  Colors.blue[100]
];
List<Color> _boderColor = [
  Colors.yellow[300],
  Colors.orange[300],
  Colors.red[300],
  Colors.teal[300],
  Colors.blue[300]
];
List<String> _tasks = [
  'Tập thể dục',
  'Đọc sách',
  'Nghe nhạc',
  'Làm việc',
  'Ngủ trưa',
  'Tập thể dục',
  'Đọc sách',
  'Nghe nhạc',
  'Làm việc',
  'Ngủ trưa'
];
int _colorIndex = -1;
Box<DailyTaskDB> _dailyTaskBox;

class _DailyTaskState extends State<DailyTask> {
  @override
  void initState() {
    super.initState();
    _dailyTaskBox = Hive.box<DailyTaskDB>('dailytasks');
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Thời gian biểu\n14.06.2021',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            ),
            Container(
              height: _size.height * 0.6,
              child: ValueListenableBuilder(
                // valueListenable: _dailyTaskBox,
                builder: (context, Box<DailyTaskDB> value, child) {
                  return ListView.separated(
                    /// de o day de khong scroll theo cai nay
                    // physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      if (_colorIndex == _colors.length - 1) _colorIndex = -1;
                      _colorIndex++;
                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            height: _size.width * 0.1,
                            width: _size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: _boderColor[_colorIndex],
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      width: _size.width * 0.2,
                                      height: _size.width * 0.1,
                                      decoration: BoxDecoration(
                                          color: _colors[_colorIndex],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '5:00',
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        _tasks[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Checkbox(
                                    value: false,
                                    onChanged: (value) {},
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Transform.scale(
                                    scale: 0.7,
                                    child: CupertinoSwitch(
                                      activeColor: Colors.blueAccent,
                                      value: true,
                                      onChanged: (value) {
                                        // setState(() {
                                        //   _switchValue = value;
                                        // });
                                      },
                                    ),
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
                        height: 10,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
