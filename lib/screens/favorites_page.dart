import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi/data/list.dart';
import 'package:vegi/model/list_items.dart';
import 'package:vegi/provider/favorite_meals.dart';
import 'package:vegi/widget/list_widget.dart';

class FavoritesPage extends StatelessWidget {
  final List<ListItem> items = List.from(listItems);

  @override
  Widget build(BuildContext context) {
    ///get list from provider data
    var favoriteMealsData = Provider.of<FavoriteCategories>(context);
    final listKey = GlobalKey<AnimatedListState>();

    if (favoriteMealsData.isWaiting) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    ///in no data case show txt and and after adding data call itemWidget to show data

    var favoriteMeals = favoriteMealsData.favoriteCategories;

    if (favoriteMeals.isEmpty) {
      return Center(
        child: NoFavorites(),
      );
    } else {
      return AnimatedList(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        key: listKey,
        initialItemCount: favoriteMeals.length,
        itemBuilder: (context, index, animation) => ListItemWidget(
          item: favoriteMeals[index],
          animation: animation,
          onClicked: () {},
        ),
      );
    }
  }
}

///you cam also un-favourite items from here
class NoFavorites extends StatelessWidget {
  const NoFavorites({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Icon(
            Icons.favorite,
            size: 100,
            color: Colors.grey.withOpacity(0.3),
          ),
          Text(
            "No Favorites!",
            softWrap: true,
            style: TextStyle(
              fontSize: 30,
              color: Colors.grey.withOpacity(0.5),
              // fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Mark your favorite meals\n so you can easily find them here.',
            style: TextStyle(
              color: Colors.grey.withOpacity(0.8),
              // fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
              fontSize: 18,
            ),
            softWrap: true,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
