import 'package:bullet_journal/model/diary.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DiaryEditView extends StatefulWidget {
  Diary diary;
  DiaryEditView(this.diary);
  @override
  _DiaryEditViewState createState() => _DiaryEditViewState();
}

class _DiaryEditViewState extends State<DiaryEditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
          margin: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [],
          )
          // Text(
          //   widget.diary.diaryTitle.toString(),
          //   style: TextStyle(color: Colors.white),
          // )
          ),
    );
  }
}
