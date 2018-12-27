import 'package:flutter/material.dart';
import 'package:lintellectuel_mobile/design_items/carroussel.dart';
import 'package:lintellectuel_mobile/design_items/categories_listview.dart';
import 'package:lintellectuel_mobile/design_items/post_listview.dart';

class HomeRoute2 extends StatelessWidget{
  const HomeRoute2();

  @override
  Widget build(BuildContext context) {
    return
    Container(            color: Colors.black,
child: Column(

  children: <Widget>[
    Expanded(child:

    ListView(shrinkWrap: true, children: <Widget>[


      Container(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50,left: 10),

            ),
            CategoriesListView(),


          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.all(50),
      )
    ])),

  ],
)
        ,);



  }


}