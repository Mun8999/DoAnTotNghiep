// @dart=2.9
import 'package:bullet_journal/database/db_note.dart';
import 'package:bullet_journal/model/calendar/time.dart';
import 'package:bullet_journal/note/note_edit_view.dart';
import 'package:bullet_journal/note/note_nf_viewmodel.dart';
import 'package:bullet_journal/task/daily_task_nf/daily_task_nf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteNewsFeedView extends StatefulWidget {
  const NoteNewsFeedView({Key key}) : super(key: key);

  @override
  _NoteNewsFeedViewState createState() => _NoteNewsFeedViewState();
}

// double _spacing;
Size _size;
NoteViewNewsFeedViewModel _noteViewNewsFeedViewModel;
Box<NoteDB> _noteBox;

class _NoteNewsFeedViewState extends State<NoteNewsFeedView> {
  @override
  void initState() {
    _noteViewNewsFeedViewModel = NoteViewNewsFeedViewModel();
    _noteBox = Hive.box<NoteDB>('notes');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return NestedScrollView(
      physics: NeverScrollableScrollPhysics(),
      headerSliverBuilder: (context, value) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  backgroundColor: Colors.white,
                  leadingWidth: 80,
                  leading: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Note',
                          style: GoogleFonts.sacramento(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // Text(
                        //   'Style',
                        //   style: GoogleFonts.righteous(
                        //     fontSize: 25,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.yellow[900],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
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
                  elevation: 1,
                )),
          )
        ];
      },
      body: Container(
        width: _size.width,
        height: _size.height,
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.all(_size.width * 0.02),
                color: Colors.white,
                child: ValueListenableBuilder(
                  builder:
                      (BuildContext context, Box<NoteDB> notes, Widget child) {
                    print('lengt' + notes.values.length.toString());
                    notes.values.forEach((element) {
                      print('note' + element.noteTitle);
                    });
                    return GridView.builder(
                      physics:
                          NeverScrollableScrollPhysics(), // không scroll theo widget này
                      // shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: notes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () async {
                            // await Hive.openBox<NoteDB>('notes');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoteEditView(
                                        2,
                                        _noteBox.getAt(index),
                                      )),
                            );
                          },
                          onLongPress: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Cảnh báo',
                                    style: TextStyle(color: Colors.red)),
                                content: const Text(
                                    'Bạn có chắc chắn muốn xóa\nhoạt động này không?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      _noteBox.deleteAt(index);
                                      Navigator.pop(context, 'Có');
                                    },
                                    child: const Text('Có'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Không'),
                                    child: const Text('Không'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(_size.width * 0.04),
                              color: Colors.amber[200],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(_size.width * 0.02),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          notes.getAt(index).noteTitle,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          notes.getAt(index).noteContent,
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      _noteBox
                                              .getAt(index)
                                              .noteTime
                                              .day
                                              .toString() +
                                          ' tháng ' +
                                          _noteBox
                                              .getAt(index)
                                              .noteTime
                                              .month
                                              .toString(),
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      MyDateTime(_noteBox.getAt(index).noteTime)
                                          .getTime
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: _size.width * 0.02,
                          crossAxisSpacing: _size.width * 0.02),
                      // ignore: missing_return

                      // staggeredTileBuilder: (int index) =>
                      //     new StaggeredTile.count(2, index.isEven ? 2 : 1),
                    );
                  },
                  valueListenable: _noteBox.listenable(),
                )),
            Positioned(
              right: _size.width * 0.04,
              bottom: _size.width * 0.04,
              child: ButtonTheme(
                minWidth: _size.height * 0.07,
                height: _size.height * 0.07,
                child: RaisedButton(
                  focusElevation: 2,
                  shape: CircleBorder(),
                  color: Colors.amber[500],
                  child: Icon(Icons.add),
                  elevation: 1,
                  onPressed: () async {
                    // NoteDB noteDB =
                    //     NoteDB(0, 'nganha se lam duoc', 'dkfnsdnfsdfnsd', 0);
                    // _noteBox.add(noteDB);
                    await Hive.openBox<NoteDB>('texts');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NoteEditView(1, NoteDB('', ''))),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
