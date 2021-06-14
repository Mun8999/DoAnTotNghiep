// @dart=2.9
import 'package:bullet_journal/database/db_dailytask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      margin: EdgeInsets.all(_size.width * 0.02),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_size.width * 0.05),
              topRight: Radius.circular(_size.width * 0.1),
              bottomLeft: Radius.circular(_size.width * 0.05),
              bottomRight: Radius.circular(_size.width * 0.05)),
          color: Colors.orange[100]),
      child: SingleChildScrollView(
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
            Container(
                alignment: Alignment.topLeft,
                height: _size.height * 0.75,
                width: _size.width * 0.8,
                child: ValueListenableBuilder(
                  valueListenable: _dailyTaskBox.listenable(),
                  builder: (context, Box<DailyTaskDB> dailyTask, child) {
                    return ListView.separated(
                      /// de o day de khong scroll theo cai nay
                      // physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: _size.width * 0.02,
                                right: _size.width * 0.02),
                            child: Container(
                              height: _size.width * 0.2,
                              width: _size.width * 0.6,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(_size.width * 0.01),
                                      topRight:
                                          Radius.circular(_size.width * 0.05),
                                      bottomLeft:
                                          Radius.circular(_size.width * 0.05),
                                      bottomRight:
                                          Radius.circular(_size.width * 0.05))),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(_size.width * 0.03),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(_tasks[index],
                                                style: GoogleFonts.muli(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  '5:00',
                                                  style: GoogleFonts.muli(
                                                      fontSize: 13),
                                                ),
                                                Text(
                                                  '6:00',
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
                                            value: false,
                                            onChanged: (value) {},
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
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
