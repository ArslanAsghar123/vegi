import 'package:flutter/material.dart';
import 'package:vegi/data/list.dart';
import 'package:vegi/model/list_items.dart';
import 'package:vegi/screens/tabs_page.dart';
import 'package:vegi/widget/list_widget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final listKey = GlobalKey<AnimatedListState>();

  ///fetch list from listitems
  final List<ListItem> items = List.from(listItems);

  ///list generated of items and animation list for animation of list
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedList(
        key: listKey,
        initialItemCount: items.length,
        itemBuilder: (context, index, animation) => ListItemWidget(
          item: items[index],
          animation: animation,
          onClicked: () {},
        ),
      ),
    );
  }
}
