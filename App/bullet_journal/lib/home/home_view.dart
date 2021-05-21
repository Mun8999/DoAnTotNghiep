// @dart=2.9
import 'package:bullet_journal/task/daily_task/daily_task_nf_view.dart';
import 'package:bullet_journal/diary/diary_edit/diary_edit_view.dart';
import 'package:bullet_journal/diary/diary_newsfeed/diary_nf_view.dart';
import 'package:bullet_journal/journey_newsfeed/journey_newsfeed_view.dart';
import 'package:bullet_journal/model/diary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

Size size = Size(0, 0);
List<String> menuImages = [
  'assets/icons/menu/001-unicorn.svg',
  'assets/icons/menu/002-unicorn.svg',
  'assets/icons/menu/012-unicorn.svg',
  'assets/icons/menu/013-unicorn.svg'
];
List<String> menus = ['Nhật ký', 'Hoạt động', 'Chuyến đi', 'Ghi chú'];

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Trang chủ',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        backgroundColor: Colors.grey[400],
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: buildGridMenu(),
        ));
  }

  Widget buildGridMenu() {
    return Container(
      height: size.height * 0.45,
      width: size.width,
      color: Colors.grey[400],
      child: GridView.builder(
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              switch (index) {
                case 0:
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiaryNewFeedsView(),
                        ));
                  }
                  break;
                case 1:
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailyTaskNewsFeedView(),
                        ));
                  }
                  break;
                case 2:
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JourneyNewsfeedView(),
                        ));
                  }
                  break;
                case 3:
                  {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        Diary diary = Diary('', '', '', DateTime.now());
                        return DiaryEditView(diary);
                      },
                    ));
                  }
                  break;
                default:
                  return;
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Container(
                    height: size.width / 2,
                    width: size.width / 2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: size.width / 4,
                        width: size.width / 4,
                        color: Colors.white,
                        child: SvgPicture.asset(menuImages[index])),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            menus[index],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[900]),
                          )))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
