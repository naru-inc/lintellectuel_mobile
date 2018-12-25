import 'package:flutter/material.dart';
import 'package:lintellectuel_mobile/design_items/backdrop.dart';
import 'package:lintellectuel_mobile/routes/home_route2.dart';
import 'routes/home_route.dart';

void main() {
  runApp(LintellectuelApp());
}

/// This widget is the root of our application.
/// Currently, we just show one widget in our app.
class LintellectuelApp extends StatelessWidget {
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
}
