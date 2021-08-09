// @dart=2.9
import 'package:bullet_journal/database/db_diary.dart';
import 'package:bullet_journal/login/login_view.dart';
import 'package:bullet_journal/note/note_nf_view.dart';
import 'package:bullet_journal/widget/bottom_navigator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bullet_journal/task/daily_task_nf/daily_task_nf_view.dart';
import 'package:bullet_journal/diary/diary_newsfeed/diary_nf_view.dart';
import 'package:bullet_journal/journey/journey_newsfeed/journey_newsfeed_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

Size size;
Widget _centerSreen;
Color _selectedColor;

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    _centerSreen = DiaryNewFeedsView();
    _selectedColor = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: _centerSreen,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        onPressed: () {
          setState(() {
            _centerSreen = DiaryNewFeedsView();
            _selectedColor = Colors.black38;
          });
        },
        child: SvgPicture.asset(
          'assets/icons/menu/home-with-hearth.svg',
          height: 30,
          width: 30,
          color: Colors.white,
        ),
        elevation: 2.0,
      ),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Nhật ký',
        color: Colors.black38,
        backgroundColor: Colors.white,
        selectedColor: _selectedColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (value) {
          _selectedColor = Colors.black;
          switch (value) {
            case 0:
              {
                setState(() {
                  _centerSreen = JourneyNewsfeedView();
                });
                break;
              }
            case 1:
              {
                setState(() {
                  _centerSreen = NoteNewsFeedView();
                });
                break;
              }
            default:
              break;
          }
          // switch (value) {
          //   case 0:
          //     {
          //       setState(() {
          //         _centerSreen = DailyTaskNewsFeedView();
          //       });
          //       break;
          //     }
          //   case 1:
          //     {
          //       setState(() {
          //         _centerSreen = JourneyNewsfeedView();
          //       });
          //       break;
          //     }
          //   case 2:
          //     {
          //       setState(() {
          //         _centerSreen = NoteNewsFeedView();
          //       });
          //       break;
          //     }
          //   case 3:
          //     {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => LoginView(),
          //           ));
          //       break;
          //     }
          //   default:
          //     break;
          // }
        },
        items: [
          // FABBottomAppBarItem(
          //     iconData:
          //         'assets/icons/menu/black-paper-calendar-with-spring.svg',
          //     text: 'Hoạt động'),
          FABBottomAppBarItem(
              iconData: 'assets/icons/menu/airplane-facing-left.svg',
              text: 'Chuyến đi'),
          FABBottomAppBarItem(
              iconData: 'assets/icons/menu/blank-page-folded-corner.svg',
              text: 'Ghi chú'),
          // FABBottomAppBarItem(
          //     iconData: 'assets/icons/menu/black-user-shape.svg',
          //     text: 'Tài khoản'),
        ],
      ),
    );
  }
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
