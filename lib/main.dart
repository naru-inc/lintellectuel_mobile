import 'package:flutter/material.dart';

import 'design_items/carroussel.dart';
void main() {
  runApp(LintellectuelApp());
}

/// This widget is the root of our application.
/// Currently, we just show one widget in our app.
class LintellectuelApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: imp(lement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'L\'intellectuel',
      home: Carroussel()
    );
  }
}