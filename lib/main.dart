import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegi/provider/favorite_meals.dart';
import 'package:vegi/screens/email_code.dart';
import 'package:vegi/screens/tabs_page.dart';

///region the main function where we check email store on not
Future<void> main() async {
  ///region initialize sharedpreference
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  ///endregion
  var email = prefs.getString('email');
  print(email);
  runApp(
    ///region provider for state management
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteCategories()),
      ],
      builder: (_, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: email == null ? Welcome() : TabsPage())),
  ///endregion
  );
}
///endregion


