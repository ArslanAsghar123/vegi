import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegi/data/list.dart';
import 'package:vegi/model/list_items.dart';


///provider for state management

class FavoriteCategories with ChangeNotifier {
  ///initial empty list before any use
  List<ListItem> _favoriteCategory = [];
  Set<String> _favoriteCategoryIds = {};
  bool _isWaiting = false;

  ///for local storage use share preference to store favourite items

  final String _sharedPrefKey = 'favoriteMealIds';

  FavoriteCategories() {
    _load();
  }

  List<ListItem> get favoriteCategories => List<ListItem>.from(_favoriteCategory);

  bool get isWaiting => _isWaiting;
///Load and save data to local storage
  void _load() => _store(load: true);

  void _save() => _store();

  bool isFavorite(String mealId) {
    return _favoriteCategoryIds.contains(mealId);
  }
///when heart pressed an item added to storage
  void addMealToFavorites(ListItem meal, context) {
    var snackBar = SnackBar(
      content: Text('Bookmark Added'),
      duration: const Duration(seconds: 1),
    );

    if (_favoriteCategoryIds.add(meal.id)) {
      _favoriteCategory.insert(0, meal);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      notifyListeners();
      _save();
    }
  }
///when heart un sleect item and item removed from storage
  void removeMealFromFavorites(String mealId, context) {
    var snackBar = SnackBar(
      content: Text('Bookmark Removed'),
      duration: const Duration(seconds: 1),
    );

    if (_favoriteCategoryIds.remove(mealId)) {
      int index = _favoriteCategory.indexWhere((meal) => meal.id == mealId);
      _favoriteCategory.removeAt(index);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      notifyListeners();
      _save();
    }
  }

  void _store({bool load = false}) async {
    _isWaiting = true;

    notifyListeners();

    /// artificial delay to see the UI changes
    /// await Future.delayed(Duration(milliseconds: 2000));

    try {
      final pref = await SharedPreferences.getInstance();

      if (load) {
        _favoriteCategoryIds = pref.getStringList(_sharedPrefKey).toSet();

        listItems.forEach((meal) {
          if (_favoriteCategoryIds.contains(meal.id)) _favoriteCategory.add(meal);
        });
      } else {
        await pref.setStringList(_sharedPrefKey, _favoriteCategoryIds.toList());
      }
    } catch (error) {
      _favoriteCategoryIds = {};
      _favoriteCategory = [];
    }
    _isWaiting = false;

    notifyListeners();
  }
}
