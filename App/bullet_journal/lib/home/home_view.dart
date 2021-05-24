// @dart=2.9
import 'package:bullet_journal/edit_image/edit_image_view.dart';
import 'package:bullet_journal/task/daily_task/daily_task_nf_view.dart';
import 'package:bullet_journal/diary/diary_edit/diary_edit_view.dart';
import 'package:bullet_journal/diary/diary_newsfeed/diary_nf_view.dart';
import 'package:bullet_journal/journey_newsfeed/journey_newsfeed_view.dart';
import 'package:bullet_journal/model/diary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

Size size;
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
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.black,
                ))
          ],
        ),
        body: Container(
          height: size.height,
          // padding: const EdgeInsets.all(10),
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: buildGridMenu(),
              ),
              Positioned(
                left: 0,
                top: size.height * 0.565,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: size.width - 20,
                    height: size.height * 0.2,
                    decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget buildGridMenu() {
    return Container(
      width: size.width,
      height: size.height * 0.6,
      child: StaggeredGridView.countBuilder(
        physics: NeverScrollableScrollPhysics(), // không scroll theo widget này
        // shrinkWrap: true,
        scrollDirection: Axis.vertical,
        crossAxisCount: 4,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
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
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.yellow[(index + 4) * 100],
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  menus[index],
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) {
          return new StaggeredTile.count(2, index.isEven ? 3 : 2);
        },
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
    );
  }
  // Widget buildGridMenu() {
  //   return Container(
  //     height: size.height * 0.45,
  //     width: size.width,
  //     color: Colors.grey[400],
  //     child: GridView.builder(
  //       itemCount: 4,
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
  //       itemBuilder: (context, index) {
  //         return InkWell(
  //           onTap: () {
  //             switch (index) {
  //               case 0:
  //                 {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => DiaryNewFeedsView(),
  //                       ));
  //                 }
  //                 break;
  //               case 1:
  //                 {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => DailyTaskNewsFeedView(),
  //                       ));
  //                 }
  //                 break;
  //               case 2:
  //                 {
  //                   Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => JourneyNewsfeedView(),
  //                       ));
  //                 }
  //                 break;
  //               case 3:
  //                 {
  //                   Navigator.push(context, MaterialPageRoute(
  //                     builder: (context) {
  //                       Diary diary = Diary('', '', '', DateTime.now());
  //                       return DiaryEditView(diary);
  //                     },
  //                   ));
  //                 }
  //                 break;
  //               default:
  //                 return;
  //             }
  //           },
  //           child: Padding(
  //             padding: const EdgeInsets.all(10),
  //             child: Stack(
  //               children: [
  //                 Container(
  //                   height: size.width / 2,
  //                   width: size.width / 2,
  //                   decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(10)),
  //                 ),
  //                 Align(
  //                   alignment: Alignment.center,
  //                   child: Container(
  //                       height: size.width / 4,
  //                       width: size.width / 4,
  //                       color: Colors.white,
  //                       child: SvgPicture.asset(menuImages[index])),
  //                 ),
  //                 Align(
  //                     alignment: Alignment.bottomCenter,
  //                     child: Container(
  //                         margin: EdgeInsets.only(bottom: 10),
  //                         child: Text(
  //                           menus[index],
  //                           style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.yellow[900]),
  //                         )))
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
