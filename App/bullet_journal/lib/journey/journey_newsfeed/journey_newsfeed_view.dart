//@dart=2.9
import 'dart:io';

import 'package:bullet_journal/database/db_journey.dart';
import 'package:bullet_journal/journey/journey_edit/journey_edit_view.dart';
import 'package:bullet_journal/task/daily_task_nf/daily_task_nf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class JourneyNewsfeedView extends StatefulWidget {
  @override
  _JourneyNewsfeedViewState createState() => _JourneyNewsfeedViewState();
}

// double spacing;
Size _size;
Box<JourneyDB> _journeyBox;

class _JourneyNewsfeedViewState extends State<JourneyNewsfeedView> {
  @override
  void initState() {
    _journeyBox = Hive.box<JourneyDB>('journeys');
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
                  leadingWidth: 100,
                  leading: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Journey',
                          style: GoogleFonts.sacramento(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
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
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: ValueListenableBuilder(
              valueListenable: _journeyBox.listenable(),
              builder: (context, Box<JourneyDB> journeys, child) {
                return StaggeredGridView.countBuilder(
                  // controller: _staggredGridController,
                  physics:
                      NeverScrollableScrollPhysics(), // không scroll theo widget này
                  // shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  itemCount: journeys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        // await Hive.openBox<JourneyDB>('journeys');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  JourneyEditView(2, journeys.getAt(index)),
                            ));
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
                                  _deleteJourney(_journeyBox,
                                      _journeyBox.getAt(index), index);
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
                        padding: EdgeInsets.all(_size.width * 0.02),
                        child: Stack(children: [
                          Container(
                            padding:
                                EdgeInsets.only(bottom: _size.width * 0.13),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(_size.width * 0.03),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 1,
                                      offset: Offset(2, 2))
                                ]),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(_size.width * 0.03),
                                image: DecorationImage(
                                    image: FileImage(File(
                                        journeys.getAt(index).jouneyImage)),
                                    // image: AssetImage(images[0]),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  journeys.getAt(index).journeyTitle,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                          )
                        ]),
                      ),
                    );
                  },
                  // ignore: missing_return
                  staggeredTileBuilder: (index) {
                    return new StaggeredTile.count(2, 3);
                  },
                  // staggeredTileBuilder: (int index) =>
                  //     new StaggeredTile.count(2, index.isEven ? 2 : 1),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                );
              },
            ),
          ),
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
                  // await Hive.openBox<JourneyDB>('journeys');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            JourneyEditView(1, JourneyDB(''))),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _deleteJourney(
      Box<JourneyDB> journeyBox, JourneyDB journeyDB, int index) async {
    await journeyBox.deleteAt(index);
    int boxIndex = journeyDB.boxId;
    var imageBox = await Hive.openBox<String>('images' + boxIndex.toString());
    if (imageBox.length > 0) imageBox.deleteFromDisk();
  }
}
