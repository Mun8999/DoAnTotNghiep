//@dart=2.9
import 'package:bullet_journal/database/db_diary.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<Iterable<DiaryDB>> {
  final initDiaryData = [];
  final resultDiaryData = [];
  DataSearch();
  @override
  List<Widget> buildActions(BuildContext context) {
    // action for appbar
    return [IconButton(onPressed: () {}, icon: Icon(Icons.clear))];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of app bar
    return IconButton(
        onPressed: () {},
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    return Container();
  }
}
