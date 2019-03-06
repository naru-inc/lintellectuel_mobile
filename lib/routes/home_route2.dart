import 'package:flutter/material.dart';
import 'package:lintellectuel_mobile/design_items/categories_listview.dart';
import 'package:lintellectuel_mobile/models/category.dart';

class HomeRoute2 extends StatelessWidget {
  final ValueChanged<Category> onCategoryTap;
  const HomeRoute2({Key key, @required this.onCategoryTap});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Expanded(
              child: ListView(shrinkWrap: true, children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 50, left: 10),
                  ),
                  CategoriesListView(onCategoryTap: onCategoryTap),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(50),
            )
          ])),
        ],
      ),
    );
  }
}
