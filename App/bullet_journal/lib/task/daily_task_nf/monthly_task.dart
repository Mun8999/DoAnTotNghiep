// @dart=2.9
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MonthlyTask extends StatefulWidget {
  const MonthlyTask({Key key}) : super(key: key);

  @override
  _MonthlyTaskState createState() => _MonthlyTaskState();
}

Size _size;
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
DateTime _dateSelected = DateTime.now();

class _MonthlyTaskState extends State<MonthlyTask> {
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Container(
        height: _size.height,
        width: _size.width,
        color: Colors.white,
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _size.height * 0.45,
                child: ListView.separated(
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
              ),
              Container(
                height: _size.width * 0.7,
                width: _size.width * 0.7,
                child: Stack(
                  children: [
                    // CircularPercentIndicator(
                    //   radius: _size.width * 0.7,
                    //   lineWidth: 0.5,
                    //   percent: 1.0,
                    //   // center: new Text("100%"),
                    //   progressColor: Colors.black,
                    // ),
                    CircularPercentIndicator(
                      animation: true,
                      animationDuration: 3000,
                      circularStrokeCap: CircularStrokeCap.round,
                      radius: _size.width * 0.7,
                      lineWidth: 10,
                      animateFromLastPercent: true,
                      percent: 0.7,
                      // center: new Text("70%"),
                      progressColor: Colors.red[900],
                      backgroundWidth: 3,
                    ),
                    Center(
                      child: CircularPercentIndicator(
                        animation: true,
                        animationDuration: 1000,
                        circularStrokeCap: CircularStrokeCap.round,
                        radius: _size.width * 0.6,
                        lineWidth: 4,
                        animateFromLastPercent: true,
                        percent: 0.25,
                        center: new Text("70%"),
                        progressColor: _boderColor[0],
                        backgroundWidth: 0.5,
                      ),
                    ),
                    Center(
                      child: CircularPercentIndicator(
                        animation: true,
                        animationDuration: 1000,
                        circularStrokeCap: CircularStrokeCap.round,
                        radius: _size.width * 0.55,
                        lineWidth: 4,
                        animateFromLastPercent: true,
                        percent: 0.5,
                        center: new Text("70%"),
                        progressColor: _boderColor[1],
                        backgroundWidth: 1,
                      ),
                    ),
                    Center(
                      child: CircularPercentIndicator(
                        animation: true,
                        animationDuration: 1000,
                        circularStrokeCap: CircularStrokeCap.round,
                        radius: _size.width * 0.5,
                        lineWidth: 4,
                        animateFromLastPercent: true,
                        percent: 0.75,
                        center: new Text("70%"),
                        progressColor: _boderColor[2],
                        backgroundWidth: 0.5,
                      ),
                    ),
                    Center(
                      child: CircularPercentIndicator(
                        animation: true,
                        animationDuration: 1000,
                        circularStrokeCap: CircularStrokeCap.round,
                        radius: _size.width * 0.45,
                        lineWidth: 4,
                        animateFromLastPercent: true,
                        percent: 1,
                        center: new Text("70%"),
                        progressColor: _boderColor[3],
                        backgroundWidth: 1,
                      ),
                    ),
                  ],
                ),
              )
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
          ),
        ));
  }
}
