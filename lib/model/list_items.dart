import 'package:flutter/cupertino.dart';



///model class of items
class ListItem {
  final String id;
  final String title;
  final String desc;
  final String imgUrl;

  ListItem({
    @required this.id,
    @required this.title,
    @required this.desc,
    @required this.imgUrl,
  });
}
