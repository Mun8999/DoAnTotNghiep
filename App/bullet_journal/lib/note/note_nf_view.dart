// @dart=2.9
import 'package:bullet_journal/note/note_nf_viewmodel.dart';
import 'package:bullet_journal/task/daily_task_nf/daily_task_nf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class NoteNewsFeedView extends StatefulWidget {
  const NoteNewsFeedView({Key key}) : super(key: key);

  @override
  _NoteNewsFeedViewState createState() => _NoteNewsFeedViewState();
}

double _spacing;
Size _size;
NoteViewNewsFeedViewModel _noteViewNewsFeedViewModel;

class _NoteNewsFeedViewState extends State<NoteNewsFeedView> {
  @override
  void initState() {
    _noteViewNewsFeedViewModel = NoteViewNewsFeedViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _spacing = _size.width * 0.02;
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
                  leadingWidth: 150,
                  leading: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Style',
                          style: GoogleFonts.sacramento(
                            fontSize: 25,
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
          color: Colors.white,
          child: StaggeredGridView.countBuilder(
            // controller: _staggredGridController,
            physics:
                NeverScrollableScrollPhysics(), // không scroll theo widget này
            // shrinkWrap: true,
            scrollDirection: Axis.vertical,
            crossAxisCount: 4,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Stack(children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 50),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // color: 100 * (index % 9) == 0
                        //     ? Colors.pink[50]
                        //     : Colors.pink[100 * (index % 9)],
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 1,
                              offset: Offset(2, 2))
                        ]),
                    child: SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: AssetImage(images[index]),
                              fit: BoxFit.cover),
                        ),
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
                          'Hellllo',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ]),
              );
            },
            // ignore: missing_return
            staggeredTileBuilder: (index) {
              return new StaggeredTile.count(2, 2);
              // return new StaggeredTile.count(
              //     2, snapshot.hasData ? snapshot.data[index] : 2);
            },
            // staggeredTileBuilder: (int index) =>
            //     new StaggeredTile.count(2, index.isEven ? 2 : 1),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          )),
    );
  }
}
