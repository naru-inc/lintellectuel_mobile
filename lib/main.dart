import 'package:flutter/material.dart';
import 'package:lintellectuel_mobile/design_items/backdrop.dart';
import 'package:lintellectuel_mobile/routes/home_route2.dart';
import 'routes/home_route.dart';
import 'models/category.dart';

void main() {
  runApp(LintellectuelApp());
}


class LintellectuelApp extends StatefulWidget {
  @override
  _LintellectuelAppState createState() => _LintellectuelAppState();
}
/// This widget is the root of our application.
/// Currently, we just show one widget in our app.
class _LintellectuelAppState extends State<LintellectuelApp> {
  Category _currentCategory = Category(id: 2,name:"À La Une" );
  @override
  Widget build(BuildContext context) {
    // TODO: imp(lement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'L\'intellectuel',
        home: new  Backdrop(
          frontLayer: HomeRoute(),
          backLayer: HomeRoute2(),
        ),
    );
  }

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }


}
