// @dart=2.9
import 'package:bullet_journal/model/calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DailyNewsFeedView extends StatefulWidget {
  @override
  _DailyNewsFeedViewState createState() => _DailyNewsFeedViewState();
}

Calender calender = Calender();

class _DailyNewsFeedViewState extends State<DailyNewsFeedView> {
  @override
  Widget build(BuildContext context) {
    calender.getStringMonth.forEach((element) {
      print(element);
    });
    return Scaffold(
      body: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, value) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
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
                      expandedHeight: MediaQuery.of(context).size.height * 0.23,
                      flexibleSpace: FlexibleSpaceBar(
                        background: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    '2021',
                                    style: TextStyle(
                                        color: Colors.yellow[800],
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(5),
                              //     child: Text(
                              //       calender.getStringAbbreviationMonth[11],
                              //       style: TextStyle(
                              //           color: Colors.yellow[800],
                              //           fontSize: 20,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    )),
              )
            ];
          },
          body: Container(
            color: Colors.white,
          )),
    );
  }
}
