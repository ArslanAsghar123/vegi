import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vegi/data/list.dart';
import 'package:vegi/model/list_items.dart';
import 'package:vegi/provider/favorite_meals.dart';

class ListItemWidget extends StatelessWidget {
  ///Utils or Constant itemWidget to use whereever list is called
  final ListItem item;
  final Animation<double> animation;
  final VoidCallback onClicked;
  final String id;

  const ListItemWidget(
      {Key key,
      @required this.item,
      this.animation, this.id,
      @required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///select item by categoryID every item has a unique ID
    final selectedcategory = listItems.firstWhere((meal) => meal.id == item.id);

    ///function where items called by specific name
    Widget buildItem() {
      return Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: 500,
                      height: 200,
                      child: Image.asset(
                        item.imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Text(
                    'Ingrediants:  ${item.desc}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),

                  ///Provider to store favourite category and link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: Text('Read More')),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.link),
                            color: Colors.red,
                            onPressed: () {
                              launch(
                                  'https://pub.dev/packages/url_launcher/install');
                            },
                          ),
                          Consumer<FavoriteCategories>(
                            builder: (_, favoriteMealsData, __) => IconButton(
                                icon: Icon(
                                  favoriteMealsData.isFavorite(item.id)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                ),
                                onPressed: () {
                                  if (favoriteMealsData.isFavorite(item.id))
                                    favoriteMealsData.removeMealFromFavorites(
                                        selectedcategory.id,context);

                                  else
                                    favoriteMealsData
                                        .addMealToFavorites(selectedcategory,context);
                                }),
                          ),

                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1,
          ),
        ],
      );
    }

    return SizeTransition(
        key: ValueKey(item.imgUrl), sizeFactor: animation, child: buildItem());
  }
}
