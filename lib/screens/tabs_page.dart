import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi/main.dart';
import 'package:vegi/main.dart';
import 'package:vegi/screens/product.dart';

import '../main.dart';
import 'favorites_page.dart';



class TabsPage extends StatefulWidget {
  static const routeName = '/tabs';

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {

  ///tabs for switching between favorites and items
  final List<Map<String, dynamic>> _pages = [
    {
      'page': MyHomePage(),
      'title': 'Make My Meal',
    },
    {
      'page': FavoritesPage(),
      'title': 'Favorites',
    },
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ///search box for searching products
        title: TextField(
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: " Search...",
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              color: Color.fromRGBO(93, 25, 72, 1),
              onPressed: () {},
            ),
          ),
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
                child: IconButton(icon: Icon(Icons.person), onPressed: () {})),
          )
        ],
      ),
      ///drawer and bottom navigation bar
      drawer: Drawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor:Colors.black,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: "Home",
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
