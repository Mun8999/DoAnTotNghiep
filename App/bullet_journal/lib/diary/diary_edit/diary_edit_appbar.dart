// import 'package:flutter/material.dart';

// class DiaryEditAppBar extends StatefulWidget {
//   @override
//   _DiaryEditAppBarState createState() => _DiaryEditAppBarState();
// }

// class _DiaryEditAppBarState extends State<DiaryEditAppBar> {
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//           backgroundColor: Colors.white,
//           leading: IconButton(
//             onPressed: () {
//               setState(() {
//                 _isEditButtonTaped = false;
//                 // print('back' + _isEditButtonTaped.toString());
//               });
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios_rounded,
//               color: Colors.black,
//             ),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 // showMyBottomSheet();
//                 // DateTime dateTime = DateTime(2021, 1, 1);
//                 // String weekday = DateFormat.EEEE().format(dateTime);
//                 // print(weekday);
//                 setState(() {
//                   _focusTyping.requestFocus();
//                   _isEditButtonTaped = true;
//                   print('edit' + _isEditButtonTaped.toString());
//                 });
//               },
//               icon: Icon(
//                 Icons.edit,
//                 color: Colors.black,
//               ),
//             ),
//           ],
//           elevation: 1,
//     );
//   }
// }
